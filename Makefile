PY=python
PANDOC=pandoc

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
TEMPLATEDIR=$(INPUTDIR)/templates
STYLEDIR=$(BASEDIR)/style
SCRATCHDIR=$(BASEDIR)/scratch

BIBFILE=$(INPUTDIR)/references.bib

help:
	@echo ' 							'
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make install                     install pandoc plugins             '
	@echo '   make html                        generate a web version              '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make docx	                       generate a Docx file 			  '
	@echo '   make tex	                       generate a Latex file 			  '
	@echo ' 																	  '
	@echo '   multiline_tables                 convert a large markdown table into a$\'
	@echo '		                           multi-line format                      '
	@echo ' 																	  '
	@echo '   tables	                       convert a md table into LaTeX, to$\'
	@echo '                                       be used sideways or with other$\'
	@echo '      			                       advanced formatting'
	@echo '                                                                       '
	@echo 'get local templates with: pandoc -D latex/html/etc	  				  '
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates		  '

install:
	sh $(BASEDIR)/install.sh

pdf:
	pandoc  \
	--filter=pandoc-shortcaption \
	--filter=pandoc-xnos \
	--template="$(STYLEDIR)/template.tex" \
	"$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.pdf" \
	-H "$(STYLEDIR)/preamble.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(STYLEDIR)/ref_format.csl" \
	-V fontsize=12pt \
	-V papersize=a4paper \
	-V documentclass=report \
	--pdf-engine=xelatex \
	--verbose

tex:
	pandoc "$(INPUTDIR)"/*.md \
	--filter=pandoc-shortcaption \
	--filter=pandoc-xnos \
	--template="$(STYLEDIR)/template.tex" \
	--bibliography="$(BIBFILE)" \
	-V fontsize=12pt \
	-V papersize=a4paper \
	-V documentclass=report \
	-N \
	--csl="$(STYLEDIR)/ref_format.csl" \

docx:
	pandoc \
	--filter=pandoc-shortcaption \
	--filter=pandoc-xnos \
	"$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.docx" \
	--bibliography="$(BIBFILE)" \
	--csl="$(STYLEDIR)/ref_format.csl" \
	--toc

html:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.html" \
	--filter=pandoc-shortcaption \
	--filter=pandoc-xnos \
	--standalone \
	--template="$(STYLEDIR)/template.html" \
	--bibliography="$(BIBFILE)" \
	--csl="$(STYLEDIR)/ref_format.csl" \
	--include-in-header="$(STYLEDIR)/style.css" \
	--toc \
	--number-sections
	rm -rf "$(OUTPUTDIR)/source"
	mkdir "$(OUTPUTDIR)/source"
	cp -r "$(INPUTDIR)/figures" "$(OUTPUTDIR)/source/figures"

multiline_tables:
	pandoc "$(SCRATCHDIR)/tables.md" \
	-t markdown+multiline_tables \
	-o "$(SCRATCHDIR)/cleaned_tables.md"

tables: multiline_tables
	pandoc "$(SCRATCHDIR)/cleaned_tables.md" \
	-o "$(SCRATCHDIR)/tables.tex"

.PHONY: help install pdf docx html tex
