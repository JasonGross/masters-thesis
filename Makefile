.PHONY: all paper thesis
all: paper thesis

PDFS = jgross-thesis-proposal.pdf jgross-thesis.pdf

paper: jgross-thesis-proposal.pdf

thesis: jgross-thesis.pdf

jgross-thesis-proposal.pdf jgross-thesis.pdf: references.bib


%.pdf: %.tex
	@ pdflatex -synctex=1 -interaction=nonstopmode -enable-write18 $<
	@ bibtex ${<:.tex=.aux}
	@ pdflatex -synctex=1 -interaction=nonstopmode -enable-write18 $<
	@ pdflatex -synctex=1 $<

clean:
	@ rm -f *.aux *.out *.nav *.toc *.vrb $(PDFS) *.snm *.log *.bbl *.blg

