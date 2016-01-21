PY=python
PANDOC=pandoc

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
STYLEDIR=$(BASEDIR)/style

BIBFILE=$(INPUTDIR)/references.bib
CSLSTYLE=$(STYLEDIR)/ref_format.csl

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html	generate a web version             '
	@echo '   make pdf	generate a PDF file  			  '
	@echo '   make clean	clean compiled files 			  '
	@echo '   make docx	generate a Docx file 			  '
	@echo '   make tex	generate a Latex file, clean and compile			  '
	@echo '                                                                       '
	@echo ' 																	  '
	@echo ' 																	  '
	@echo 'get local templates with: pandoc -D latex/html/etc	  				  '
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates		  '

pdf:
	pandoc  "$(STYLEDIR)/metadata.yaml" "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.pdf" \
	--template="$(STYLEDIR)/template.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(CSLSTYLE)" \
	--chapters \
	-N \
	--toc \
	--toc-depth=4 \
	--latex-engine=xelatex

docx:
	pandoc  "$(STYLEDIR)/metadata.yaml" "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.docx" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(CSLSTYLE)" \
	--table-of-contents \
	--smart \
	--standalone \
	--number-sections

html:
	pandoc "$(STYLEDIR)/metadata.yaml" "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.html" \
	-t html5 \
	--standalone \
	--template="$(STYLEDIR)/template.html" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(CSLSTYLE)" \
	--include-in-header="$(STYLEDIR)/style.css" \
	--toc \
	--number-sections
	rm -rf "$(OUTPUTDIR)/source"
	mkdir "$(OUTPUTDIR)/source"
	cp -r "$(INPUTDIR)/figures" "$(OUTPUTDIR)/source/figures"

tex:
	pandoc "$(STYLEDIR)/metadata.yaml" "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis-temp.tex" \
	--template="$(STYLEDIR)/template.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--chapters \
	-N \
	--toc \
	--toc-depth=4 \
	--csl="$(CSLSTYLE)" \
	--latex-engine=xelatex
	sed -f convert-to-part.sed <$(OUTPUTDIR)/thesis-temp.tex >$(OUTPUTDIR)/thesis.tex
	latexmk -xelatex -nobibtex -outdir=$(OUTPUTDIR)  $(OUTPUTDIR)/thesis.tex
	rm "$(OUTPUTDIR)/thesis-temp.tex"
	rm -f "$(OUTPUTDIR)"/*.log "$(OUTPUTDIR)"/*.bbl "$(OUTPUTDIR)"/*.blg "$(OUTPUTDIR)"/*.aux "$(OUTPUTDIR)"/*.toc "$(OUTPUTDIR)"/*.out "$(OUTPUTDIR)"/*.fls "$(OUTPUTDIR)"/*.fdb_latexmk

clean:
	rm -rf "$(OUTPUTDIR)"/*

.PHONY: help pdf docx html tex clean
