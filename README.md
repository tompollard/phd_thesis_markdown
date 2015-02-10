# Template for writing a PhD thesis in Markdown

This repository provides a framework for writing a PhD thesis in Markdown. I used the template for my PhD submission to University College London (UCL), but it should be straightforward to adapt suit other universities too.

## Why write my thesis in Markdown?

Markdown is a super-friendly plain text format that can be easily converted to a bunch of other formats like PDF, Word and Latex. You'll enjoy working in Markdown because: 
- it is a clean, plain-text format...
- ...but you can use Latex when you need it (for example, in laying out mathematical equations).
- it doesn't suffer from the freezes and crashes that some of us experience when working with large, image-heavy Word documents.
- it automatically handles the table of contents, bibliography etc with Pandoc.
- comments, drafts of text, etc can be added directly to your document by wrapping them in &lt;--  --&gt;
- it works well with Git, so keeping backups is straightforward. Just commit the changes and then push them to your repository.
- it doesn't lock you in. If you decide that Markdown isn't for you, then just output to Word, or whatever, and continue working in the new format.

## Are there any reasons not to use Markdown?

There are some minor annoyances:
- if you haven't worked with Markdown before then you'll find yourself referring to the style-guide fairly often at first.
- you won't be able to escape Latex completely because it is needed for styling and maths.
- it isn't possible to add a short caption to figures and tables. This means that /listoftables and /listoffigures include the long-caption, which probably isn't what you want. If you want to include the list of tables and list of figures, then you have to write them manually.
- all of the templates in this framework need work. The PDF output is fine, but HTML and Word need work if you plan to use these formats.
- ... if there are more, please add them here.

## How is the template organised?

- README.md => these instructions.
- License.md => terms of reuse (MIT license).
- Makefile => contains instructions for using Pandoc to produce the final thesis.
- output/ => directory to hold the final version.
- source/ => directory to hold the thesis content. Includes the references.bib file.
- source/figures/ => directory to hold the figures.
- style/ => directory to hold the style documents.

## How do I get started?

1) Install the following software:
- A text editor, like [Sublime](https://www.sublimetext.com/), which is what you'll use write the thesis.
- Latex, needed for things like styling.
- [Pandoc](http://johnmacfarlane.net/pandoc), for converting the Markdown to other formats.
- Git, for version control.
2) [Fork the repository](https://github.com/tompollard/phd_thesis_markdown/fork) on Github
3) Clone the repository onto your local computer (or [download the Zip file](https://github.com/tompollard/phd_thesis_markdown/archive/master.zip)).
4) Navigate to the directory that contains the Makefile and type "make pdf" to update the PDF in the output directory.
5) Edit the files in the 'source' directory, then goto step 4.

## What else do I need to know?

Some useful points, in a random order:
- each chapter must finish with at least one blank line, otherwise the header of the following chapter may not be picked up.
- add two spaces at the end of a line to force a line break.
- the template uses [John Macfarlane's Pandoc](http://johnmacfarlane.net/pandoc/README.html) to generate the output documents. Refer to this page for Markdown formatting guidelines.
- PDFs are generated using the Latex templates in the style directory. Fonts etc can be changed in the tex templates.
- To change the citation style, just overwrite ref_format.csl with the new style. Style files can be obtained from [citationstyles.org/](http://citationstyles.org/)

# Contributing

Contributions to the template are encouraged! There are lots of things that could improved, like:
- finding a way to add short captions for the figures and tables, so that the lists of figures and tables can be automatically generated.
- cleaning up the Latex templates, which are messy at the moment.
- improving the style of Word and Tex outputs.

Please fork and edit the project, then send a pull request.


