# tx_tools – Personliga CLI-verktyg för LaTeX och PDF

Fyra små verktyg för att arbeta med LaTeX- och PDF-filer.

## Verktyg

| Kommando  | Beskrivning |
|-----------|-------------|
| `tx_tex`  | Bygg LuaLaTeX till PDF eller PNG |
| `tx_pdf`  | Manipulera PDF-filer (merge, 2up, booklet, mm.) |
| `tx_new`  | Skapa nya projekt från mallar (interaktivt) |
| `tx_exam` | Bygg både elev- och lärarversion av prov (exam-klassen) |

## Installation

```bash
git clone https://github.com/nikodemusk/tx_tools.git
cd tx_tools
chmod +x tx_*
cp tx_* ~/.local/bin/
```

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
* `perl` – används av `tx_exam` för textmanipulation (finns som standard på Unix)

## Mallar

`tx_new` använder mallar från katalogen `mallar`. Skapa egna genom att lägga
till undermappar med `main.tex`, `preamble.tex` och `.latexmkrc`. Mallar
kopieras rekursivt.

## Exempel

```
# Bygg PDF

tx_tex -i rapport.tex

# Skapa handout med 2 sidor/ark

tx_pdf 2up presentation.pdf handout.pdf

# Skapa nytt projekt

tx_new

# Bygg prov (elev- och lärarversion)

tx_exam
tx_exam -v              # Verbose läge för felsökning
```

## Säkerhet

### `tx_exam` – Privat temp-katalog

`tx_exam` använder en **privat temporär katalog** för byggprocessen. Kopior av
dina filer läggs aldrig i systemets publika `/tmp`.

| System | Temp-katalog | Läsbarhet |
|--------|--------------|-----------|
| **macOS** | `$TMPDIR` (användarspecifik) | Endast användaren |
| **Linux (med XDG_RUNTIME_DIR)** | `$XDG_RUNTIME_DIR` | Endast användaren |
| **Linux (fallback)** | `~/.cache/tx_exam/` | Endast användaren |

## TODO

* Skapa en mall för `exam`-klassen (prov-mall).

## Licens

MIT
