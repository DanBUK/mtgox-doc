all: $(PDFTARGETS)

%.pdf: %.tex
	pdflatex -interaction batchmode "$<"

clean:
	$(RM) $(foreach T,$(PDFTARGETS:.pdf=), \
		$(T).out $(T).pdf $(T).blg $(T).bbl \
		$(T).lof $(T).lot $(T).toc $(T).idx \
		$(T).log $(T).aux)

