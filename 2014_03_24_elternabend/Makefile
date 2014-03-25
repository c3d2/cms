TEX_FILES=$(wildcard src/*.tex)
PDF_FILES=$(TEX_FILES:src/%.tex=out/%.pdf)

PICDIR = ./img

depsvg = $(wildcard $(PICDIR)/*.svg)
svgpdf = $(patsubst %.svg,%.pdf,$(depsvg))


all: deppdf $(PDF_FILES)

clean:
	rm $(svgpdf)
	rm -rf out

deppdf: $(svgpdf)
	echo test
	echo $(svgpdf)
	echo test


$(PICDIR)/%.pdf: $(PICDIR)/%.svg 
	inkscape -z -T -A $@ $<


out/%.pdf:  src/%.tex deppdf  Makefile
	mkdir -p out
	pdflatex  -draftmode -interaction nonstopmode -output-directory out $<
	pdflatex -output-directory out $<


