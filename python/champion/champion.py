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
# ----------------------------------------------------------------------------------------------------------------------
# RawData
conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict("SELECT match_id,matches FROM match_raw LIMIT 5000", conn))
conn.close()
df['matches'] = df['matches'].apply(json.loads)


# ----------------------------------------------------------------------------------------------------------------------
# 룬 데이터 정제
def rune_data(df):
    result = []
    print("룬데이터 추출 시작")
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
    print("룬데이터 추출완료")
    print("룬데이터 데이터프레임 제작 시작")
    columns = ['champion_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID',
               'MAIN_SUB2_ID',
               'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID', 'WIN']

    rune_df = pd.DataFrame(result, columns=columns)
    rune_df['WIN'] = rune_df['WIN'].astype(int)
    print("룬데이터 데이터프레임 제작완료")
    print("룬데이터 정제 시작")
    new_df = rune_df[['champion_id', 'WIN']].join(rune_df.iloc[:, 1:12].apply(tuple, axis=1).rename('rune_combination'))

    rune_count = new_df.groupby(['champion_id', 'rune_combination']).agg({'WIN': ['sum', 'size']}).reset_index()
    rune_count.columns = ['champion_id', 'rune_combination', 'win_count', 'total_game']
    rune_count = rune_count.rename(columns={'WIN/sum': 'win_count', 'WIN/size': 'total_game'})

    top_runes = pd.concat(
        [rune_count.loc[rune_count['champion_id'] == cid].sort_values(by='total_game', ascending=False)[:2] for cid in
         rune_count['champion_id'].unique()])
    top_runes['winrate'] = round((top_runes['win_count'] / top_runes['total_game']) * 100, 2)

    top_runes[['FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID', 'MAIN_SUB2_ID',
               'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID']] \
        = top_runes['rune_combination'].apply(pd.Series)
    top_runes = top_runes.drop('rune_combination', axis=1)
    new_column_order = ['champion_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID',
                        'MAIN_SUB1_ID', 'MAIN_SUB2_ID', 'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID',
                        'SUB_SUB1_ID', 'SUB_SUB2_ID', 'win_count', 'total_game', 'winrate']
    top_runes = top_runes.reindex(columns=new_column_order)
    print("룬데이터 정제완료")
    return top_runes


rune_data = rune_data(df)
# ----------------------------------------------------------------------------------------------------------------------
# 아이템 데이터 정제
df.iloc[0]['matches']['info']['participants'][0]['item0']
df.iloc[0]['matches']['info']['participants'][4]['challenges']['mythicItemUsed']
result = []
for i in tqdm(range(len(df))):
    raw_data = df.iloc[i]['matches']['info']['participants']
    for summoner in range(len(raw_data)):
        lst = []
        lst.append(raw_data[summoner]['championId'])
        try:
            lst.append(raw_data[summoner]['challenges']['mythicItemUsed'])
        except:
            lst.append(0)
        lst.append(raw_data[summoner]['item0'])
        lst.append(raw_data[summoner]['item1'])
        lst.append(raw_data[summoner]['item2'])
        lst.append(raw_data[summoner]['item3'])
        lst.append(raw_data[summoner]['item4'])
        lst.append(raw_data[summoner]['item5'])
        lst.append(raw_data[summoner]['item6'])
        result.append(lst)
columns = ['championId','mythicItemUsed','item0','item1','item2','item3','item4','item5','item6']
item_df = pd.DataFrame(result,columns=columns)

item_df.iloc[0]

item_columns = ['item0', 'item1', 'item2', 'item3', 'item4', 'item5']
melted_df = item_df.melt(id_vars=['championId'], value_vars=item_columns, var_name='item_col', value_name='itemId')

non_zero_items = melted_df[melted_df['itemId'] != 0]
item_frequency = non_zero_items.groupby(['championId', 'itemId']).size().reset_index(name='frequency')


def top_n_items(df, n=4):
    return df.nlargest(n, 'frequency')

top_items_df = item_frequency.groupby('championId', group_keys=False).apply(top_n_items)


