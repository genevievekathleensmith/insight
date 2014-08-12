from sklearn.feature_extraction.text import TfidfVectorizer, CountVectorizer, TfidfTransformer
from time import time
import os, os.path
import csv
from bunch import Bunch
import numpy as np
import re
import string
# For strip/clean data. Replace words w/root form, "clean" rids html
from nltk.corpus import wordnet as wn
from nltk import word_tokenize, regexp_tokenize, clean_html
from nltk.stem import WordNetLemmatizer
from nltk.stem import PorterStemmer
#from langid import classify
from sklearn.datasets import load_files


## *************************     Tokenizer      *******************************
# for a list of strings
class CleanLemmaTokenizer(object):  # Returns root form, AND cleans HTML
    def __init__(self):
        self.wnl = WordNetLemmatizer()
    def __call__(self, doc):
        return [self.wnl.lemmatize(t) for t in regexp_tokenize(clean_html(doc), '\w\w+')]
        
class SynsetReplacer(object):
    def replace(self, word, pos=None):
        synset=wn.synsets(word)  #Ordered by commonality, so 1st is best
        if len(synset) >= 1:
            return synset[0].name  ## first synonym is the most common
        else:
            return word   
            
class CleanLemmaSynsetTokenizer(object):
    def __init__(self):
        self.wnl = WordNetLemmatizer()
        self.replacer = SynsetReplacer()
    def __call__(self, doc):
        return [self.replacer.replace(self.wnl.lemmatize(t)) for t in regexp_tokenize(clean_html(doc), '\w\w+')]
        
class CleanPorterTokenizer(object):
    def __init__(self):
        self.ps = PorterStemmer()
    def __call__(self, doc):
        return [self.ps.stem(t) for t in regexp_tokenize(clean_html(doc), '\w\w+')]

## *************************    VECTORIZE DATA      *******************************
# FOR GETTING Feature words: print '\', \''.join([features[i] for i in PS]) 
def preprocess_num(data):
    for i in range(len(data)):
        data[i]=data[i].lower()
        data[i]=data[i].translate(string.maketrans("",""), string.punctuation)
        data[i]=re.sub('\s[2][0-1][0-9][0-9]\s', ' YEAR_tag ', data[i])
        data[i]=re.sub('\s[0-9]+\s', ' NUM_tag ', data[i])
        data[i]=re.sub('\s([0-9]|[a-z])([0-9]|[a-z])+[0-9]([0-9]|[a-z])+\s', ' SERIAL_tag ', data[i])
        
# def preprocess(data):
    # PS_WORDS=frozenset(['appliance', 'battery', 'blade', 'bought', 'broken', 'bulb', 'buy', 'car', 'cost', 'dishwasher', 'dispenser', 'door', 'drill', 'dryer', 'filter', 'freezer', 'fridge', 'glass', 'guarantee', 'handle', 'hole','hose', 'ice', 'instruction', 'iron', 'item', 'light', 'machine', 'manual', 'model', 'new', 'order', 'oven', 'problem', 'product', 'purchase', 'refrigerator', 'replace', 'replacement', 'spare', 'spin', 'spring', 'tool', 'used', 'warranty', 'wash', 'washer', 'washing', 'water'])
    # HR_WORDS=frozenset(['application', 'apply', 'bachelor', 'business', 'career', 'college', 'cv', 'department', 'design', 'employment', 'engineer', 'engineering', 'experience', 'german', 'germany', 'graduate','growth', 'hr', 'industry','internship', 'job', 'join', 'junior', 'madam', 'management', 'manager', 'master', 'month', 'opening', 'opportunity', 'organisation', 'phd', 'placement', 'position', 'process', 'profile', 'program', 'project', 'recruitment', 'related', 'resource', 'resume', 'skill','student', 'study', 'studying', 'team', 'trainee', 'training', 'university', 'wish'])
    # SALUTATION_WORDS=frozenset(['hi','hello','dear','bye','thank', 'thanks','best', 'cheers'])
    # PS_regex = re.compile('\s('+'|'.join(PS_WORDS)+')\s')
    # HR_regex = re.compile('\s('+'|'.join(HR_WORDS)+')\s')
    # SAL_regex = re.compile('\s('+'|'.join(HR_WORDS)+')\s')
    # wnl = WordNetLemmatizer()
    # for i in range(len(data)):
        # data[i]=data[i].lower()
        # data[i]=data[i].translate(string.maketrans("",""), string.punctuation)
        # data[i]=' '.join([wnl.lemmatize(tok) for tok in data[i].split()])
        # data[i]=re.sub('\s[2][0-1][0-9][0-9]\s', ' YEAR_tag ', data[i])
        # data[i]=re.sub('\s[0-9]+\s', ' NUM_tag ', data[i])
        # data[i]=re.sub('\s([0-9]|[a-z])([0-9]|[a-z])+[0-9]([0-9]|[a-z])+\s', ' SERIAL_tag ', data[i])
        # data[i]=re.sub(PS_regex, ' PS_tag ', data[i])
        # data[i]=re.sub(HR_regex, ' HR_tag ', data[i])
        # data[i]=re.sub(SAL_regex, ' SAL_tag ', data[i])
    
def fit_vectorizer(data):    
    print("Creating Vectorizer...")
    t0 = time()
    myTokenizer=CleanLemmaTokenizer()   # Select the Tokenizer to use
    #myTokenizer=CleanLemmaSynsetTokenizer() 
    #myTokenizer=CleanPorterTokenizer() 
    vectorizer = TfidfVectorizer(max_features=2000, tokenizer=myTokenizer,
        stop_words='english', use_idf=True, binary=False, charset_error='ignore',  max_df=.99)
    vectorizer.fit(data)
    print("done in %fs" % (time() - t0))
    return vectorizer

def fit_count_vectorizer(data):
    print("Creating Count Vectorizer...")
    t0 = time()
    myTokenizer = CleanLemmaTokenizer()
    vectorizer = CountVectorizer(max_features = 2000, tokenizer = myTokenizer,
                                 stop_words = 'english', binary =True, charset_error='ignore', max_df =.99)
    vectorizer.fit(data)
    print("done in %fs" %(time() - t0))
    return vectorizer

## *************************    Group Features      *******************
def category_features(X, target, target_val, vectorizer):
    indices = [i for i, x in enumerate(target) if x == target_val]
    X_target_sums=np.sum(X[indices], axis=0)
    features=vectorizer.get_feature_names()
    # for i, x in sorted(enumerate(X_target_sums), key=lambda tup:tup[1], reverse=True)[:30]:
        # print features[i], x
    top_features=[i for i,x in sorted(enumerate(X_target_sums), key=lambda tup:tup[1], reverse=True)]
    return top_features
