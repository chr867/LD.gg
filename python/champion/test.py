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

    shoe_items = [3111, 3117, 3009, 3047, 3006, 3158, 3020]
    mythic_items = item_df.mythicItem.unique()
    for item in item_df:


    # top_items = []
    # for (championId, teamPosition), group in item_df.groupby(['championId', 'teamPosition']):
    #     top_items_df = group.groupby('itemId').agg({'itemId': 'count', 'win': 'sum'})
    #     top_items_df.columns = ['pickCount', 'winCount']
    #     top_items_df['winRate'] = round((top_items_df['winCount'] / top_items_df['pickCount']) * 100, 2)
    #     top_items_df = top_items_df[top_items_df['pickCount'] > 10]  # pickCount가 10 이하인 행 제거
    #     top_items_df = top_items_df.sort_values(['pickCount', 'winRate'], ascending=[False, False])
    #     top_items_df = top_items_df.iloc[:5].reset_index()
    #     top_items_df['championId'] = championId
    #     top_items_df['teamPosition'] = teamPosition
    #     top_items.append(top_items_df)
    #
    # top_items_df = pd.concat(top_items)
    # top_items_df['rank'] = top_items_df.groupby(['championId', 'teamPosition'])['pickCount'].rank(ascending=False,
    #                                                                                               method='first')
    # top_items_df['rank'] = top_items_df['rank'].astype(int)
    #
    # total_game_df = item_df.groupby(['championId', 'teamPosition']).agg({'win': ['count']})
    # total_game_df.columns = ['total_game']
    # total_game_df.reset_index(inplace=True)
    # merged_df = pd.merge(top_items_df, total_game_df, on=['championId', 'teamPosition'])
    # merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['total_game']) * 100, 2)
    # final_df = merged_df.drop(columns=['total_game'])
    # print("일반 아이템 데이터 정제 완료 ")
    # return final_df[['championId', 'teamPosition', 'itemId', 'pickCount', 'winCount', 'winRate', 'pickRate']]

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


item_df = item_df(item_list)
common_item_data = common_item_data(item_df)