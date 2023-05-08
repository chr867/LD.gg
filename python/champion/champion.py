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

tqdm.pandas()

# RIOT-API-KEY
riot_api_key = 'RGAPI-14667a4e-7c3c-45fa-ac8f-e53c7c3f5fe1'
# --------------------------------------------------------

conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict("select * from match_raw", conn))
conn.close()
df['matches'] = df['matches'].apply(json.loads)
raw_data = df.iloc[0]['matches']['info']['participants']
raw_data[0]['championId']
raw_data[7]['perks']['statPerks']['defense']
raw_data[7]['perks']['statPerks']['flex']
raw_data[7]['perks']['statPerks']['offense']
raw_data[0]['perks']['styles'][1]
raw_data[0]['perks']['styles'][0]

for primaryRune in range(len(raw_data[0]['perks']['styles'][0]['selections'])):
    raw_data[0]['perks']['styles'][0]['selections'][primaryRune]['perk']
for subStyleRune in range(len(raw_data[0]['perks']['styles'][1]['selections'])):
    raw_data[0]['perks']['styles'][0]['selections'][subStyleRune]['perk']

# ----------------------------------------------------------------------------------------------------------------------
conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict("select * from match_raw", conn))
conn.close()
df['matches'] = df['matches'].apply(json.loads)

df.iloc[0]['matches']['info']['participants'][0]['win']
result = []
for i in tqdm(range(len(df))):
    raw_data = df.iloc[i]['matches']['info']['participants']
    for summoner in range(len(raw_data)):
        lst = []
        lst.append(raw_data[summoner]['championId'])
        lst.append(raw_data[summoner]['perks']['statPerks']['defense'])
        lst.append(raw_data[summoner]['perks']['statPerks']['flex'])
        lst.append(raw_data[summoner]['perks']['statPerks']['offense'])
        lst.append(raw_data[summoner]['perks']['styles'][0]['style'])
        for primaryRune in range(len(raw_data[summoner]['perks']['styles'][0]['selections'])):
            lst.append(raw_data[summoner]['perks']['styles'][0]['selections'][primaryRune]['perk'])
        lst.append(raw_data[summoner]['perks']['styles'][1]['style'])
        for subStyleRune in range(len(raw_data[summoner]['perks']['styles'][1]['selections'])):
            lst.append(raw_data[summoner]['perks']['styles'][0]['selections'][subStyleRune]['perk'])
        lst.append(raw_data[summoner]['win'])
        result.append(lst)

columns = ['champion_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID',
           'MAIN_SUB2_ID',
           'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID','WIN']

rune_df = pd.DataFrame(result, columns=columns)
rune_df['WIN'] = rune_df['WIN'].astype(int)

new_df = rune_df[['champion_id', 'WIN']].join(rune_df.iloc[:, 1:12].apply(tuple, axis=1).rename('rune_combination'))

new_df['count'] = 0
rune_count = new_df.groupby(['champion_id', 'rune_combination'])['count'].size().reset_index()


rune_count = new_df.groupby(['champion_id', 'rune_combination']).agg({'WIN': ['sum', 'size']}).reset_index()
rune_count.columns = ['champion_id', 'rune_combination', 'win_count', 'total_game']
rune_count = rune_count.rename(columns={'WIN/sum': 'win_count', 'WIN/size': 'total_game'})

top_runes = pd.concat([rune_count.loc[rune_count['champion_id'] == cid].sort_values(by='total_game', ascending=False)[:2] for cid in rune_count['champion_id'].unique()])
top_runes['winrate'] = round((top_runes['win_count']/top_runes['total_game'])*100, 2)

result_df = top_runes

result_df[['FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID', 'MAIN_SUB2_ID',
           'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID']] \
            = result_df['rune_combination'].apply(pd.Series)
result_df = result_df.drop('rune_combination', axis=1)
new_column_order = ['champion_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID', 'MAIN_SUB2_ID', 'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID', 'win_count', 'total_game', 'winrate']
result_df = result_df.reindex(columns=new_column_order)

result_df