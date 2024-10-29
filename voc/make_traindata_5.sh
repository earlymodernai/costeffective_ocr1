#!/bin/bash
#generate ground truth pairs from png
SOURCE="./pngpath"
lang=eng
set -- "$SOURCE"*.png
for img_file; do
    echo -e  "\r\n File: $img_file"
    OMP_THREAD_LIMIT=1 tesseract "${img_file}" "${img_file%.*}"  --psm 6  --oem 1  -l $lang -c page_separator='' hocr
    PYTHONIOENCODING=UTF-8 hocr-extract-images -b "$SOURCE" -p "${img_file%.*}"-%03d.exp0.tif  "${img_file%.*}".hocr 

done
rename s/exp0.txt/exp0.gt.txt/ "$SOURCE"*exp0.txt
echo "Image files converted to tif. Correct the ground truth files and then run ocr-d train to create box and lstmf files"
