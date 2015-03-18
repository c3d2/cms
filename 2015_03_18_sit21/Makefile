SHELL := /usr/bin/zsh
TEX_FILES=$(wildcard src/*.tex)
PDF_FILES=$(TEX_FILES:src/%.tex=out/%.pdf)
RATE_FOLDER=ratespiel
RATE_FILES= $(wildcard ratespiel/ratespiel-flashcards.tex ratespiel/ratespiel-processing1a.tex ratespiel/ratespiel-processing1b.tex ratespiel/ratespiel-processing2a.tex ratespiel/ratespiel-processing2b.tex ratespiel/ratespiel-processing3.tex)

PICDIR = ./img

depsvg = $(wildcard $(PICDIR)/*.svg)
svgpdf = $(patsubst %.svg,%.pdf,$(depsvg))


all: deppdf $(PDF_FILES)
ratespiel: $(RATE_FILES)
	for FILE in $(RATE_FILES); do pdflatex -output-directory out $$FILE; done
clean:
	rm $(svgpdf)
	rm -rf out

deppdf: $(svgpdf)
	echo test echo $(svgpdf)
	echo test


$(PICDIR)/%.pdf: $(PICDIR)/%.svg 
	inkscape -z -T -A $@ $<


out/%.pdf:  src/%.tex deppdf  Makefile
	mkdir -p out
	pdflatex -draftmode -interaction nonstopmode -output-directory out $<
	pdflatex -output-directory out $<


