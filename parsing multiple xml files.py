
# coding: utf-8

# In[1]:

from lxml import etree, objectify
from io import StringIO, BytesIO
import pandas as pd


# In[2]:

tree = etree.parse("14-28-RAW-Solr-1_toparse.xml")
root = tree.getroot()


# In[3]:

mylist = []
for doc in root.findall('doc'):
    mylist.append(dict([(i.values()[0], i.getchildren()[0].text) for i in doc.getchildren() if i.values()[0]!='score']))


# In[4]:

len(mylist)


# In[5]:

tree = etree.parse("14-28-RAW-Solr-4_toparse.xml")
root = tree.getroot()


# In[6]:

for doc in root.findall('doc'):
    mylist.append(dict([(i.values()[0], i.getchildren()[0].text) for i in doc.getchildren() if i.values()[0]!='score']))


# In[7]:

len(mylist)


# In[8]:

tree = etree.parse("14-28-RAW-Solr-5_toparse.xml")
root = tree.getroot()


# In[9]:

for doc in root.findall('doc'):
    mylist.append(dict([(i.values()[0], i.getchildren()[0].text) for i in doc.getchildren() if i.values()[0]!='score']))


# In[10]:

len(mylist)


# In[11]:

mylist[-1]


# In[12]:

#tree = etree.parse("14-28-RAW-Solr-2_toparse.xml")


# In[13]:

#tree = etree.parse("14-28-RAW-Solr-3a_toparse.xml")


# In[14]:

#tree = etree.parse("14-28-RAW-Solr-3b_toparse.xml")


# In[14]:




# In[14]:




# In[15]:

mylist[0:2]

comments = [d['text'] for d in mylist]


# In[16]:

len(comments)


# In[17]:

from __future__ import division  # Python 2 users only
import nltk, re, pprint
from nltk import word_tokenize
from gensim import corpora, models, similarities


# In[18]:

words = word_tokenize(comments[0])


# In[19]:

#[w.lower() for w in words]
#[nltk.LancasterStemmer().stem(word) for word in words]
#' '.join(words)


# In[20]:

stoplist = set('for a of the and to in'.split())
texts = [[word for word in comment.lower().split() if word not in stoplist]
          for comment in comments]


# In[23]:

type(texts)
len(texts)


# In[ ]:

all_tokens = sum(texts)


# In[ ]:



tokens_once = set(word for word in set(all_tokens) if all_tokens.count(word) == 1)
texts = [[word for word in text if word not in tokens_once]
          for text in texts]


dictionary = corpora.Dictionary(texts)
dictionary.save('/tmp/deerwester.dict') # store the dictionary, for future reference
print(dictionary)

print(dictionary.token2id)

corpus = [dictionary.doc2bow(text) for text in texts]
print(corpus)


tfidf = models.TfidfModel(corpus)
index = similarities.SparseMatrixSimilarity(tfidf[corpus], num_features=12)

