.PHONY: all paper
all: paper

paper: jgross-thesis-proposal.pdf

jgross-thesis-proposal.pdf: references.bib


%.pdf: %.tex
	@ pdflatex -synctex=1 -interaction=nonstopmode -enable-write18 $<
	@ bibtex ${<:.tex=.aux}
	@ pdflatex -synctex=1 -interaction=nonstopmode -enable-write18 $<
	@ pdflatex -synctex=1 $<

clean:
	@ rm -f *.aux *.out *.nav *.toc *.vrb *.pdf *.snm *.log *.bbl *.blg

