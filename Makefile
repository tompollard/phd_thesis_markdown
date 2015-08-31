PY=python
PANDOC=pandoc

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
TEMPLATEDIR=$(INPUTDIR)/templates
STYLEDIR=$(BASEDIR)/style

BIBFILE=$(INPUTDIR)/references.json

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        generate a web version             '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make docx	                       generate a Docx file 			  '
	@echo '   make tex	                       generate a Latex file 			  '
	@echo '                                                                       '
	@echo ' 																	  '
	@echo ' 																	  '
	@echo 'get local templates with: pandoc -D latex [or html, etc.]	  				  '
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates		  '

pdf:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.pdf" \
	--template="$(STYLEDIR)/template.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(STYLEDIR)/ref_format.csl" \
	-V documentclass=report \
	-V papersize=a4paper \
	-V geometry="top=1.5in,bottom=1.5in,left=1.5in,right=1.5in" \
	-V fontsize=12pt \
	-V citecolor=black \
	-V toccolor=black \
	-V urlcolor=black \
	-V linkcolor=black \
	-V lang=english \
	--number-sections \
	--chapters \
	--latex-engine=xelatex \
	--smart \
	--standalone

tex:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.pdf" \
	--template="$(STYLEDIR)/template.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(STYLEDIR)/ref_format.csl" \
	-V documentclass=report \
	-V papersize=a4paper \
	-V geometry="top=1.5in,bottom=1.5in,left=1.5in,right=1.5in" \
	-V fontsize=12pt \
	-V citecolor=black \
	-V toccolor=black \
	-V urlcolor=black \
	-V linkcolor=black \
	-V lang=english \
	--number-sections \
	--chapters \
	--latex-engine=xelatex \
	--smart \
	--standalone

docx:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.docx" \
	--bibliography="$(BIBFILE)" \
	--csl="$(STYLEDIR)/ref_format.csl" \
	--table-of-contents \
	--smart \
	--standalone

html:
	pandoc "$(INPUTDIR)"/*.md \
	-t html5 \
	-o "$(OUTPUTDIR)/thesis.html" \
	--template="$(STYLEDIR)/template.html" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(STYLEDIR)/ref_format.csl" \
	-V link-citations \
	--include-in-header="$(STYLEDIR)/style.css" \
	--table-of-contents \
	--number-sections \
	--section-divs \
	--smart \
	--standalone
	rm -rf "$(OUTPUTDIR)/source"
	mkdir "$(OUTPUTDIR)/source"
	cp -r "$(INPUTDIR)/figures" "$(OUTPUTDIR)/source/figures"

.PHONY: help pdf docx html tex
