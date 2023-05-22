# Template for writing a PhD thesis in Markdown [![Build Status](https://travis-ci.org/tompollard/phd_thesis_markdown.svg?branch=master)](https://travis-ci.org/tompollard/phd_thesis_markdown)  

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.58490.svg)](http://dx.doi.org/10.5281/zenodo.58490)

This repository provides a framework for writing a PhD thesis in Markdown. I used the template for my PhD submission to University College London (UCL), but it should be straightforward to adapt suit other universities too.

## Citing the template

If you have used this template in your work, please cite the following publication:

> Tom Pollard et al. (2016). Template for writing a PhD thesis in Markdown. Zenodo. http://dx.doi.org/10.5281/zenodo.58490

## Installation

1. Install [`pandoc`](https://pandoc.org/releases.html). **This repository requires `pandoc` 3.1+**, so if you install `pandoc` using a package manager (e.g. `apt`), check that it meets the version requirement. Otherwise, install by following the link.
2. Install [`pandoc-crossref`](https://github.com/lierdakil/pandoc-crossref#installation), a `pandoc` filter for numbering and cross-referencing figures, tables, sections and code blocks.
3. Install the required TeX packages to enable compilation to PDF.

### Quickstart for Mac Users
If you're a Mac user and you have `conda` and `brew` installed, run the following in your terminal to install `pandoc` and TeX packages (steps 1 & 3):
```bash
# get texlive
brew install --cask mactex

# update tlmgr and packages
sudo tlmgr update --self

# make python venv and install pandoc
conda create -n phd -y python=3.7 pandoc
conda activate phd

# Install required python and texlive packages
make install
```
### Notes for Linux Users
There are several ways to install TeXLive. [This guide](https://help.ubuntu.com/community/LaTeX) (written for Ubuntu) may be useful. In short, you can:

1. Install TeXLive from repositories (for Ubuntu, autocomplete `apt install texlive` to see all available packages), or;
2. Install TeXLive manually and use the package manager (`tlmgr`) to install required packages. If you go down this route, you can run `make install` to install required TeXLive packages.

## Handy references

- [`pandoc` User Guide](https://pandoc.org/MANUAL.html) for Markdown syntax for figures, tables, lists, etc., as well as information on flags that can be used when calling `pandoc`
- [`pandoc-crossref` manual](https://lierdakil.github.io/pandoc-crossref/) which outlines syntax and customisation options for cross-referencing (e.g. should the figure prefix be "fig,", "Fig." or "Figure")
- [This `README`](https://github.com/pandoc/lua-filters/blob/master/short-captions/README.md) for `pandoc-crossref`-compatible syntax to have shorter captions for figures in the List of Figures (PDF/LaTeX output only)
- [This `README`](https://github.com/pandoc/lua-filters/blob/master/table-short-captions/README.md) for `pandoc-crossref`-compatible syntax to have shorter captions for tables in the List of Tables (PDF/LaTeX output only)

## Should I use this template?

### Why write my thesis in Markdown?

Markdown is a super-friendly plain text format that can be easily converted to a bunch of other formats like PDF, Word and LaTeX. You'll enjoy working in Markdown because:
- it is a clean, plain-text format...
- ...but you can use LaTeX when you need it (for example, in laying out mathematical formula).
- it doesn't suffer from the freezes and crashes that some of us experience when working with large, image-heavy Word documents.
- it automatically handles the table of contents, bibliography etc with `pandoc`.
- comments, drafts of text, etc can be added to the document by wrapping them in &lt;!--  --&gt;
- it works well with Git, so keeping backups is straightforward. Just commit the changes and then push them to your repository.
- it is able to take advantage of autocompletion capabilities for figures and citations in several text editors (VSCode, Sublime, etc.)
- there is no lock-in. If you decide that Markdown isn't for you, then just output to Word, or whatever, and continue working in the new format.

### Are there any reasons not to use Markdown?

There are some minor annoyances:
- if you haven't worked with Markdown before then you'll find yourself referring to the style-guide (`pandoc` User Guide) fairly often at first.
- Some niche and more complicated requirements will require writing raw LaTeX, which won't appear in other output formats. In the worst case, it will require diving into Haskell or Lua filters for `pandoc`
- the style documents in this framework could be improved. The PDF and HTML (thanks [@ArcoMul](https://github.com/ArcoMul)) outputs are acceptable, but ~~HTML and~~ Word needs work if you plan to output to this format.  
- ... if there are more, please add them here.

## Detailed template information

### How is the template organised?

- README.md => these instructions.
- License.md => terms of reuse (MIT license).
- Makefile => contains instructions for using `pandoc` to produce the final thesis.
- output/ => directory to hold the final version.
- source/ => directory to hold the thesis content. Includes the references.bib file.
- scratch/ => directory to hold tables which can be converted between different formats.
- source/figures/ => directory to hold the figures.
- style/ => directory to hold the style documents.

### How do I get started?

1. Install the software outlined above, as well as:
    - A text editor, like [Sublime](https://www.sublimetext.com/), which is what you'll use write the thesis.  
    - Git, for version control.
2. [Fork the repository](https://github.com/tompollard/phd_thesis_markdown/fork) on Github  
3. Clone the repository onto your local computer (or [download the Zip file](https://github.com/tompollard/phd_thesis_markdown/archive/master.zip)).
4. (Skip this step to use default UCL style) Configure style for your institution. See instructions below
5. Navigate to the directory that contains the Makefile and type "make pdf" (or "make html") at the command line to update the PDF (or HTML) in the output directory.  
**In case of an error** (e.g. `make: *** [pdf] Error 43`), consult [this article](https://dalwilliams.com/lessons-learned-from-writing-a-phd-dissertation-in-markdown.html) for possible fixes. Most importantly, make sure tlmgr is properly installed, then run ```install.sh``
6. Edit the files in the 'source' directory, then goto step 5.

### How does it work?
The universal document converter [`pandoc`](https://pandoc.org/) does all the heavy lifting. For example:

-  `make pdf` (the code under `pdf: ...` in [`Makefile`](./Makefile)) runs `pandoc` which takes as input
    1. the markdown files which contain the writing content: `input/*.md`
    1. a yaml file with metadata: `input/metadata.yml`
    1. a LaTeX template: `style/template.tex`
    1. a LaTeX header: `style/preamble.tex`
    1. a BibTeX file of your references: `input/references.bib`
    1. a csl style file for citations: `style/ref_format.csl`
    1. a bunch of options which change the output e.g. `--number-sections`
1. the output produced is:
    1. the generated pdf: [`output/thesis.pdf`](./output/thesis.pdf)
    1. logs (which contain the `.tex` which was compiled): `pandoc.pdf.log`

Put simply, `pandoc` uses the latex template provided to create a `.tex` file, then compiles it. In detail, `pandoc` processes the input files in the following way (the file names in quotes aren't visible to you, but are named for the purpose of understanding):
1. Make replacements within the markdown files `input/*.md` e.g.:
    * references to figures, captions, and sections are handled: `@fig:my_fig` -> `\ref{fig:my_fig}`
    * equations are converted to LaTeX and numbered: `$$f(x) = ax^3 + bx^2 + cx + d$$ {#eq:my_equation}` -> `\begin{equation}f(x) = ax^3 + bx^2 + cx + d\label{eq:my_equation}\end{equation}`
    * citations are handled: `[@Cousteau1963]` -> `(Cousteau Jacques & Dugan James 1963)`
    * see `input/*.md` for more examples!
1. Create "`body.tex`" by:
    * converting all the `*.md` files **in the order that they were stated** in the `pandoc` call
1. Create "`main.tex`" from `style/template.tex` by running code wrapped in `$` signs. The important things to note are:
    * this populates `style/template.tex` with metadata from `input/metadata.yml` and the arguments from the `pandoc` call
    * "`body.tex`" is pasted in verbatim in place of `$body$`
1. Create "`references.tex`" by converting `./input/references.bib`
1. Concatenate files together to create the final `thesis.tex` = `style/preamble.tex` + "`main.tex`" + "`references.tex`"
1. Compile `thesis.tex` (you can see the logs for this process, and what "`thesis.tex`" would look like in `pandoc.pdf.log`)
    * **TIP**: You can also generate and view `output/thesis.tex` by running `make tex` - this follows all the above steps, bar the final compilation

### What else do I need to know?

Some useful points, in a random order:
- if you only care about generating `thesis.pdf` you can always fall back on writing LaTeX within the markdown files (but note that `thesis.html` and other outputs will not be able to render this)
- the markdown files you write (i.e. your chapters) will be compiled in alphabetical order, so keep the filenames sorted in the order you want them to appear e.g. `01_chapter_1.md`, `02_chapter_2.md`, etc. This is required because of the way we have written `make pdf`. You can change this behaviour by writing a custom `pandoc` command instead of using `make pdf`.
- each chapter must finish with at least one blank line, otherwise the header of the following chapter may not be picked up.
- add two spaces at the end of a line to force a line break.
- PDFs are generated using the LaTeX templates in the style directory. Fonts etc can be changed in the TeX templates.
- To change the citation style, just overwrite ref_format.csl with the new style. Style files can be obtained from [citationstyles.org/](http://citationstyles.org/)
- For fellow web developers, there is a Grunt task file (Gruntfile.js) which can be used to 'watch' the markdown files. By running `$ npm install` and then `$ npm run watch` the PDF and HTML export is done automatically when saving a Markdown file.
- You can automatically reload the HTML page on your browser using LiveReload with the command `$ npm run livereload`. The HTML page will automatically reload when saving a Markdown file after the export is done.

# Troubleshooting
1. The first thing to try if the `make *` command fails is a simpler build, e.g. if `make pdf` failed, try `make tex` to see if that fails too.
2. If tex compilation is failing (i.e. `make tex` works but `make pdf` fails), try updating tex live and/or packages. For example, if you get the error `make: *** [pdf] Error 43`, have a look in `pandoc.pdf.log` for the error. If it is something like
```
`l3backend-xdvipdfmx.def' not found
```
then try:
```bash
sudo tlmgr update --self
sudo tlmgr l3backend
# Full nuclear option - update *all* the packages! (takes about 10m)
# sudo tlmgr update --all
```
3. Try reinstalling everything from scratch (tip: check out [`.travis.yml`](./.travis.yml))
3. Search the [github issues](https://github.com/tompollard/phd_thesis_markdown/issues) and [pull requests](https://github.com/tompollard/phd_thesis_markdown/pulls) in this repo

# Contributing

Contributions to the template are encouraged! There are lots of things that could be improved, like:
- cleaning up the LaTeX templates, which are messy at the moment.
- improving the style of Word and TeX outputs.

Please fork and edit the project, then send a pull request.
