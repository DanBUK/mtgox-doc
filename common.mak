# pdflatex makefile include, based on pdflatex-makefile by ransford at cs.umass.edu
# https://github.com/ransford/pdflatex-makefile
#
# Because we work with many tex files and using bibliography is unlikely, we'll
# make all generated files depend on any change on bibliography

# pdflatex/bibtex

RUBBER ?= rubber

TEXFILES=$(patsubst %.pdf,%.tex,$(PDFTARGETS))

all: .deps $(PDFTARGETS)

include .deps

.deps: $(TEXFILES)
	grep -H '^[^%]*\\bibliography{' $(TEXFILES) | sed -e 's/\([^:]*\)\.tex:^[^%]*\\bibliography{\([^}]*\)}.*/\1.pdf: \2.tex/' -e 's/, */ /g' >$@
	grep -H '^[^%]*\\\(input\|include\){' $(TEXFILES) | sed -e 's/\([^:]*\)\.tex:[^{]*{\([^}]*\)}.*/\1.pdf: \2.tex/' >>$@

%.pdf: %.tex
	$(RUBBER) --cache -d "$<"

clean:
	$(RM) $(foreach T,$(PDFTARGETS:.pdf=), \
		$(T).out $(T).pdf $(T).blg $(T).bbl \
		$(T).lof $(T).lot $(T).toc $(T).idx \
		$(T).log $(T).aux)
	$(RM) .deps rubber.cache

