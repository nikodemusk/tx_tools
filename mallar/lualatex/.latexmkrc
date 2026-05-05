# .latexmkrc för LuaLaTeX-projekt
$pdflatex = 'lualatex --shell-escape %O %S';
$pdf_mode = 1;

$out_dir = './out';
$aux_dir = './cache';
$jobname = 'dokument';

# Kör latexmk två gånger för referenser
$latex = 'lualatex --shell-escape %O %S';
$latex_silent = 'lualatex --shell-escape --interaction=batchmode %O %S';

# Skapa alltid .fls-fil för att spåra filer
$recorder = 1;
