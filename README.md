# Template for writing a PhD thesis in Markdown [![Build Status](https://travis-ci.org/tompollard/phd_thesis_markdown.svg?branch=master)](https://travis-ci.org/tompollard/phd_thesis_markdown)

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.58490.svg)](http://dx.doi.org/10.5281/zenodo.58490)

This repository provides a framework for writing a PhD thesis in Markdown. I used the template for my PhD submission to University College London (UCL), but it should be straightforward to adapt suit other universities too.

## Citing the template

If you have used this template in your work, please cite the following publication:

> Tom Pollard et al. (2016). Template for writing a PhD thesis in Markdown. Zenodo. http://dx.doi.org/10.5281/zenodo.58490

## Why write my thesis in Markdown?

Markdown is a super-friendly plain text format that can be easily converted to a bunch of other formats like PDF, Word and LaTeX. You'll enjoy working in Markdown because:
- it is a clean, plain-text format...
- ...but you can use LaTeX when you need it (for example, in laying out mathematical formula).
- it doesn't suffer from the freezes and crashes that some of us experience when working with large, image-heavy Word documents.
- it automatically handles the table of contents, bibliography etc with Pandoc.
- comments, drafts of text, etc can be added to the document by wrapping them in &lt;!--  --&gt;
- it works well with Git, so keeping backups is straightforward. Just commit the changes and then push them to your repository.
- it is able to take advantage of autocompletion capabilities for figures and citations in several text editors (VSCode, Sublime, etc.)
- there is no lock-in. If you decide that Markdown isn't for you, then just output to Word, or whatever, and continue working in the new format.

## Are there any reasons not to use Markdown?

There are some minor annoyances:
- if you haven't worked with Markdown before then you'll find yourself referring to the style-guide fairly often at first.
- it isn't possible to add a short caption to tables ~~and figures~~ ([figures are now fixed](https://github.com/tompollard/phd_thesis_markdown/pull/47), thanks to @martisak). This means that /listoftables includes the long-caption, which probably isn't what you want. If you want to include the list of tables, then you'll need to write it manually.
- the style documents in this framework could be improved. The PDF and HTML (thanks [@ArcoMul](https://github.com/ArcoMul)) outputs are acceptable, but ~~HTML and~~ Word needs work if you plan to output to this format.
- ~~there is no straightforward way of specifying image size in the markdown right now, though this functionality is coming (see: https://github.com/tompollard/phd_thesis_markdown/issues/15)~~ (Image size can now be specified. Thanks to @rudolfbyker for [highlighting this](https://github.com/tompollard/phd_thesis_markdown/issues/15)).
- ... if there are more, please add them here.

## How is the template organised?

- README.md => these instructions.
- License.md => terms of reuse (MIT license).
- Makefile => contains instructions for using Pandoc to produce the final thesis.
- output/ => directory to hold the final version.
- source/ => directory to hold the thesis content. Includes the references.bib file.
- scratch/ => directory to hold tables which can be converted between different formats.
- source/figures/ => directory to hold the figures.
- style/ => directory to hold the style documents.

## How do I get started?

For both of these methods, you'll need

- A text editor like [Sublime](https://www.sublimetext.com/) or [VSCode](https://code.visualstudio.com)
- Git for version control

After installing git:
1. [Fork the repository](https://github.com/tompollard/phd_thesis_markdown/fork) on Github
2. Clone the repository onto your local computer (or [download the Zip file](https://github.com/tompollard/phd_thesis_markdown/archive/master.zip))

### The easy way: Docker

1. Install [Docker](https://www.docker.com/get-started)
2. Navigate into your newly cloned repository, and type

    ```docker build -t denrondal/md_thesis .```

    into the terminal. This will take several minutes.

3. Now you can convert the sample dissertation to pdf:

    ```docker run --volume "`pwd`:/data" dendrondal/md_thesis pdf```

That's it! You should see a sample pdf in the output directory. Note that `pdf` can be subsituted with any other command. To see all commands, just run ```docker run --volume "`pwd`:/data" dendrondal/md_thesis help```

### The hard way: Install everything locally

1. Install the following software:
    - A LaTeX distribution (for example, [MacTeX](https://tug.org/mactex/) for Mac users, or [TexLive](https://tug.org/texlive/) for Linux/Windows users).
    - [Pandoc](http://johnmacfarlane.net/pandoc), for converting the Markdown to the output format of your choice.
    - [Python 3](https://www.python.org/downloads/) and python3-pip
    - Pandoc plugins by running ```make install``` in the main directory. **If you are on windows, you will need to install the pandoc plugins in this file manually**. This may work on WSL, but has not been tested.
2. Navigate to the directory that contains the Makefile and type "make pdf" (or "make html") at the command line to update the PDF (or HTML) in the output directory.

**In case of an error** (e.g. `make: *** [pdf] Error 43`), consult [this article](https://dalwilliams.info/lessons-learned-from-writing-a-phd-dissertation-in-markdown.html) for possible fixes. Most importantly, make sure tlmgr is properly installed, then run ```install.sh``

## What else do I need to know?

Some useful points, in a random order:
- each chapter must finish with at least one blank line, otherwise the header of the following chapter may not be picked up.
- add two spaces at the end of a line to force a line break.
- the template uses [John Macfarlane's Pandoc](http://johnmacfarlane.net/pandoc/README.html) to generate the output documents. Refer to this page for Markdown formatting guidelines.
- PDFs are generated using the LaTeX templates in the style directory. Fonts etc can be changed in the TeX templates.
- To change the citation style, just overwrite ref_format.csl with the new style. Style files can be obtained from [citationstyles.org/](http://citationstyles.org/)
- For fellow web developers, there is a Grunt task file (Gruntfile.js) which can be used to 'watch' the markdown files. By running `$ npm install` and then `$ npm run watch` the PDF and HTML export is done automatically when saving a Markdown file.
- You can automatically reload the HTML page on your browser using LiveReload with the command `$ npm run livereload`. The HTML page will automatically reload when saving a Markdown file after the export is done.

### Problems with tables

Sometimes, either multiple lines of text are needed in a table cell, Pandoc will incorrectly render tables with text overlapping, or the whitespace in your columns doesn't make sense. There are `make` directives to fix this, which work as follows:

1. Create a markdown file outside of the source directory (/scratch/tables.md in this repository)
2. Paste your problem tables (in markdown form) into this file
3. Run `make multiline_tables`
4. Paste the new multi-line tables where the original tables would be in your document

If you need a table in landscape mode, or need to apply advanced LaTeX formatting, the `make_tables` directive will do this for you. Again, consult [this blog post](https://dalwilliams.info/lessons-learned-from-writing-a-phd-dissertation-in-markdown.html) for troubleshooting.

# Contributing

Contributions to the template are encouraged! There are lots of things that could be improved, like:
- finding a way to add short captions for the tables, so that the lists of tables can be automatically generated.
- cleaning up the LaTeX templates, which are messy at the moment.
- improving the style of Word and TeX outputs.

Please fork and edit the project, then send a pull request.
