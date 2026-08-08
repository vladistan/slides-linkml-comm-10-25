# Notes for Claude: Creating Slides with wiki2beamer

## Overview

This project uses **wiki2beamer** to convert Markdown files into LaTeX Beamer presentations. The slides are styled with a custom Vlad theme.

## Build System

- **Build tool**: `just` (modern Make replacement)
- **Main command**: `just` - builds the slides
- **Clean**: `just clean` - removes build artifacts
- **View**: `just view` - opens the generated PDF

## File Structure

```
.
├── justfile              # Build configuration
├── slides.tex            # Main LaTeX file
├── intro.md              # Slide content in wiki2beamer format
├── slides.bib            # Bibliography (currently empty)
├── beamerthemeVlad.sty   # Custom Beamer theme
├── beamerouterthemeVlad.sty  # Custom outer theme
├── header.png            # Header image for each slide
├── msLogo.pdf            # Logo for title page
└── images/               # Directory for slide images
    └── ProcessingPipeline.pdf
```

## wiki2beamer Syntax

### Title/Section Slides
```
=! Section Title !=
```
Creates a section title slide (no content, just the title).

### Regular Frame/Slide
```
==== Slide Title ====

Content goes here...
```

### Bullet Points
```
* First level bullet
** Second level bullet
*** Third level bullet
```

### Images
```
<[center]
<<<images/yourimage.pdf,height=7cm>>>
[center]>
```

You can also use:
- `width=10cm` for width specification
- `scale=0.5` for scaling
- Supported formats: PDF, PNG, JPG

### Code Blocks
```
<[code]
your code here
[code]>
```

### Columns
```
<[columns]

[[[ col1-width ]]]
Left column content

[[[ col2-width ]]]
Right column content

[columns]>
```

## Workflow

1. Edit `intro.md` with your slide content
2. Run `just` to build
3. The build process:
   - Converts `intro.md` → `intro.tex` (via wiki2beamer)
   - Compiles `slides.tex` → `slides.pdf` (via pdflatex)
   - Runs bibtex (currently skipped if no citations)
   - Runs pdflatex twice more for references

## Creating New Images

If you need stub images:
1. Create a LaTeX file like `stub_name.tex`:
```latex
\documentclass{standalone}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\draw[fill=gray!20] (0,0) rectangle (10,7);
\node at (5,3.5) {\Huge\textbf{Your Text}};
\end{tikzpicture}
\end{document}
```

2. Compile: `pdflatex stub_name.tex`
3. Move to images: `mv stub_name.pdf images/`

## Custom Theme Files

- `beamerthemeVlad.sty`: Main theme configuration
- `beamerouterthemeVlad.sty`: Header, footer, and title page layout
  - Currently uses `header.png` for slide headers
  - Uses `msLogo.pdf` on title page
  - Shows frame numbers in footer

## Tips

- Keep slide titles short (max ~40 characters)
- Use bullet points for clarity
- Images work best as PDFs (vector graphics)
- Two blank lines between sections help readability
- Test build frequently: `just`

## Troubleshooting

- If wiki2beamer not found: Check `.envrc` is loaded (`direnv allow`)
- If images missing: Create stub images or comment out the image reference
- If bibtex errors: They're warnings only, safe to ignore if no citations
- LaTeX errors: Check `slides.log` for details

## Example Stub Slides

See current `intro.md` for stub slides with placeholders that you can fill in with actual content.
