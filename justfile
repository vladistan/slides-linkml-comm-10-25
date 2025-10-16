THIS := "Using_KG_To_Describe_Datasets"
WIKI2BEAMER := env_var_or_default('HOME', '') + "/Proj/mine/wiki2beamer/.venv/bin/wiki2beamer"

# Build slides.pdf (default target)
default: slides

# Build slides PDF
slides: intro-tex
    pdflatex slides
    -bibtex slides
    pdflatex slides
    pdflatex slides

# Convert intro.md to intro.tex using wiki2beamer
intro-tex:
    {{WIKI2BEAMER}} intro.md > intro.tex

# Clean build artifacts
clean:
    -rm -f slides.aux intro.tex
    -rm -f *.aux
    -rm -f *.log
    -rm -f *.nav
    -rm -f *.out
    -rm -f *.snm
    -rm -f *.toc
    -rm -f slides.pdf

# View the generated PDF
view: slides
    open slides.pdf
