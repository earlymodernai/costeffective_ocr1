# evaluation script used with chainforge, modified from https://github.com/impresso/llm-transcript-postcorrection

import Levenshtein
from Levenshtein import distance
def compute_normalized_levenshtein_similarity(ground_truth_text, ocr_text):
    length = max(len(ocr_text), len(ground_truth_text))
    # Check if both strings are empty
    if length == 0:
        return 1.0
    levenshtein_distance = distance(ocr_text, ground_truth_text)
    similarity = (length - levenshtein_distance) / length
    return similarity


def get_improvement(original_similarity, corrected_similarity):
    
    if original_similarity == 0:
        return min(max(corrected_similarity, -1), 1)
    elif original_similarity != corrected_similarity:
        return min(max((corrected_similarity - original_similarity) / original_similarity, -1), 1)
    elif original_similarity == corrected_similarity:
        return 0
    else:
        return 0 if corrected_similarity < 1 else 1
        
def evaluate(response):
  print(response.meta)
  if('gt' in response.meta):
    original_similarity = compute_normalized_levenshtein_similarity(response.meta['gt'], response.var['eng'])
    corrected_similarity = compute_normalized_levenshtein_similarity(response.meta['gt'], response.text)
    return get_improvement(original_similarity, corrected_similarity)
  return 0
    