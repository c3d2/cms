#!/bin/bash
# This script places two copies of an A5-sized, landscape-oriented
# PDF document on a new, A4-sized, portrait-oriented file.
# Inspired by: http://tex.stackexchange.com/questions/142187
# This Bash script was written by Daniel Kraus in 2013
# and released into the public domain.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

if [[ -z "$2" ]]; then
  echo "Combines two landscape A5 PDFs into one portrait A4 pdf."
  echo "Usage: $(basename $0) input[.pdf] output[.pdf] [--noframe]"
  exit
fi

# Strip any .PDF extensions from the file names.
INFILE="${1%\.pdf}"
OUTFILE="${2%\.pdf}"

# If the third parameter is *not* "--noframe", set a variable accordingly.
[[ "$3" == "--noframe" ]] || FRAME=frame

# Check if the files exist.
if [[ ! -e "$INFILE.pdf" ]]; then 
  echo "The input file $INFILE.pdf was not found."
  exit 1
fi
if [[ -e "$OUTFILE.pdf" ]]; then
  echo "The output file $OUTFILE.pdf exists already."
  echo "For your own safety, this script does not automatically overwrite files."
  echo "Therefore, please issue 'rm $OUTFILE.pdf' first."
  exit 2
fi

# Write the current date and time to the log file.
echo "*** $(date -R) ***" >> "$OUTFILE.log"

# Invoke the pdflatex program, feeding it a minimal tex document which
# serves to combine the input file. Output is appended to a log file
# whose name is derived from the output file.
# Note how we use a heredoc *without* preventing substitution (which
# could have been accomplished by quoting the EOF), so that we can
# dynamically place the input file into the tex document.
pdflatex -jobname $OUTFILE >> "$OUTFILE.log" 2>&1 <<-EOF
  \\documentclass[a4paper]{article}
  \\usepackage{pdfpages}
  \\usepackage[pdftex,
    pdfauthor=$(whoami),
    pdfcreator=http://xltoolbox.sf.net/blog/2013/12/combining-two-a5-pages-into-one-a4-page]{hyperref}
  \\usepackage[margin=0cm,showframe]{geometry}
  \\begin{document}
    \\includepdf[nup=1x2,pages={1,1},$FRAME]{$INFILE}
  \\end{document}
  EOF

echo >> "$OUTFILE.log"
cat <<-EOF
  Finished combining two copies of the input file into the output file.
  Please note that a few auxiliary files were produced by the programs that
  pdflatex invokes. This cannot be suppressed.
  Here is a list of corresponding files:
  EOF
ls $OUTFILE.*
