

import pymysql as mdb
import json
import pandas as pd
import scipy as sp

json_data = open('comments_typo_fixed.json')
data = json.load(json_data)

info_keys = ['applicant','city','zip','state','date']
info = pd.DataFrame(data, columns = info_keys)

state_counts = info.state.value_counts()
counts_df = pd.DataFrame(state_counts)
counts_df['state']=counts_df.index
counts_df.columns = ['comments','state']
population = pd.read_csv('state_totals.csv',header=None)
population.columns = ['state','population']
per_capita_comments = pd.merge(counts_df,population)
per_capita_comments['percapita'] = per_capita_comments.comments/per_capita_comments.population



CREATE DATABASE