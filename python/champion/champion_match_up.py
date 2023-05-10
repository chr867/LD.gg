# --------------------------------------------------------
# Package
import bs4
import pandas as pd
import requests
import cx_Oracle
import pymysql
from requests import request
from tqdm import tqdm
import my_utils as mu
import json
import time
import numpy as np
tqdm.pandas()

# RIOT-API-KEY
riot_api_key = 'RGAPI-95fae2eb-b7c8-4aad-a2d4-7d6dea9cd91b'
# ----------------------------------------------------------------------------------------------------------------------
# RawData
conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict("SELECT * FROM match_raw LIMIT 5000", conn))
conn.close()
df['matches'] = df['matches'].apply(json.loads)
df['timeline'] = df['timeline'].apply(json.loads)