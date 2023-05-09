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
def item_df(df):
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
            lst.append(raw_data[summoner]['win'])
            result.append(lst)
    columns = ['championId', 'mythicItemUsed', 'item0', 'item1', 'item2', 'item3', 'item4', 'item5', 'item6', 'win']
    item_df = pd.DataFrame(result, columns=columns)
    item_df['win'] = item_df['win'].astype(int)

    return item_df


item_df = item_df(df)


# ----------------------------------------------------------------------------------------------------------------------
# 챔피언 신발 데이터
def shoes_data(item_df):
    shoe_items = [3111, 3117, 3009, 3047, 3006, 3158, 3020]
    champion_shoe_counts = {}
    champion_win_counts = {}

    for row in tqdm(item_df.itertuples()):
        champion_id = row.championId
        if champion_id not in champion_shoe_counts:
            champion_shoe_counts[champion_id] = {item: 0 for item in shoe_items}
            champion_win_counts[champion_id] = {item: 0 for item in shoe_items}

        for item in shoe_items:
            if item in row[3:10]:
                champion_shoe_counts[champion_id][item] += 1
                if row.win:
                    champion_win_counts[champion_id][item] += 1

    result = []
    for champion_id, shoe_counts in tqdm(champion_shoe_counts.items()):
        for item_id, count in shoe_counts.items():
            win_count = champion_win_counts[champion_id][item_id]
            result.append([champion_id, item_id, count, win_count])

    columns = ['championId', 'itemId', 'usage_count', 'win_count']
    shoe_items_df = pd.DataFrame(result, columns=columns)

    shoe_items_df['winrate'] = round((shoe_items_df['win_count'] / shoe_items_df['usage_count']) * 100, 2)

    def rank_items(group):
        group['rank'] = group['usage_count'].rank(ascending=False, method='first')
        group.loc[group['rank'] == 2, 'rank'] = group[group['rank'] == 2]['winrate'].rank(ascending=False,
                                                                                          method='first') + 1
        return group

    shoe_items_df = shoe_items_df.groupby('championId', group_keys=True).apply(rank_items)

    top_2_shoes_per_champion = shoe_items_df[shoe_items_df['rank'].isin([1, 2])]

    merged_df = top_2_shoes_per_champion.copy()
    merged_df['rank'] = merged_df['rank'].astype(int)
    merged_df = merged_df[['championId', 'itemId', 'usage_count', 'win_count', 'winrate', 'rank']]
    merged_df = merged_df.fillna(0)
    return merged_df


shoes_data = shoes_data(item_df)


# ----------------------------------------------------------------------------------------------------------------------
# 신화 아이템 정제
def get_top_mythic_items(df):
    result = []
    for i in tqdm(range(len(df))):
        raw_data = df.iloc[i]['matches']['info']['participants']
        for summoner in range(len(raw_data)):
            champion_id = raw_data[summoner]['championId']
            mythic_item_used = raw_data[summoner]['challenges']['mythicItemUsed'] if 'mythicItemUsed' in \
                                                                                     raw_data[summoner][
                                                                                         'challenges'] else 0
            win = raw_data[summoner]['win']
            result.append([champion_id, mythic_item_used, win])

    item_df = pd.DataFrame(result, columns=['championId', 'mythicItemUsed', 'win'])
    item_df['mythicItemUsed'] = item_df['mythicItemUsed'].astype(int)
    item_df['win'] = item_df['win'].astype(int)

    item_df = item_df[item_df['mythicItemUsed'] != 0]

    top_items = []
    for champion_id, group in item_df.groupby('championId'):
        top_items_df = group.groupby('mythicItemUsed').agg({'mythicItemUsed': 'count', 'win': 'sum'})
        top_items_df.columns = ['usage_count', 'win_count']
        top_items_df['winrate'] = round((top_items_df['win_count'] / top_items_df['usage_count']) * 100, 2)
        top_items_df = top_items_df.sort_values(['usage_count', 'winrate'], ascending=[False, False])
        top_items_df = top_items_df.iloc[:3].reset_index()
        top_items_df['championId'] = champion_id
        top_items.append(top_items_df)

    top_items_df = pd.concat(top_items)
    top_items_df['rank'] = top_items_df.groupby('championId')['usage_count'].rank(ascending=False, method='first')

    return top_items_df[['championId', 'mythicItemUsed', 'usage_count', 'win_count', 'winrate', 'rank']]


mysitic_item_data = get_top_mythic_items(df)
# ----------------------------------------------------------------------------------------------------------------------
# 아이템 정제 (신화, 신발 제외)
mysitic_item_lst = mysitic_item_data['mythicItemUsed'].unique()
shoes_lst = [3111, 3117, 3009, 3047, 3006, 3158, 3020]


def top_item_data(item_df):
    item_columns = ['item0', 'item1', 'item2', 'item3', 'item4', 'item5']
    melted_df = item_df.melt(id_vars=['championId', 'win'], value_vars=item_columns, var_name='item_col',
                             value_name='itemId')

    non_zero_items = melted_df[melted_df['itemId'] != 0]
    item_frequency = non_zero_items.groupby(['championId', 'itemId']).size().reset_index(name='frequency')
    # 승리한 경우의 아이템 사용 횟수 집계
    non_zero_items_wins = non_zero_items[non_zero_items['win'] == 1]
    item_wins = non_zero_items_wins.groupby(['championId', 'itemId']).size().reset_index(name='wins')

    # item_frequency에 승리 횟수를 추가
    item_frequency = item_frequency.merge(item_wins, on=['championId', 'itemId'], how='left')
    item_frequency['wins'].fillna(0, inplace=True)

    def top_n_items(df, excluded_items, n=3):
        df_filtered = df[~df['itemId'].isin(excluded_items)]
        return df_filtered.nlargest(n, 'frequency')

    # 제외할 아이템 목록 정의
    mysitic_item_lst = mysitic_item_data['mythicItemUsed'].unique()
    shoes_lst = [3111, 3117, 3009, 3047, 3006, 3158, 3020]
    excluded_items = list(mysitic_item_lst) + shoes_lst

    # 제외할 아이템 목록을 전달하여 상위 10개의 아이템을 추출
    top_items_df = item_frequency.groupby('championId', group_keys=False).apply(
        lambda x: top_n_items(x, excluded_items))
    top_items_df['wins'] = top_items_df['wins'].astype(int)
    top_items_df['winrate'] = round((top_items_df['wins'] / top_items_df['frequency']) * 100, 2)
    return top_items_df


top_item_data = top_item_data(item_df)
# ----------------------------------------------------------------------------------------------------------------------
