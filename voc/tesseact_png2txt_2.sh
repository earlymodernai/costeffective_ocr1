#!/bin/bash
#generate OCR text from png, OCR text can also be downloaded from Internet Archive https://archive.org/ and HathiTrust https://www.hathitrust.org/ 
SOURCE="./pngpath"
model=eng
set -- "$SOURCE"*.png
for img_file; do
    tesseract -l "$model" "$img_file" "${img_file%.*}".txt 
    
done
