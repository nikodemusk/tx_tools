# tx_tools - Textverktyg för LaTeX och PDF

En samling små, fokuserade kommandoradsverktyg för att arbeta med LaTeX och PDF-filer.

## Verktyg

| Verktyg | Beskrivning |
|---------|-------------|
| `tx_tex` | Bygg LuaLaTeX-projekt till PDF eller PNG |
| `tx_pdf` | Manipulera PDF-filer (extrahera, slå ihop, 2-up, booklet, mm.) |

## Installation

```bash
# Klona repot
git clone https://github.com/nikodemusk/tx_tools.git
cd tx_tools

# Gör skripten körbara
chmod +x tx_tex tx_pdf

# Kopiera till en katalog i din PATH (exempel)
cp tx_tex tx_pdf ~/.local/bin/
```

## Beroenden

### För `tx_tex`

  * lualatex - LaTeX-motorn (ingår i TeXLive)

  * latexmk - Automatiserad LaTeX-byggare (ingår i TeXLive)

  * magick (ImageMagick) - PDF → PNG-konvertering (krävs endast för PNG-läge)

  * gs (Ghostscript) - Används av ImageMagick

### För `tx_pdf`

   * pdfjam - Ingår i TeXLive (full installation)

   * gs (Ghostscript) - Används av pdfjam

## Konfiguration

### För `tx_tex`

   * lualatex - LaTeX-motorn (ingår i TeXLive)

   * latexmk - Automatiserad LaTeX-byggare (ingår i TeXLive)

   * magick (ImageMagick) - PDF → PNG-konvertering (krävs endast för PNG-läge)

   * gs (Ghostscript) - Används av ImageMagick

### För tx_pdf

   * pdfjam - Ingår i TeXLive (full installation)

   * gs (Ghostscript) - Används av pdfjam

## Konfiguration `.latexmkrc`

`tx_tex` läser inställningar från `.latexmkrc` i den aktuella katalogen.
Här är ett exempel:

```
# .latexmkrc – Grundkonfiguration
$out_dir  = './out';           # PDF:er hamnar här
$aux_dir  = './cache';         # Temporära byggfiler (valfritt)
$jobname  = 'mitt_dokument';   # Output-namn (kan överskuggas med -i)
$pdflatex = 'lualatex %O %S';  # Använd LuaLaTeX som motor
$pdf_mode = 1;                 # Generera PDF direkt
```

## Användning

### `tx_tex` - Bygg LaTeX till PDF/PNG

```
# Bygg main.tex till PDF (använder $jobname från .latexmkrc)
tx_tex

# Bygg specifik fil (överskuggar $jobname)
tx_tex -i rapport.tex

# Bygg PNG från enstaka formel (vit bakgrund)
tx_tex -i formel.tex -f png

# Bygg PNG med transparent bakgrund och beskärning
tx_tex -i logga.tex -f png --bg-transparent --trim

# Bygg PNG med färgad bakgrund
tx_tex -i diagram.tex -f png --bg-color lightblue

# Live-läge (uppdaterar automatiskt vid ändringar)
tx_tex -w

# Rensa byggfiler
tx_tex -c
tx_tex -c formel    # Rensa specifikt jobbnamn
```

### `tx_pdf - Manipulera pdf-filer

```
# Extrahera sidor
tx_pdf extract rapport.pdf 1-5,10-12 sammanfattning.pdf

# Ändra sidordning
tx_pdf reorder dokument.pdf 5,4,3,2,1 omvänd.pdf

# Slå ihop flera PDF-filer
tx_pdf merge komplett.pdf kap1.pdf kap2.pdf bilaga.pdf

# Två sidor per ark (spara papper vid utskrift)
tx_pdf 2up presentation.pdf handout.pdf

# Två sidor per ark, endast vissa sidor
tx_pdf 2up-select bok.pdf 10-20,25-30 utdrag.pdf

# N sidor per ark (2,4,6,8,9,16)
tx_pdf nup bildspel.pdf 4 fyrperark.pdf

# Skapa booklet (vikbar till bok)
tx_pdf booklet roman.pdf booklet.pdf

# Dela upp i enskilda sidor
tx_pdf split kapitel.pdf sida_

# Visa information om PDF
tx_pdf info dokument.pdf

# Komprimera PDF (minska filstorlek)
tx_pdf compress stor.pdf liten.pdf

# Komprimera alla PDF-filer i aktuell katalog
tx_pdf compress-all

# Kontrollera om PDF innehåller text (sökbar)
tx_pdf check-ocr skannad.pdf

# Skapa miniatyrbilder (PNG)
tx_pdf thumbnails presentation.pdf 200x200 miniatyrer/
```

## Exempel på arbetsflöden

### Skapa en handout från en presentation

```
# 1. Bygg presentationen till PDF
tx_tex -i presentation.tex

# 2. Skapa handout med 2 sidor per ark
tx_pdf 2up out/presentation.pdf handout.pdf

# 3. (Valfritt) Komprimera för att minska filstorleken
tx_pdf compress handout.pdf handout_komprimerad.pdf
```

### Skapa en bild från en LaTeX-formel

```
# 1. Skapa en liten .tex-fil med formeln
cat > formel.tex << 'EOF'
\documentclass{standalone}
\usepackage{amsmath}
\begin{document}
$E = mc^2$
\end{document}
EOF

# 2. Bygg till PNG med transparent bakgrund
tx_tex -i formel.tex -f png --bg-transparent --trim

# 3. Använd bilden i ett annat dokument
```

### Arbete med ett provdokument

Katalogstruktur:

```
prov_ma3c/
├── main.tex
├── .latexmkrc
├── out/
└── cache/
```

`.latexmkrc` för provet:

```
$out_dir  = './out';
$aux_dir  = './cache';
$jobname  = 'prov_ma3c_ht2025';
$pdflatex = 'lualatex %O %S';
$pdf_mode = 1;
```

Bygga provet:

```
cd prov_ma3c
tx_tex                    # Skapar out/prov_ma3c_ht2025.pdf
tx_tex -c                 # Rensa byggfiler (cache/ töms)
```

## Felsökning

### "pdfjam saknas"

```
# Installera fullständig TeXLive (inkluderar pdfjam)
# eller installera separat:
sudo apt install pdfjam          # Ubuntu
brew install pdfjam              # macOS
```

### "magick saknas" (vid PNG-läge)

```
# Installera ImageMagick
sudo apt install imagemagick     # Ubuntu
brew install imagemagick         # macOS
```

### PDF:en hamnar inte i förväntad katalog 

Kontrollera att `.latexmkrc` använder `$out_dir` och att katalogen finns:

```
mkdir -p out
```

## Bidrag

Detta repo är främst för personligt bruk, men förslag och idéer är välkomna via
issues.
