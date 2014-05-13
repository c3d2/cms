OUTPUT_DIR=out

PICDIR = ./img

depsvg = $(wildcard $(PICDIR)/*.svg)
svgpdf = $(patsubst %.svg,%.pdf,$(depsvg))

all: deppdf $(OUTPUT_DIR)/slides.pdf

clean:
	rm $(svgpdf)
	rm -rf $(OUTPUT_DIR)

deppdf: $(svgpdf)
	echo test
	echo $(svgpdf)
	echo test


$(PICDIR)/%.pdf: $(PICDIR)/%.svg 
	inkscape -z -T -A $@ $<

$(OUTPUT_DIR)/slides.tex:
	mkdir -p $(OUTPUT_DIR)
	./generator_dialog.sh $(OUTPUT_DIR)

$(OUTPUT_DIR)/slides.pdf: $(OUTPUT_DIR)/slides.tex deppdf
	pdflatex -draftmode -interaction nonstopmode -output-directory $(OUTPUT_DIR) $(OUTPUT_DIR)/slides.tex
	pdflatex -output-directory $(OUTPUT_DIR) $(OUTPUT_DIR)/slides.tex

