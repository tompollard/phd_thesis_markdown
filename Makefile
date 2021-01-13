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
	@echo ''
	@echo 'Makefile for the Markdown thesis'
	@echo ''
	@echo 'Usage:'
	@echo '   make install                     install pandoc plugins'
	@echo '   make html                        generate a web version'
	@echo '   make pdf                         generate a PDF file'
	@echo '   make docx                        generate a Docx file'
	@echo '   make tex                         generate a Latex file'
	@echo ''
	@echo ''
	@echo 'get local templates with: pandoc -D latex/html/etc'
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates'

ifeq ($(OS),Windows_NT) 
	detected_OS=Windows
else
	detected_OS=$(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
install:
	bash $(BASEDIR)/install_linux.sh
else ifeq ($(shell uname), Darwin)
install:
	bash $(BASEDIR)/install_mac.sh
endif

pdf:
	pandoc  \
		--output "$(OUTPUTDIR)/thesis.pdf" \
		--template="$(STYLEDIR)/template.tex" \
		--include-in-header="$(STYLEDIR)/preamble.tex" \
		--variable=fontsize:12pt \
		--variable=papersize:a4paper \
		--variable=documentclass:report \
		--pdf-engine=xelatex \
		"$(INPUTDIR)"/*.md \
		"$(INPUTDIR)/metadata.yml" \
		--filter=pandoc-shortcaption \
		--filter=pandoc-xnos \
		--bibliography="$(BIBFILE)" \
		--citeproc \
		--csl="$(STYLEDIR)/ref_format.csl" \
		--number-sections \
		--verbose \
		2>pandoc.pdf.log

tex:
	pandoc  \
		--output "$(OUTPUTDIR)/thesis.tex" \
		--template="$(STYLEDIR)/template.tex" \
		--include-in-header="$(STYLEDIR)/preamble.tex" \
		--variable=fontsize:12pt \
		--variable=papersize:a4paper \
		--variable=documentclass:report \
		--pdf-engine=xelatex \
		"$(INPUTDIR)"/*.md \
		"$(INPUTDIR)/metadata.yml" \
		--filter=pandoc-shortcaption \
		--filter=pandoc-xnos \
		--bibliography="$(BIBFILE)" \
		--citeproc \
		--csl="$(STYLEDIR)/ref_format.csl" \
		--number-sections \
		--verbose \
		2>pandoc.tex.log

html:
	pandoc  \
		--output "$(OUTPUTDIR)/thesis.html" \
		--template="$(STYLEDIR)/template.html" \
		--include-in-header="$(STYLEDIR)/style.css" \
		--toc \
		"$(INPUTDIR)"/*.md \
		"$(INPUTDIR)/metadata.yml" \
		--filter=pandoc-shortcaption \
		--filter=pandoc-xnos \
		--bibliography="$(BIBFILE)" \
		--citeproc \
		--csl="$(STYLEDIR)/ref_format.csl" \
		--number-sections \
		--verbose \
		2>pandoc.html.log
	rm -rf "$(OUTPUTDIR)/source"
	mkdir "$(OUTPUTDIR)/source"
	cp -r "$(INPUTDIR)/figures" "$(OUTPUTDIR)/source/figures"

docx:
	pandoc  \
		--output "$(OUTPUTDIR)/thesis.docx" \
		--toc \
		"$(INPUTDIR)"/*.md \
		"$(INPUTDIR)/metadata.yml" \
		--filter=pandoc-shortcaption \
		--filter=pandoc-xnos \
		--bibliography="$(BIBFILE)" \
		--citeproc \
		--csl="$(STYLEDIR)/ref_format.csl" \
		--number-sections \
		--verbose \
		2>pandoc.docx.log

all: pdf tex html docx

.PHONY: help install pdf docx html tex
