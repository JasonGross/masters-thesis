.PHONY: all proposal thesis update-thesis print-main-contents
all: proposal thesis

PROPOSAL_PDFS = jgross-thesis-proposal.pdf
THESIS_PDFS = jgross-thesis.pdf
MAIN_TEXS = $(patsubst \include{%},%.tex,$(filter \include{%},$(shell cat main-files.tex)))
THESIS_TEXS = packages.tex contents.tex mitthesis.cls abstract.tex cover.tex new-date.tex todo.tex main-files.tex $(MAIN_TEXS)
PDFS = $(PROPOSAL_PDFS) $(THESIS_PDFS)

print-main-contents::
	@ echo "$(MAIN_TEXS)"

proposal: $(PROPOSAL_PDFS)

thesis: $(THESIS_PDFS)

update-thesis::
	echo "\\thesisdate{`date +'%B %-d, %Y'`}" > new-date.tex
	$(MAKE) thesis

$(PDFS): references.bib

$(THESIS_PDFS): $(THESIS_TEXS)

%.pdf: %.tex.d

%.pdf: %.tex
	@ echo "PDFLATEX (run 1)"
	@ pdflatex -synctex=1 -interaction=nonstopmode -enable-write18 $< 2>&1 >/dev/null
	@ echo "BIBTEX"
	@ bibtex ${<:.tex=.aux}
	@ echo "PDFLATEX (run 2)"
	@ pdflatex -synctex=1 -interaction=nonstopmode -enable-write18 $< 2>&1 >/dev/null
	@ echo "PDFLATEX (run 3)"
	@ pdflatex -synctex=1 $<

clean:
	@ rm -f *.aux *.out *.nav *.toc *.vrb $(PDFS) *.snm *.log *.bbl *.blg *.tex.d

