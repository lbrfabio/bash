
out=`basename -s .pdf "$1"`-zipped.pdf
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=true -dColorImageResolution=600 -dNOPAUSE  -dBATCH -sOutputFile=$out "$1"
