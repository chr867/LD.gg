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
riot_api_key = 'RGAPI-14667a4e-7c3c-45fa-ac8f-e53c7c3f5fe1'
# ----------------------------------------------------------------------------------------------------------------------
# RawData
conn = mu.connect_mysql()
start_time = time.time()
df = pd.DataFrame(mu.mysql_execute_dict("SELECT * FROM match_raw", conn))
conn.close()
df['matches'] = df['matches'].apply(json.loads)
df['timeline'] = df['timeline'].apply(json.loads)
end_time = time.time()
print("Data load time: {:.2f} seconds".format(end_time - start_time))

# ----------------------------------------------------------------------------------------------------------------------
# 룬 데이터 정제
def rune_data(raw_data):
    result = []
    print("룬데이터 추출 시작")
    for i in tqdm(range(len(raw_data))):
        df = raw_data.iloc[i]['matches']['info']['participants']
        for summoner in range(len(df)):
            lst = []
            lst.append(df[summoner]['championId'])
            lst.append(df[summoner]['perks']['statPerks']['defense'])
            lst.append(df[summoner]['perks']['statPerks']['flex'])
            lst.append(df[summoner]['perks']['statPerks']['offense'])
            lst.append(df[summoner]['perks']['styles'][0]['style'])
            for primaryRune in range(len(df[summoner]['perks']['styles'][0]['selections'])):
                lst.append(df[summoner]['perks']['styles'][0]['selections'][primaryRune]['perk'])
            lst.append(df[summoner]['perks']['styles'][1]['style'])
            for subStyleRune in range(len(df[summoner]['perks']['styles'][1]['selections'])):
                lst.append(df[summoner]['perks']['styles'][0]['selections'][subStyleRune]['perk'])
            lst.append(df[summoner]['win'])
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
    rune_count.columns = ['champion_id', 'rune_combination', 'win_count', 'pick_count']
    rune_count = rune_count.rename(columns={'WIN/sum': 'win_count', 'WIN/size': 'pick_count'})

    top_runes = pd.concat(
        [rune_count.loc[rune_count['champion_id'] == cid].sort_values(by='pick_count', ascending=False)[:2] for cid in
         rune_count['champion_id'].unique()])
    top_runes['win_rate'] = round((top_runes['win_count'] / top_runes['pick_count']) * 100, 2)

    top_runes[['FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID', 'MAIN_SUB2_ID',
               'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID']] \
        = top_runes['rune_combination'].apply(pd.Series)
    top_runes = top_runes.drop('rune_combination', axis=1)
    new_column_order = ['champion_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID',
                        'MAIN_SUB1_ID', 'MAIN_SUB2_ID', 'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID',
                        'SUB_SUB1_ID', 'SUB_SUB2_ID', 'win_count', 'pick_count', 'win_rate']
    top_runes = top_runes.reindex(columns=new_column_order)

    total_game_df = rune_df.groupby(['champion_id']).agg({'WIN': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df.reset_index(inplace=True)
    merged_df = pd.merge(top_runes, total_game_df, on='champion_id')
    merged_df['pick_rate'] = round((merged_df['pick_count'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("룬데이터 정제완료")
    return final_df


rune_data = rune_data(df)


# ----------------------------------------------------------------------------------------------------------------------
# 아이템 데이터 정제
def item_df(raw_data):
    result = []
    print("아이템 데이터 정제 시작 ")
    for i in tqdm(range(len(raw_data))):
        df = raw_data.iloc[i]['matches']['info']['participants']
        for summoner in range(len(df)):
            lst = []
            lst.append(df[summoner]['championId'])
            try:
                lst.append(df[summoner]['challenges']['mythicItemUsed'])
            except:
                lst.append(0)
            lst.append(df[summoner]['item0'])
            lst.append(df[summoner]['item1'])
            lst.append(df[summoner]['item2'])
            lst.append(df[summoner]['item3'])
            lst.append(df[summoner]['item4'])
            lst.append(df[summoner]['item5'])
            lst.append(df[summoner]['item6'])
            lst.append(df[summoner]['win'])
            result.append(lst)
    columns = ['champion_id', 'mythic_item', 'item0', 'item1', 'item2', 'item3', 'item4', 'item5', 'item6', 'win']
    item_df = pd.DataFrame(result, columns=columns)
    item_df['win'] = item_df['win'].astype(int)
    print("아이템 데이터 정제 완료 ")
    return item_df


item_df = item_df(df)


# ----------------------------------------------------------------------------------------------------------------------
# 챔피언 신발 데이터
def shoes_data(item_df_data):
    shoe_items = [3111, 3117, 3009, 3047, 3006, 3158, 3020]
    champion_shoe_counts = {}
    champion_win_counts = {}
    print("신발 데이터 정제 시작 ")

    for row in tqdm(item_df_data.itertuples()):
        champion_id = row.champion_id
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

    columns = ['champion_id', 'item_id', 'pick_count', 'win_count']
    shoe_items_df = pd.DataFrame(result, columns=columns)
    shoe_items_df.reset_index(drop=True, inplace=True)

    shoe_items_df['win_rate'] = round((shoe_items_df['win_count'] / shoe_items_df['pick_count']) * 100, 2)

    def rank_items(group):
        group['rank'] = group['pick_count'].rank(ascending=False, method='first')
        group.loc[group['rank'] == 2, 'rank'] = group[group['rank'] == 2]['win_rate'].rank(ascending=False,
                                                                                          method='first') + 1
        return group

    shoe_items_df = shoe_items_df.groupby('champion_id', group_keys=True).apply(rank_items)

    top_2_shoes_per_champion = shoe_items_df[shoe_items_df['rank'].isin([1, 2])]

    # 챔피언별 승리 횟수 카운트
    champion_wins_df = item_df_data.groupby('champion_id', as_index=False)['win'].count()

    # 기존 데이터 프레임에 champion_wins_df를 champion_id 기준으로 병합
    merged_df = top_2_shoes_per_champion.set_index('champion_id').reset_index().merge(champion_wins_df,
                                                                                      on='champion_id', how='left')

    merged_df['pick_rate'] = round((merged_df['pick_count'] / merged_df['win'])*100, 2)
    final_df = merged_df[['champion_id', 'item_id', 'pick_count', 'win_count', 'win_rate', 'pick_rate']]
    print("신발 데이터 정제 완료 ")
    return final_df


shoes_data = shoes_data(item_df)


# ----------------------------------------------------------------------------------------------------------------------
# 신화 아이템 정제
def mythic_item_data(raw_data):
    result = []
    print("신화 아이템 데이터 정제 시작")
    for i in tqdm(range(len(raw_data))):
        df = raw_data.iloc[i]['matches']['info']['participants']
        for summoner in range(len(df)):
            champion_id = df[summoner]['championId']
            mythic_item_used = df[summoner]['challenges']['mythicItemUsed'] if 'mythicItemUsed' in \
                                                                                     df[summoner][
                                                                                         'challenges'] else 0
            win = df[summoner]['win']
            result.append([champion_id, mythic_item_used, win])

    mythic_item_df = pd.DataFrame(result, columns=['champion_id', 'mythic_item', 'win'])
    mythic_item_df['mythic_item'] = mythic_item_df['mythic_item'].astype(int)
    mythic_item_df['win'] = mythic_item_df['win'].astype(int)

    mythic_item_df = mythic_item_df[mythic_item_df['mythic_item'] != 0]

    top_items = []
    for champion_id, group in mythic_item_df.groupby('champion_id'):
        top_items_df = group.groupby('mythic_item').agg({'mythic_item': 'count', 'win': 'sum'})
        top_items_df.columns = ['pick_count', 'win_count']
        top_items_df['win_rate'] = round((top_items_df['win_count'] / top_items_df['pick_count']) * 100, 2)
        top_items_df = top_items_df.sort_values(['pick_count', 'win_rate'], ascending=[False, False])
        top_items_df = top_items_df.iloc[:3].reset_index()
        top_items_df['champion_id'] = champion_id
        top_items.append(top_items_df)

    top_items_df = pd.concat(top_items)
    top_items_df['rank'] = top_items_df.groupby('champion_id')['pick_count'].rank(ascending=False, method='first')
    top_items_df['rank'] = top_items_df['rank'].astype(int)

    total_game_df = mythic_item_df.groupby(['champion_id']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df.reset_index(inplace=True)
    merged_df = pd.merge(top_items_df, total_game_df, on='champion_id')
    merged_df['pick_rate'] = round((merged_df['pick_count'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("신화 아이템 데이터 정제 완료 ")
    return final_df[['champion_id', 'mythic_item', 'pick_count', 'win_count', 'win_rate','pick_rate']]


mysitic_item_data = mythic_item_data(df)


# ----------------------------------------------------------------------------------------------------------------------
# 아이템 정제 (신화, 신발 제외)
def common_item_data(item_df_data):
    print("일반 아이템 데이터 정제 시작 ")
    item_columns = ['item0', 'item1', 'item2', 'item3', 'item4', 'item5']
    melted_df = item_df_data.melt(id_vars=['champion_id', 'win'], value_vars=item_columns, var_name='item_col',
                                  value_name='item_id')

    non_zero_items = melted_df[melted_df['item_id'] != 0]
    item_frequency = non_zero_items.groupby(['champion_id', 'item_id']).size().reset_index(name='pick_count')

    non_zero_items_wins = non_zero_items[non_zero_items['win'] == 1]
    item_wins = non_zero_items_wins.groupby(['champion_id', 'item_id']).size().reset_index(name='win')

    item_frequency = item_frequency.merge(item_wins, on=['champion_id', 'item_id'], how='left')
    item_frequency['win'].fillna(0, inplace=True)

    def top_n_items(df, excluded_items, n=3):
        df_filtered = df[~df['item_id'].isin(excluded_items)]
        return df_filtered.nlargest(n, 'pick_count')

    mysitic_item_lst = mysitic_item_data['mythic_item'].unique()
    shoes_lst = [3111, 3117, 3009, 3047, 3006, 3158, 3020]
    excluded_items = list(mysitic_item_lst) + shoes_lst

    top_items_df = item_frequency.groupby('champion_id', group_keys=False).apply(
        lambda x: top_n_items(x, excluded_items))
    top_items_df['win'] = top_items_df['win'].astype(int)
    top_items_df['win_rate'] = round((top_items_df['win'] / top_items_df['pick_count']) * 100, 2)

    total_game_df = item_df_data.groupby(['champion_id']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df.reset_index(inplace=True)
    merged_df = pd.merge(top_items_df, total_game_df, on='champion_id')
    merged_df['pick_rate'] = round((merged_df['pick_count'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("일반 아이템 데이터 정제 완료 ")
    return final_df

common_item_data = common_item_data(item_df)


# ----------------------------------------------------------------------------------------------------------------------
# 시작 아이템 데이터 정제
def start_item_data(raw_data):
    result = []
    accessories_lst = [3364, 3340, 3363, 3330, 3513]
    print("시작 아이템 데이터 정제 시작 ")
    for x in tqdm(range(len(raw_data))):
        timeline_df = raw_data.iloc[x]['timeline']['info']['frames']
        if len(timeline_df) < 2:
            continue
        item_dict_by_participant = {i: [] for i in range(1, len(raw_data.iloc[x]['matches']['info']['participants']) + 1)}
        for event in timeline_df[1]['events']:
            if event['type'] == 'ITEM_PURCHASED':
                item_dict_by_participant[event['participantId']].append(event['itemId'])

        row_result = []
        for i in range(len(raw_data.iloc[x]['matches']['info']['participants'])):
            champion_id = raw_data.iloc[x]['matches']['info']['participants'][i]['championId']
            win = raw_data.iloc[x]['matches']['info']['participants'][i]['win']
            items = [item for item in item_dict_by_participant[i + 1] if item not in accessories_lst]
            items_str = ",".join(map(str, items))
            row_result.append([champion_id, items_str, win])

        result.extend(row_result)

    columns = ['champion_id', 'item_id', 'win']
    start_item_df = pd.DataFrame(result, columns=columns)
    start_item_df['win'] = start_item_df['win'].astype(int)

    start_item_counts = start_item_df.groupby(['champion_id', 'item_id']).agg({'win': ['count', 'sum']})
    start_item_counts.columns = ['pick_count', 'win_count']
    start_item_counts = start_item_counts.reset_index()

    start_item_counts['win_rate'] = round((start_item_counts['win_count'] / start_item_counts['pick_count']) * 100, 2)

    start_item_counts = start_item_counts[
        (start_item_counts['win_count'] >= 5) & (start_item_counts['pick_count'] >= 5)]

    top3_start_item = start_item_counts.groupby('champion_id').apply(lambda x: x.nlargest(3, ['pick_count', 'win_rate']))
    top3_start_item = top3_start_item.reset_index(drop=True)

    total_game_df = start_item_df.groupby(['champion_id']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df = total_game_df.reset_index()
    merged_df = pd.merge(top3_start_item, total_game_df, on='champion_id')
    merged_df['pick_rate'] = round((merged_df['pick_count'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("시작 아이템 데이터 정제 완료 ")
    return final_df


start_item = start_item_data(df)


# ----------------------------------------------------------------------------------------------------------------------
# 장신구 아이템 정제
def accessories_data(raw_data):
    result = []
    accessories_lst = [3364, 3340, 3363, 3330, 3513]
    print("장신구 아이템 데이터 정제 시작 ")
    for x in tqdm(range(len(raw_data))):
        timeline_df = raw_data.iloc[x]['timeline']['info']['frames']
        if len(timeline_df) < 2:
            continue
        item_dict_by_participant = {i: [] for i in range(1, len(raw_data.iloc[x]['matches']['info']['participants']) + 1)}
        for event in timeline_df[1]['events']:
            if event['type'] == 'ITEM_PURCHASED' and event['itemId'] in accessories_lst:
                item_dict_by_participant[event['participantId']].append(event)

        row_result = []
        for i in range(len(raw_data.iloc[x]['matches']['info']['participants'])):
            champion_id = raw_data.iloc[x]['matches']['info']['participants'][i]['championId']
            acc_last = raw_data.iloc[x]['matches']['info']['participants'][i]['item6']

            win = raw_data.iloc[x]['matches']['info']['participants'][i]['win']
            items = [item['itemId'] for item in item_dict_by_participant[i + 1]]
            items.append(acc_last)
            items_str = ",".join(map(str, items))
            row_result.append([champion_id, items_str, win])

        result.extend(row_result)

    columns = ['champion_id', 'item_id', 'win']
    start_item_df = pd.DataFrame(result, columns=columns)
    start_item_df['win'] = start_item_df['win'].astype(int)

    start_item_counts = start_item_df.groupby(['champion_id', 'item_id']).agg({'win': ['count', 'sum']})
    start_item_counts.columns = ['pick_count', 'win_count']
    start_item_counts = start_item_counts.reset_index()

    start_item_counts['win_rate'] = round((start_item_counts['win_count'] / start_item_counts['pick_count']) * 100, 2)

    start_item_counts = start_item_counts[
        (start_item_counts['win_count'] >= 5) & (start_item_counts['pick_count'] >= 5)]

    top3_start_item = start_item_counts.groupby('champion_id').apply(lambda x: x.nlargest(3, ['pick_count', 'win_rate']))
    top3_start_item = top3_start_item.reset_index(drop=True)

    total_game_df = start_item_df.groupby(['champion_id']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df = total_game_df.reset_index()
    merged_df = pd.merge(top3_start_item, total_game_df, on='champion_id')
    merged_df['pick_rate'] = round((merged_df['pick_count'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("장신구 아이템 데이터 정제 완료 ")
    return final_df

accessories_data = accessories_data(df)
# ----------------------------------------------------------------------------------------------------------------------
# 스펠 데이터
def spell_data(raw_data):
    result = []
    print("스펠 데이터 정제 시작 ")
    for i in tqdm(range(len(raw_data))):
        df = raw_data.iloc[i]['matches']['info']['participants']
        for summoner in range(len(df)):
            lst = []
            lst.append(df[summoner]['championId'])
            lst.append(df[summoner]['summoner1Id'])
            lst.append(df[summoner]['summoner2Id'])
            lst.append(df[summoner]['win'])
            result.append(lst)
    columns = ['champion_id', 'spell_1', 'spell_2', 'win']

    spell_df = pd.DataFrame(result, columns=columns)
    spell_df['win'] = spell_df['win'].astype(int)
    def combine_spells(df):
        df['spell_1'], df['spell_2'] = np.sort(df[['spell_1', 'spell_2']], axis=1).T
        df['spells'] = df['spell_1'].astype(str) + ',' + df['spell_2'].astype(str)
        return df.groupby(['champion_id', 'spells'])['win'].agg(['count', 'sum']).reset_index()

    top3_spells = (
        combine_spells(spell_df)
        .sort_values(['champion_id', 'sum', 'count'], ascending=[True, False, False])
        .groupby('champion_id')
        .head(2)
        .rename(columns={'count': 'pick_count', 'sum': 'win_count'})
    )

    top3_spells['win_rate'] = round((top3_spells['win_count'] / top3_spells['pick_count']) * 100, 2)
    total_game_df = spell_df.groupby(['champion_id']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df.reset_index(inplace=True)
    merged_df = pd.merge(top3_spells, total_game_df, on='champion_id')
    merged_df['pick_rate'] = round((merged_df['pick_count'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("스펠 데이터 정제 완료 ")
    return final_df


spell_data = spell_data(df)
# ----------------------------------------------------------------------------------------------------------------------


df.iloc[0]['timeline']['info']['frames'][3]['events'][1]['level']
df.iloc[0]['matches']['info']['participants'][0]['championId']
df.iloc[0]['matches']['info']['participants'][0]['participantId']

def skill_build_data(raw_data):
    for x in tqdm(range(len(raw_data))):
        for minute in range(len(raw_data.iloc[x]['timeline']['info']['frames'])):
            events = raw_data.iloc[x]['timeline']['info']['frames'][minute]['events']
            participants = raw_data.iloc[x]['matches']['info']['participants']

            # Create a dictionary to map participantId to championId
            participant_to_champion = {participant['participantId']: participant['championId'] for participant in
                                       participants}

            for event in events:
                if event['type'] == 'SKILL_LEVEL_UP':
                    participant_id = event['participantId']
                    skill_slot = event['skillSlot']
                    champion_id = participant_to_champion[participant_id]
                if event['type'] == 'LEVEL_UP':
                    level = event['level']
                    print(level)
                    #
                    # print(
                    #     f"Champion ID: {champion_id} Level: {level} Skill Slot: {skill_slot}")


skill_build_data(df[:1])
