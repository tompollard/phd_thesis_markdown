---LaTeXTableShortCapts – enable `.unlisted` and `short-caption=""` properties
--                        for Pandoc conversion to LaTeX

--[[
Copyright (c) 2019 Blake Riley

Permission to use, copy, modify, and/or distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright notice
and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
THIS SOFTWARE.
]]
local List = require 'pandoc.List'

-- don't do anything unless we target latex
if FORMAT ~= "latex" then
  return {}
end

--- Code for injection into the LaTeX header,
--  to overwrite a macro in longtable captions.
longtable_caption_mod = [[
% -- begin:latex-table-short-captions --
\makeatletter\AtBeginDocument{%
\def\LT@c@ption#1[#2]#3{%                 % Overwrite the workhorse macro used in formatting a longtable caption.
  \LT@makecaption#1\fnum@table{#3}%
  \@ifundefined{pandoctableshortcapt}
     {\def\@tempa{#2}}                    % Use default behaviour: argument in square brackets
     {\let\@tempa\pandoctableshortcapt}   % If defined (even if blank), use to override
  \ifx\@tempa\@empty\else                 % If @tempa is blank, no lot entry! Otherwise, @tempa becomes the lot title.
     {\let\\\space
     \addcontentsline{lot}{table}{\protect\numberline{\thetable}{\@tempa}}}%
  \fi}
}\makeatother
% -- end:latex-table-short-captions --
]]

--- Creates a def shortcaption block to be placed before the table
-- @tparam ?string sc : The short-caption property value
-- @treturn Plain : The def shortcaption block
local function defshortcapt(sc)
  local scblock = List:new{}
  scblock:extend {pandoc.RawInline('tex', "\\def\\pandoctableshortcapt{")}
  if sc then
    scblock:extend (pandoc.read(sc).blocks[1].c)
  end
  scblock:extend {pandoc.RawInline('tex', "}")}
  if not sc then
    scblock:extend {pandoc.RawInline('tex', "  % .unlisted")}
  end
  return pandoc.Plain(scblock)
end

--- The undef shortcaption block to be placed after the table
local undefshortcapt = pandoc.RawBlock('tex', "\\let\\pandoctableshortcapt\\relax")

--- Parses a mock "Table Attr".
-- We use the Attr of an empty Span as if it were Table Attr.
-- This function extracts what is needed to build a short-caption.
-- @tparam Attr attr : The Attr of the property Span in the table caption
-- @treturn ?string : The identifier
-- @treturn ?string : The "short-caption" property, if present.
-- @treturn bool : Whether ".unlisted" appeared in the classes
local function parse_table_attrs(attr)
  -- Find label
  local label = nil
  if attr.identifier and (#attr.identifier > 0) then
    label = attr.identifier
  end

  -- Look for ".unlisted" in classes
  local unlisted = false
  if attr.classes:includes("unlisted") then
    unlisted = true
  end

  -- If not unlisted, then find the property short-caption.
  local short_caption = nil
  if not unlisted then
    if (attr.attributes["short-caption"]) and
       (#attr.attributes["short-caption"] > 0) then
      short_caption = attr.attributes['short-caption']
    end
  end

  return label, short_caption, unlisted
end

function is_properties_span(inl)
  return (inl.t) and (inl.t == "Span")                      -- is span
                 and (inl.content) and (#inl.content == 0)  -- is empty span
end

--- Parse the caption for Pandoc < 2.10
-- @tparam Table tbl : The table with {}-wrapped properties in the caption
-- @treturn ?string : The "short-caption" property, if present.
-- @treturn bool : Whether ".unlisted" appeared in the classes
function parse_short_caption_legacy(tbl)
  local caption = tbl.caption

  -- Escape if there is no caption present.
  if not caption or #caption == 0 then
    return nil
  end

  -- Try find the properties block
  local propspan, idx = caption:find_if(is_properties_span)

  -- If we couldn't find properties, escape.
  if not propspan then
    return nil
  end

  -- Otherwise, parse it all
  local label, short_caption, unlisted = parse_table_attrs(propspan.attr)

  -- Excise the span from the caption
  caption[idx] = nil

  -- Put label back into caption for pandoc-crossref
  if label then
    caption:extend {pandoc.Str("{#"..label.."}")}
  end

  -- set new caption
  tbl.caption = caption

  return short_caption, unlisted
end

--- Parse the caption for Pandoc >= 2.10
-- @tparam Table tbl : The table with {}-wrapped properties in the caption
-- @treturn ?string : The "short-caption" property, if present.
-- @treturn bool : Whether ".unlisted" appeared in the classes
function parse_short_caption(tbl)
  local caption = pandoc.List(tbl.caption.long)

  -- Escape if there is no caption present.
  if #caption == 0 then
    return nil
  end

  -- Try find the properties block
  local find_properties = function (list)
    for bidx, block in ipairs(list) do
      local propspan, idx = block.content:find_if(is_properties_span)
      if propspan then
        return propspan, bidx, idx
      end
    end
  end
  local propspan, bidx, idx = find_properties(caption)

  -- If we couldn't find properties, escape.
  if not propspan then
    return nil
  end

  -- Otherwise, parse it all
  local label, short_caption, unlisted = parse_table_attrs(propspan.attr)

  -- Excise the span from the caption
  caption[bidx].content[idx] = nil

  -- Put label back into caption for pandoc-crossref
  if label then
    caption[bidx].content:extend {pandoc.Str("{#"..label.."}")}
  end

  -- set new caption
  tbl.caption.long = caption
  tbl.caption.short = short_caption
    and pandoc.read(short_caption, FORMAT).blocks[1].content
    or nil

  return short_caption, unlisted
end

--- Wraps a table with shortcaption code
-- @tparam Table tbl : The table with {}-wrapped properties in the caption
-- @treturn List[Blocks] : The table with {label} in the caption,
--                         optionally wrapped in shortcaption code
function rewrite_longtable_caption(tbl)
  local short_caption, unlisted
  if PANDOC_VERSION >= {2,10} then
    short_caption, unlisted = parse_short_caption(tbl)
  else
    short_caption, unlisted = parse_short_caption_legacy(tbl)
  end

  -- Place new table
  local result = List:new{}
  if short_caption or unlisted then
    result:extend {defshortcapt(short_caption)}
  end
  result:extend {tbl}
  if short_caption or unlisted then
    result:extend {undefshortcapt}
  end
  return result
end

--- Inserts longtable_caption_mod into the header_includes
-- @tparam Meta meta : The document metadata
-- @treturn Meta : The document metadata, with replacement LaTeX macro
--                 in header_includes
function add_longtable_caption_mod(meta)
  local header_includes = -- test ? a : b
    (meta['header-includes'] and meta['header-includes'].t == 'MetaList')
    and meta['header-includes']
    or pandoc.MetaList{meta['header-includes']}
  header_includes[#header_includes + 1] =
    pandoc.MetaBlocks{pandoc.RawBlock('tex', longtable_caption_mod)}
  meta['header-includes'] = header_includes
  return meta
end

return {
  {
    Meta = add_longtable_caption_mod,
    Table = rewrite_longtable_caption,
  }
}
