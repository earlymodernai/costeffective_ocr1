#!/bin/bash


INPUT_PDF=$1
OUTPUT=$2
INITPAGE=$3
FINPAGE=$4


# Create and go to a temporal folder where temporal files are produces
#SCRIPTDIR=$(dirname $(readlink -f "$0")) #path of ththis script
SCRIPTDIR="/path/ocr/postprocess/tesseract/ocr" #
CURRENTDIR=$(pwd)
#TMP_DIR=$(mktemp -d)
TMP_DIR="/path/ocr/postprocess/tesseract/tmp"
cd $TMP_DIR

#cut pdf
pdftk  "$INPUT_PDF" cat "$INITPAGE"-"$FINPAGE" output $TMP_DIR/split.pdf

#convert from pdf to png
pdftoppm -rx 200 -ry 200 -png $TMP_DIR/split.pdf "OCR"


# Do OCR and append to output file
files=$(ls  $TMP_DIR/*.png)
for f in $files; do 
"/path/ocr/postprocess/tesseract/textcleaner" -g -e stretch -f 30 -o 10 -t 60 -s 2 $f $f"_t.png"
tesseract $f"_t.png" $f"_ocr" -l eng
cat $f"_ocr.txt" >> raw_output
done

python $SCRIPTDIR/fix_linebreaks.py raw_output > output

cd $CURRENTDIR
mv $TMP_DIR/output $OUTPUT
#rm -r $TMP_DIR

