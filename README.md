# tx_tools – Personliga CLI-verktyg för LaTeX och PDF

Tre små verktyg för att arbeta med LaTeX och PDF-filer.

## Verktyg

| Kommando | Beskrivning |
|----------|-------------|
| `tx_tex` | Bygg LuaLaTeX till PDF eller PNG |
| `tx_pdf` | Manipulera PDF-filer (merge, 2up, booklet, mm.) |
| `tx_new` | Skapa nya projekt från mallar (interaktivt) |

## Installation

```bash
git clone https://github.com/nikodemusk/tx_tools.git
cd tx_tools
chmod +x tx_*
cp tx_* ~/.local/bin/

## Användning

Alla verktyg har inbyggd hjälp:

```
tx_tex --help
tx_pdf --help
tx_new --help
```

## Beroenden

* `lualatex`, `latexmk`, `pdfjam` - ingår i `TeXLive`
* `magick` (ImageMagick) – krävs för PNG i `tx_tex`
* `gs` (Ghostscript) – används av flera verktyg 

## Mallar

`tx_new` använder mallar från katalogen `mallar`. Skapa egna genom att lägga
till undermappar med `main.tex`, `preamble.tex` och `.latexmkrc`.

## Exempel

```
# Bygg PDF
tx_tex -i rapport.tex

# Skapa handout med 2 sidor/ark
tx_pdf 2up presentation.pdf handout.pdf

# Skapa nytt projekt
tx_new
```

## Licens

MIT
