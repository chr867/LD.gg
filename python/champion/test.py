import json

import time
import pandas as pd
from tqdm import tqdm
import my_utils as mu
def item_df(item_list):
    columns = ['championId', 'teamPosition', 'mythicItem', 'item0', 'item1', 'item2', 'item3', 'item4', 'item5',
               'item6', 'win']
    item_df = pd.DataFrame(item_list, columns=columns)
    item_df['win'] = item_df['win'].astype(int)
    print("아이템 데이터 정제 완료 ")
    return

def common_item_data(item_df):
    shoe_items = set([3111, 3117, 3009, 3047, 3006, 3158, 3020])
    mythic_items = set(item_df.mythicItem.unique())

    item_list = []

    for _, player in tqdm(item_df.iterrows()):
        for i in range(6):
            item = player[f'item{i}']
            win = player.win

            if item > 3000 and item not in shoe_items and item not in mythic_items:
                item_list.append([player.championId, player.teamPosition, item, win])

    columns = ['championId', 'teamPosition', 'itemId', 'win']
    items = pd.DataFrame(item_list, columns=columns)


    grouped = items.groupby(['championId', 'teamPosition', 'itemId']).agg({
        'win': ['count', 'sum'],
    }).reset_index()
    grouped.columns = ['championId', 'teamPosition', 'itemId', 'pickCount', 'winCount']
    total_games = grouped.groupby(['championId', 'teamPosition']).agg({'pickCount': 'sum'}).rename(columns={'pickCount': 'totalGames'})
    grouped = grouped.merge(total_games, on=['championId', 'teamPosition'])
    grouped['pickRate'] = round(grouped['pickCount'] / grouped['totalGames']*100,2)
    grouped['winRate'] = round(grouped['winCount'] / grouped['pickCount']*100,2)
    grouped = grouped[grouped['pickCount'] > 10]
    grouped = grouped[['championId', 'teamPosition', 'itemId', 'pickRate', 'winRate']]
    return grouped

item_list = []

# 아이템 데이터 정제
conn = mu.connect_mysql()
query = f"SELECT matches, timeline FROM match_raw_patch LIMIT 30000"
df = pd.DataFrame(mu.mysql_execute_dict(query, conn))
conn.close()

df['matches'] = df['matches'].apply(json.loads)
df['timeline'] = df['timeline'].apply(json.loads)

for i in tqdm(range(len(df))):
    participants = df.iloc[i]['matches']['participants']
    for summoner in range(len(participants)):
        lst = []
        lst.append(participants[summoner]['championId'])
        lst.append(participants[summoner]['teamPosition'])
        try:
            lst.append(participants[summoner]['mythicItemUsed'])
        except:
            lst.append(0)
        lst.append(participants[summoner]['item0'])
        lst.append(participants[summoner]['item1'])
        lst.append(participants[summoner]['item2'])
        lst.append(participants[summoner]['item3'])
        lst.append(participants[summoner]['item4'])
        lst.append(participants[summoner]['item5'])
        lst.append(participants[summoner]['item6'])
        lst.append(participants[summoner]['win'])
        item_list.append(lst)

columns = ['championId', 'teamPosition', 'mythicItem', 'item0', 'item1', 'item2', 'item3', 'item4', 'item5',
               'item6', 'win']
item_df = pd.DataFrame(item_list, columns=columns)
item_df['win'] = item_df['win'].astype(int)
print("아이템 데이터 정제 완료 ")

item_df = item_df(item_list)
# common_item_data = common_item_data(item_df)

shoe_items = set([3111, 3117, 3009, 3047, 3006, 3158, 3020])
mythic_items = set(item_df.mythicItem.unique())

item_list = []

for _, player in tqdm(item_df.iterrows()):
    for i in range(6):
        item = player[f'item{i}']
        win = player.win

        if item > 3000 and item not in shoe_items and item not in mythic_items:
            item_list.append([player.championId, player.teamPosition, item, win])

columns = ['championId', 'teamPosition', 'itemId', 'win']
items = pd.DataFrame(item_list, columns=columns)


grouped = items.groupby(['championId', 'teamPosition', 'itemId']).agg({
    'win': ['count', 'sum'],
}).reset_index()
grouped.columns = ['championId', 'teamPosition', 'itemId', 'pickCount', 'winCount']
total_games = grouped.groupby(['championId', 'teamPosition']).agg({'pickCount': 'sum'}).rename(columns={'pickCount': 'totalGames'})
grouped = grouped.merge(total_games, on=['championId', 'teamPosition'])
grouped['pickRate'] = round(grouped['pickCount'] / grouped['totalGames']*100,2)
grouped['winRate'] = round(grouped['winCount'] / grouped['pickCount']*100,2)
grouped = grouped[grouped['pickCount'] > 10]
grouped = grouped[['championId', 'teamPosition', 'itemId', 'pickRate', 'winRate']]


testt= grouped[grouped['championId'] == 1]
