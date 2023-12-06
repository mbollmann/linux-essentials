# Put auxiliary files in separate directory
$aux_dir = "aux";
$emulate_aux = 1;

# Extra file extensions to remove when running `latexmk -C`
$clean_full_ext = "%R.bbl %R.fls %R.pyg %R.nav %R.run.xml %R.snm %R.vrb %R.??.vrb";

# Use LuaLaTeX by default
$pdf_mode = 4;

# Flags when invoking LuaLaTeX
# - Package "minted" requires --shell-escape
# - Halting on error while showing line no. that caused it
$lualatex_default_switches = "--shell-escape --halt-on-error --file-line-error";

# Alternatively, for continued compiling no matter what:
# $lualatex_default_switches = "--shell-escape --interaction=nonstopmode";
