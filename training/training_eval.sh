cd gtd
cp -r ../tesseracttrain/makedata/training_gt data/gtd-ground-truth
# training
nohup make training MODEL_NAME=gtd START_MODEL=eng TESSDATA=../tessdata_best MAX_ITERATIONS=10000 > plot/TESSTRAIN.LOG &
# create model and eval plot from training
nohup make traineddata LSTMevalCER plotCER MODEL_NAME=gtd Y_MAX_CER=10 --debug=vij > data/logs/TESSEVAL.LOG &
# evaluation
nohup lstmeval --model data/gtd.traineddata --eval_listfile data/gtd/list.eval --verbosity 2 > data/gtd-eval-list.log &