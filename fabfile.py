from fabric.api import *
import fabric.contrib.project as project
#import os
import glob
#import sys

# directories
env.input_dir = "source"
env.output_dir = "output"
env.template_dir = "templates"
env.style_dir = "style"

# files
env.bib_file = env.input_dir + "\\references.bib"
env.input_files = " ".join(glob.glob(env.input_dir + "\\*.md"))  # get list of files in source directory and delimit them with spaces
env.output_file = env.output_dir + "\\thesis"
env.preamble_file = env.style_dir + "\\preamble.tex"
env.template_file = env.style_dir + "\\template.tex"
env.csl_file = env.style_dir + "\\ref_format.csl"

def pdf():
    """ Generate a PDF file """
    env.file_ext = ".pdf"
    local("pandoc {input_files} -o {output_file}{file_ext} -H {preamble_file} --template {template_file} --bibliography={bib_file} --csl={csl_file} -V fontsize=12pt -V papersize=a4paper -V documentclass:report -N --latex-engine=xelatex".format(**env))

def tex():
    """ Generate a tex file """
    env.file_ext = ".tex"
    local("pandoc {input_files} -o {output_file}{file_ext} -H {preamble_file} --template {template_file} --bibliography={bib_file} --csl={csl_file} -V fontsize=12pt -V papersize=a4paper -V documentclass:report -N --latex-engine=xelatex".format(**env))

def html():
    """ Generate a HTML file """
    env.file_ext = ".html"
    local("pandoc {input_files} -o {output_file}{file_ext} --standalone --bibliography={bib_file} --csl={csl_file} --toc --number-sections".format(**env))

def docx():
    """ Generate a DOCX file """
    env.file_ext = ".docx"
    local("pandoc {input_files} -o {output_file}{file_ext} --bibliography={bib_file} --csl={csl_file} --toc".format(**env))