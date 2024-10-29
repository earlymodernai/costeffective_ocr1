# Cost-effective OCR - GTD

Cost-effective Optical Character Recognition (OCR) Text Improvement for the Grand Tour Diaries Dataset

## Introduction

In this project we tried to reduce the time and cost associated with the creation of a ground truth dataset; and reduce the ground truth data needed for training by using existing language models via masked language model scoring and word replacement and fine-tuning this on existing OCR models. We also experimented with large language models on OCR improvement for historical texts.


## Ground truth and Vocabulary list
The processes to reduce the time to create the ground truth, find the vocabulary replacement list and correct the words can be found under [voc/](voc/) folder. The order of the files used can be seen from the _# before the file extension. 

## Experiment

We experimented with masked language model scoring and word replacement by using the toolkits and references below: 
* [mlm-scoring](https://github.com/awslabs/mlm-scoring)
* [Language model built with Gutemberg vocabulary, KenLM and Moses Toolki](https://github.com/alberto-poncelas/tesseract_postprocess/tree/master/resources) (https://github.com/kpu/kenlm, http://www2.statmt.org/moses/)

The modified and used scripts can be found in the [experiment/](experiment/kenlm_mlm/) folder. 

We experimented post-correction with the latest [GPT-4o](https://openai.com/index/gpt-4), [GPT-3.5](https://openai.com/index/gpt-4), [Qwen2.5](https://qwenlm.github.io/blog/qwen2.5/), [Gemma2](https://huggingface.co/docs/transformers/en/model_doc/gemma2), [Llama3.1](https://ai.meta.com/blog/meta-llama-3-1/), and [Mistral-Nemo](https://mistral.ai/news/mistral-nemo/) and compared the results with the best Tesseract English model, ENG. The evaluation was done with the [Chainforge tool](https://github.com/ianarawjo/ChainForge) and the Levenshtein distance algorithm.
The scripts and dataset used can be found under the [experiment/](experiment/llm/) folder. 

## Training & evaluation
The Tesseract training and evaluation make use of the following resources:
* https://github.com/tesseract-ocr/tesstrain
* https://github.com/tesseract-ocr/tesseract
* https://github.com/Shreeshrii/tesstrain

The training files and scripts can be found under the [training/](training/) folder.

## Test

The testing made use of [Tesseract OCR](https://github.com/tesseract-ocr/tesseract), [Dinglehopper](https://github.com/qurator-spk/dinglehopper), and [Chainforge](https://github.com/ianarawjo/ChainForge). The scripts and files used can be found under the [test/](test/) folder.


