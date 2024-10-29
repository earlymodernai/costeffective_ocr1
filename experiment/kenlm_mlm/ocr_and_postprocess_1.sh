
start_time="$(date -u +%s)"


INPUT_PDF=$1
OUTPUT=$2
INITPAGE=$3
FINPAGE=$4



#SCRIPTDIR=$(dirname $(readlink -f "$0")) #path of ththis script
#SCRIPTDIR=$(dirname $(readlink "$0")) #path of ththis script
SCRIPTDIR="."

OUTPUTRAW=$OUTPUT".raw"
REPL_DICT='./replacement_dictionary'


#DO OCR
bash $SCRIPTDIR/ocr/do_OCR.sh $INPUT_PDF $OUTPUTRAW $INITPAGE $FINPAGE

ocr_time="$(date -u +%s)"
ocr_elapsed="$(($ocr_time-$start_time))"
printf "ocr_elapsedtime:$ocr_elapsed\n" >> $OUTPUT"_time"

#POSTPROCESS
python3 $SCRIPTDIR/postprocess/get_replacement_dict.py $OUTPUTRAW > $REPL_DICT
#python $SCRIPTDIR/postprocess/postprocess_text.py $OUTPUTRAW $REPL_DICT > $OUTPUT

dict_time="$(date -u +%s)"
dict_elapsed="$(($dict_time-$ocr_time))"
printf "dict_elapsedtime:$dict_elapsed\n" >> $OUTPUT"_time"

python3 $SCRIPTDIR/postprocess/postprocess_text.py $OUTPUTRAW $REPL_DICT > $OUTPUT

process_time="$(date -u +%s)"
process_elapsed="$(($process_time-$dict_time))"
printf "process_elapsedtime:$process_elapsed\n" >> $OUTPUT"_time"

end_time="$(date -u +%s)"
elapsed="$(($end_time-$start_time))"
printf "total_elapsedtime:$elapsed\n" >> $OUTPUT"_time"

