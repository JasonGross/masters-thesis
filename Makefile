.PHONY: all proposal thesis update-thesis
all: proposal thesis

PROPOSAL_PDFS = jgross-thesis-proposal.pdf 
THESIS_PDFS = jgross-thesis.pdf
THESIS_TEXS = contents.tex mitthesis.cls abstract.tex cover.tex new-date.tex todo.tex
PDFS = $(PROPOSAL_PDFS) $(THESIS_PDFS)

proposal: $(PROPOSAL_PDFS)

thesis: $(THESIS_PDFS)

update-thesis::
	echo "\\thesisdate{`date +'%B %-d, %Y'`}" > new-date.tex
	$(MAKE) thesis

$(PDFS): references.bib

$(THESIS_PDFS): $(THESIS_TEXS)


%.pdf: %.tex
	@ pdflatex -synctex=1 -interaction=nonstopmode -enable-write18 $<
	@ bibtex ${<:.tex=.aux}
	@ pdflatex -synctex=1 -interaction=nonstopmode -enable-write18 $<
	@ pdflatex -synctex=1 $<

clean:
	@ rm -f *.aux *.out *.nav *.toc *.vrb $(PDFS) *.snm *.log *.bbl *.blg

