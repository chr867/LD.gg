# --------------------------------------------------------
# Package
import pandas as pd
from tqdm import tqdm
import my_utils as mu
import json
import time
import numpy as np

tqdm.pandas()
import data_load as dl

# RIOT-API-KEY
riot_api_key = 'RGAPI-14667a4e-7c3c-45fa-ac8f-e53c7c3f5fe1'
# ----------------------------------------------------------------------------------------------------------------------
test_df = dl.matches_timeline_data_select(5000)
asd = dl.matches_timeline_data(10)

start_time = time.time()
df = dl.matches_timeline_data(30000)
print("JSON 변환 시작")
df['matches'] = df['matches'].apply(json.loads)
df['timeline'] = df['timeline'].apply(json.loads)
end_time = time.time()
print("변환 시간: {:.2f}초".format(end_time - start_time))
print("JSON 변환 종료")


# ----------------------------------------------------------------------------------------------------------------------
# 룬 데이터 정제
def rune_data(raw_data):
    result = []
    print("룬데이터 추출 시작")
    for i in tqdm(range(len(raw_data))):
        df = raw_data.iloc[i]['matches']['participants']
        for summoner in range(len(df)):
            lst = []
            lst.append(df[summoner]['championId'])
            lst.append(df[summoner]['teamPosition'])  # teamPosition 추가
            lst.append(df[summoner]['defense'])
            lst.append(df[summoner]['flex'])
            lst.append(df[summoner]['offense'])
            lst.append(df[summoner]['style0'])
            for primaryRune in df[summoner]['perks0']:
                lst.append(primaryRune)
            lst.append(df[summoner]['style1'])
            for subStyleRune in df[summoner]['perks1']:
                lst.append(subStyleRune)
            lst.append(df[summoner]['win'])
            result.append(lst)
    print("룬데이터 추출완료")
    print("룬데이터 데이터프레임 제작 시작")
    columns = ['championId', 'teamPosition', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID',
               'MAIN_SUB2_ID', 'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID', 'WIN']

    rune_df = pd.DataFrame(result, columns=columns)
    rune_df['WIN'] = rune_df['WIN'].astype(int)
    print("룬데이터 데이터프레임 제작완료")
    print("룬데이터 정제 시작")
    new_df = rune_df[['championId', 'teamPosition', 'WIN']].join(rune_df.iloc[:, 2:13].apply(tuple, axis=1).rename('rune_combination'))

    rune_count = new_df.groupby(['championId', 'teamPosition', 'rune_combination']).agg({'WIN': ['sum', 'size']}).reset_index()
    rune_count.columns = ['championId', 'teamPosition', 'rune_combination', 'winCount', 'pickCount']
    rune_count = rune_count.rename(columns={'WIN/sum': 'winCount', 'WIN/size': 'pickCount'})

    top_runes = pd.concat(
        [rune_count.loc[(rune_count['championId'] == cid) & (rune_count['teamPosition'] == pos)].sort_values(by='pickCount', ascending=False)[:5] for cid in
         rune_count['championId'].unique() for pos in rune_count['teamPosition'].unique()])
    top_runes = top_runes[top_runes['pickCount'] > 10]
    top_runes['winRate'] = round((top_runes['winCount'] / top_runes['pickCount']) * 100, 2)

    top_runes[['FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID', 'MAIN_SUB2_ID',
               'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID']] \
        = top_runes['rune_combination'].apply(pd.Series)
    top_runes = top_runes.drop('rune_combination', axis=1)
    new_column_order = ['championId', 'teamPosition', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID',
                        'MAIN_KEYSTONE_ID',
                        'MAIN_SUB1_ID', 'MAIN_SUB2_ID', 'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID',
                        'SUB_SUB1_ID', 'SUB_SUB2_ID', 'winCount', 'pickCount', 'winRate']
    top_runes = top_runes.reindex(columns=new_column_order)

    total_game_df = rune_df.groupby(['championId', 'teamPosition']).agg({'WIN': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df.reset_index(inplace=True)
    merged_df = pd.merge(top_runes, total_game_df, on=['championId', 'teamPosition'])
    merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['total_game']) * 100, 2)
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
        df = raw_data.iloc[i]['matches']['participants']
        for summoner in range(len(df)):
            lst = []
            lst.append(df[summoner]['championId'])
            lst.append(df[summoner]['teamPosition'])
            try:
                lst.append(df[summoner]['mythicItemUsed'])
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
    columns = ['championId',  'teamPosition', 'mythicItem','item0', 'item1', 'item2', 'item3', 'item4', 'item5', 'item6', 'win']
    item_df = pd.DataFrame(result, columns=columns)
    item_df['win'] = item_df['win'].astype(int)
    print("아이템 데이터 정제 완료 ")
    return item_df


item_df = item_df(df)


# ----------------------------------------------------------------------------------------------------------------------
# 챔피언 신발 데이터
def shoes_data(item_df_data):
    shoe_items = [3111, 3117, 3009, 3047, 3006, 3158, 3020]
    champion_position_shoe_counts = {}
    champion_position_winCounts = {}
    print("신발 데이터 정제 시작 ")

    for row in tqdm(item_df_data.itertuples()):
        championId = row.championId
        teamPosition = row.teamPosition
        if (championId, teamPosition) not in champion_position_shoe_counts:
            champion_position_shoe_counts[(championId, teamPosition)] = {item: 0 for item in shoe_items}
            champion_position_winCounts[(championId, teamPosition)] = {item: 0 for item in shoe_items}

        for item in shoe_items:
            if item in row[4:11]:
                champion_position_shoe_counts[(championId, teamPosition)][item] += 1
                if row.win:
                    champion_position_winCounts[(championId, teamPosition)][item] += 1

    result = []
    for (championId, teamPosition), shoe_counts in tqdm(champion_position_shoe_counts.items()):
        for itemId, count in shoe_counts.items():
            winCount = champion_position_winCounts[(championId, teamPosition)][itemId]
            result.append([championId, teamPosition, itemId, count, winCount])

    columns = ['championId', 'teamPosition', 'itemId', 'pickCount', 'winCount']
    shoe_items_df = pd.DataFrame(result, columns=columns)
    shoe_items_df.reset_index(drop=True, inplace=True)

    shoe_items_df['winRate'] = round((shoe_items_df['winCount'] / shoe_items_df['pickCount']) * 100, 2)

    def rank_items(group):
        group['rank'] = group['pickCount'].rank(ascending=False, method='first')
        return group

    shoe_items_df = shoe_items_df.groupby(['championId', 'teamPosition'], group_keys=True).apply(rank_items)

    top_7_shoes_per_champion_position = shoe_items_df[shoe_items_df['rank'].le(7)]
    top_7_shoes_per_champion_position.reset_index(drop=True, inplace=True)

    # 챔피언별 승리 횟수 카운트
    champion_position_wins_df = item_df_data.groupby(['championId', 'teamPosition'], as_index=False)['win'].count()

    # 기존 데이터 프레임에 champion_position_wins_df를 championId와 teamPosition 기준으로 병합
    merged_df = top_7_shoes_per_champion_position.merge(champion_position_wins_df, on=['championId', 'teamPosition'], how='left')

    merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['win']) * 100, 2)
    final_df = merged_df[['championId', 'teamPosition', 'itemId', 'pickCount', 'winCount', 'winRate', 'pickRate']]
    final_df.fillna(0)  # 카시오페아 문제 해결해야함
    final_df = final_df[final_df['pickCount'] > 10]
    print("신발 데이터 정제 완료 ")
    return final_df


shoes_data = shoes_data(item_df)



# ----------------------------------------------------------------------------------------------------------------------
# 신화 아이템 정제
def mythic_item_data(raw_data):
    result = []
    print("신화 아이템 데이터 정제 시작")
    for i in tqdm(range(len(raw_data))):
        df = raw_data.iloc[i]['matches']['participants']
        for summoner in range(len(df)):
            championId = df[summoner]['championId']
            teamPosition = df[summoner]['teamPosition']  # 팀 포지션 추가
            mythic_item_used = df[summoner].get('mythicItemUsed', 0)
            win = df[summoner]['win']
            result.append([championId, teamPosition, mythic_item_used, win])

    mythic_item_df = pd.DataFrame(result, columns=['championId', 'teamPosition', 'mythicItem', 'win'])
    mythic_item_df['mythicItem'] = mythic_item_df['mythicItem'].astype(int)
    mythic_item_df['win'] = mythic_item_df['win'].astype(int)

    mythic_item_df = mythic_item_df[mythic_item_df['mythicItem'] != 0]

    top_items = []
    for (championId, teamPosition), group in mythic_item_df.groupby(['championId', 'teamPosition']):
        top_items_df = group.groupby('mythicItem').agg({'mythicItem': 'count', 'win': 'sum'})
        top_items_df.columns = ['pickCount', 'winCount']
        top_items_df['winRate'] = round((top_items_df['winCount'] / top_items_df['pickCount']) * 100, 2)
        top_items_df = top_items_df[top_items_df['pickCount'] > 10]  # pickCount가 10 이하인 행 제거
        top_items_df = top_items_df.sort_values(['pickCount', 'winRate'], ascending=[False, False])
        top_items_df = top_items_df.iloc[:5].reset_index()
        top_items_df['championId'] = championId
        top_items_df['teamPosition'] = teamPosition
        top_items.append(top_items_df)

    top_items_df = pd.concat(top_items)
    top_items_df['rank'] = top_items_df.groupby(['championId', 'teamPosition'])['pickCount'].rank(ascending=False, method='first')
    top_items_df['rank'] = top_items_df['rank'].astype(int)

    total_game_df = mythic_item_df.groupby(['championId', 'teamPosition']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df.reset_index(inplace=True)
    merged_df = pd.merge(top_items_df, total_game_df, on=['championId', 'teamPosition'])
    merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("신화 아이템 데이터 정제 완료 ")
    return final_df[['championId', 'teamPosition', 'mythicItem', 'pickCount', 'winCount', 'winRate', 'pickRate']]


mythic_item_data = mythic_item_data(df)



# ----------------------------------------------------------------------------------------------------------------------
# 아이템 정제 (신화, 신발 제외)
def common_item_data(raw_data):
    print("일반 아이템 데이터 정제 시작 ")
    result = []
    for i in tqdm(range(len(raw_data))):
        df = raw_data.iloc[i]['matches']['participants']
        for summoner in range(len(df)):
            championId = df[summoner]['championId']
            teamPosition = df[summoner]['teamPosition']  # 팀 포지션 추가
            items = [df[summoner].get('item' + str(i), 0) for i in range(6)]
            win = df[summoner]['win']
            for item in items:
                result.append([championId, teamPosition, item, win])

    item_df = pd.DataFrame(result, columns=['championId', 'teamPosition', 'itemId', 'win'])
    item_df = item_df[item_df['itemId'] != 0]

    top_items = []
    for (championId, teamPosition), group in item_df.groupby(['championId', 'teamPosition']):
        top_items_df = group.groupby('itemId').agg({'itemId': 'count', 'win': 'sum'})
        top_items_df.columns = ['pickCount', 'winCount']
        top_items_df['winRate'] = round((top_items_df['winCount'] / top_items_df['pickCount']) * 100, 2)
        top_items_df = top_items_df[top_items_df['pickCount'] > 10]  # pickCount가 10 이하인 행 제거
        top_items_df = top_items_df.sort_values(['pickCount', 'winRate'], ascending=[False, False])
        top_items_df = top_items_df.iloc[:5].reset_index()
        top_items_df['championId'] = championId
        top_items_df['teamPosition'] = teamPosition
        top_items.append(top_items_df)

    top_items_df = pd.concat(top_items)
    top_items_df['rank'] = top_items_df.groupby(['championId', 'teamPosition'])['pickCount'].rank(ascending=False, method='first')
    top_items_df['rank'] = top_items_df['rank'].astype(int)

    total_game_df = item_df.groupby(['championId', 'teamPosition']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df.reset_index(inplace=True)
    merged_df = pd.merge(top_items_df, total_game_df, on=['championId', 'teamPosition'])
    merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("일반 아이템 데이터 정제 완료 ")
    return final_df[['championId', 'teamPosition', 'itemId', 'pickCount', 'winCount', 'winRate', 'pickRate']]


common_item_data = common_item_data(df)



# ----------------------------------------------------------------------------------------------------------------------
# 시작 아이템 데이터 정제
def start_item_data(raw_data):
    result = []
    accessories_lst = [3364, 3340, 3363, 3330, 3513]
    print("시작 아이템 데이터 정제 시작 ")
    for x in tqdm(range(len(raw_data))):
        timeline_df = raw_data.iloc[x]['timeline']
        if len(timeline_df) < 2:
            continue
        item_dict_by_participant = {i: [] for i in
                                    range(1, len(raw_data.iloc[x]['matches']['participants']) + 1)}
        for event in timeline_df['1']['events']:
            if event['type'] == 'ITEM_PURCHASED':
                item_dict_by_participant[event['participantId']].append(event['itemId'])
        for event in timeline_df['2']['events']:
            if event['type'] == 'ITEM_PURCHASED':
                item_dict_by_participant[event['participantId']].append(event['itemId'])
        row_result = []
        for i in range(len(raw_data.iloc[x]['matches']['participants'])):
            championId = raw_data.iloc[x]['matches']['participants'][i]['championId']
            teamPosition = raw_data.iloc[x]['matches']['participants'][i]['teamPosition']  # 팀 포지션 추가
            win = raw_data.iloc[x]['matches']['participants'][i]['win']
            items = [item for item in item_dict_by_participant[i + 1] if item not in accessories_lst]
            items_str = ",".join(map(str, items))
            row_result.append([championId, teamPosition, items_str, win])

        result.extend(row_result)

    columns = ['championId', 'teamPosition', 'itemId', 'win']
    start_item_df = pd.DataFrame(result, columns=columns)
    start_item_df['win'] = start_item_df['win'].astype(int)

    start_item_counts = start_item_df.groupby(['championId', 'teamPosition', 'itemId']).agg({'win': ['count', 'sum']})
    start_item_counts.columns = ['pickCount', 'winCount']
    start_item_counts = start_item_counts.reset_index()

    start_item_counts['winRate'] = round((start_item_counts['winCount'] / start_item_counts['pickCount']) * 100, 2)

    start_item_counts = start_item_counts[
        (start_item_counts['winCount'] >= 5) & (start_item_counts['pickCount'] >= 10)]  # pickCount가 10 이하인 행 제거

    top5_start_item = start_item_counts.groupby(['championId', 'teamPosition']).apply(
        lambda x: x.nlargest(5, ['pickCount', 'winRate']))
    top5_start_item = top5_start_item.reset_index(drop=True)

    total_game_df = start_item_df.groupby(['championId', 'teamPosition']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df = total_game_df.reset_index()
    merged_df = pd.merge(top5_start_item, total_game_df, on=['championId', 'teamPosition'])
    merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("시작 아이템 데이터 정제 완료 ")
    return final_df[['championId', 'teamPosition', 'itemId', 'pickCount', 'winCount', 'winRate', 'pickRate']]


start_item = start_item_data(df)


# ----------------------------------------------------------------------------------------------------------------------
# 장신구 아이템 정제
def accessories_data(raw_data):
    result = []
    accessories_lst = [3364, 3340, 3363, 3330, 3513]
    print("장신구 아이템 데이터 정제 시작 ")
    for x in tqdm(range(len(raw_data))):
        timeline_df = raw_data.iloc[x]['timeline']
        if len(timeline_df) < 2:
            continue
        item_dict_by_participant = {i: [] for i in
                                    range(1, len(raw_data.iloc[x]['matches']['participants']) + 1)}
        for event in timeline_df['1']['events']:
            if event['type'] == 'ITEM_PURCHASED' and event['itemId'] in accessories_lst:
                item_dict_by_participant[event['participantId']].append(event)

        row_result = []
        for i in range(len(raw_data.iloc[x]['matches']['participants'])):
            championId = raw_data.iloc[x]['matches']['participants'][i]['championId']
            teamPosition = raw_data.iloc[x]['matches']['participants'][i]['teamPosition']
            acc_last = raw_data.iloc[x]['matches']['participants'][i]['item6']

            win = raw_data.iloc[x]['matches']['participants'][i]['win']
            items = [item['itemId'] for item in item_dict_by_participant[i + 1]]
            items.append(acc_last)
            items_str = ",".join(map(str, items))
            row_result.append([championId, teamPosition, items_str, win])

        result.extend(row_result)

    columns = ['championId', 'teamPosition', 'itemId', 'win']
    accessories_df = pd.DataFrame(result, columns=columns)
    accessories_df['win'] = accessories_df['win'].astype(int)

    accessories_counts = accessories_df.groupby(['championId', 'teamPosition', 'itemId']).agg({'win': ['count', 'sum']})
    accessories_counts.columns = ['pickCount', 'winCount']
    accessories_counts = accessories_counts.reset_index()

    accessories_counts['winRate'] = round((accessories_counts['winCount'] / accessories_counts['pickCount']) * 100, 2)
    accessories_counts = accessories_counts[accessories_counts['pickCount'] > 10]

    top5_accessories = accessories_counts.groupby(['championId', 'teamPosition']).apply(
        lambda x: x.nlargest(5, ['pickCount', 'winRate']))
    top5_accessories = top5_accessories.reset_index(drop=True)

    total_game_df = accessories_df.groupby(['championId', 'teamPosition']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df = total_game_df.reset_index()
    merged_df = pd.merge(top5_accessories, total_game_df, on=['championId', 'teamPosition'])
    merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("장신구 아이템 데이터 정제 완료 ")
    return final_df[['championId', 'teamPosition', 'itemId', 'pickCount', 'winCount', 'winRate', 'pickRate']]


accessories_data = accessories_data(df)


# ----------------------------------------------------------------------------------------------------------------------
# 스펠 데이터
def spell_data(raw_data):
    result = []
    print("스펠 데이터 정제 시작 ")
    for i in tqdm(range(len(raw_data))):
        df = raw_data.iloc[i]['matches']['participants']
        for summoner in range(len(df)):
            lst = []
            lst.append(df[summoner]['championId'])
            lst.append(df[summoner]['teamPosition'])
            lst.append(df[summoner]['summoner1Id'])
            lst.append(df[summoner]['summoner2Id'])
            lst.append(df[summoner]['win'])
            result.append(lst)
    columns = ['championId', 'teamPosition', 'spell_1', 'spell_2', 'win']
    spell_df = pd.DataFrame(result, columns=columns)
    spell_df['win'] = spell_df['win'].astype(int)

    def combine_spells(df):
        df['spell_1'], df['spell_2'] = np.sort(df[['spell_1', 'spell_2']], axis=1).T
        df['spells'] = df['spell_1'].astype(str) + ',' + df['spell_2'].astype(str)
        return df.groupby(['championId', 'teamPosition', 'spells'])['win'].agg(['count', 'sum']).reset_index()

    top5_spells = (
        combine_spells(spell_df)
        .sort_values(['championId', 'teamPosition', 'sum', 'count'], ascending=[True, True, False, False])
        .groupby(['championId', 'teamPosition'])
        .head(5)
        .rename(columns={'count': 'pickCount', 'sum': 'winCount'})
    )

    top5_spells['winRate'] = round((top5_spells['winCount'] / top5_spells['pickCount']) * 100, 2)
    top5_spells = top5_spells[top5_spells['pickCount'] > 10]
    total_game_df = spell_df.groupby(['championId', 'teamPosition']).agg({'win': ['count']})
    total_game_df.columns = ['total_game']
    total_game_df.reset_index(inplace=True)
    merged_df = pd.merge(top5_spells, total_game_df, on=['championId', 'teamPosition'])
    merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['total_game']) * 100, 2)
    final_df = merged_df.drop(columns=['total_game'])
    print("스펠 데이터 정제 완료 ")
    return final_df[['championId', 'teamPosition', 'spells', 'pickCount', 'winCount', 'winRate', 'pickRate']]


spell_data = spell_data(df)


# ----------------------------------------------------------------------------------------------------------------------
# 스킬 빌드 추천
def skill_build_data(raw_data):
    result = []
    for x in tqdm(range(len(raw_data))):
        if len(raw_data.iloc[x]['timeline']) < 15:  # 15분이하 게임 컷뚜
            continue
        match = raw_data.iloc[x]['matches']
        participants = match['participants']
        timeline = raw_data.iloc[x]['timeline']

        skill_build_lst = [[player['championId'], player['teamPosition'], player['win']] for player in participants]

        for minute in timeline:
            events = timeline[minute]['events']
            for event in events:
                if event['type'] == 'SKILL_LEVEL_UP':# and event['skillSlot'] != 4 추가시 정확도는 높아지지만 표본수 대량으로 필요 약 100만개
                    participant_id = event['participantId']
                    skill_slot = event['skillSlot']
                    skill_build_lst[participant_id - 1].append(skill_slot)

        result.extend([[lst[0], lst[1], lst[2], ', '.join(map(str, lst[3:18]))] for lst in skill_build_lst if len(lst) > 18])

    df = pd.DataFrame(result, columns=['championId', 'teamPosition', 'win', 'skillBuild'])
    df['win'] = df['win'].astype(int)

    top_skill_builds = df.groupby(['championId', 'teamPosition', 'skillBuild']).size().reset_index(name='pickCount')
    top_skill_builds = top_skill_builds.sort_values(['championId', 'teamPosition', 'pickCount'], ascending=[True, True, False])
    top_5_skill_builds = top_skill_builds.groupby(['championId', 'teamPosition']).head(5)  # 추천 수 설정
    top_5_skill_builds = top_5_skill_builds[top_5_skill_builds['pickCount'] > 10]
    wins_with_skill_build = df[df['win'] == 1].groupby(['championId', 'teamPosition', 'skillBuild']).size().reset_index(name='winCount')
    top_5_skill_builds = pd.merge(top_5_skill_builds, wins_with_skill_build, on=['championId', 'teamPosition', 'skillBuild'], how='left')
    top_5_skill_builds['winCount'] = top_5_skill_builds['winCount'].fillna(0)

    total_games_per_champion = df.groupby(['championId', 'teamPosition']).size().reset_index(name='totalGames')
    top_5_skill_builds = pd.merge(top_5_skill_builds, total_games_per_champion, on=['championId', 'teamPosition'])

    top_5_skill_builds['pickRate'] = round((top_5_skill_builds['pickCount'] / top_5_skill_builds['totalGames']) * 100, 2)
    top_5_skill_builds['winRate'] = round((top_5_skill_builds['winCount'] / top_5_skill_builds['pickCount']) * 100, 2)
    top_5_skill_builds['winCount'] = top_5_skill_builds['winCount'].astype(int)


    def get_mastery_sequence(skill_build):
        skill_build_list = skill_build.split(', ')
        mastery_sequence = []
        skill_count = {str(i): 0 for i in range(1, 4)}

        for skill in skill_build_list:
            if skill in skill_count:
                skill_count[skill] += 1
                if skill not in mastery_sequence:
                    mastery_sequence.append(skill)

        return ', '.join(mastery_sequence)

    top_5_skill_builds['masterySequence'] = top_5_skill_builds['skillBuild'].apply(get_mastery_sequence)

    return top_5_skill_builds


skill_build_data = skill_build_data(df)


# ----------------------------------------------------------------------------------------------------------------------
# 아이템 빌드 추천
def item_build_data(raw_data):
    shoe_items = [3111, 3117, 3009, 3047, 3006, 3158, 3020]
    accessories_lst = [3364, 3340, 3363, 3330, 3513]
    result = []
    ex_data_count = 0
    for x in tqdm(range(len(raw_data))):
        if len(raw_data.iloc[x]['timeline']) < 30:
            continue
        participants = raw_data.iloc[x]['matches']['participants']
        item_end_lst = [[] for _ in range(len(participants))]

        for player in range(len(participants)):
            championId = participants[player]['championId']
            teamPosition = participants[player]['teamPosition']
            win = participants[player]['win']
            item0 = participants[player]['item0']
            item1 = participants[player]['item1']
            item2 = participants[player]['item2']
            item3 = participants[player]['item3']
            item4 = participants[player]['item4']
            item5 = participants[player]['item5']
            item_end_lst[player].extend([championId, teamPosition, win, item0, item1, item2, item3, item4, item5])

        item_build_lst = [[] for _ in range(len(participants))]

        timeline = raw_data.iloc[x]['timeline']
        for minute in timeline:
            events = timeline[minute]['events']
            for event in events:
                if event['type'] == 'ITEM_PURCHASED':
                    participant_id = event['participantId']
                    itemId = event['itemId']
                    item_build_lst[participant_id - 1].append(itemId)

        final_lst = []

        for end_champ, build_champ in zip(item_end_lst, item_build_lst):
            final_champ = [end_champ[0], end_champ[1], end_champ[2]]  # Include 'win' in the final list
            for item in end_champ[3:]:
                if item > 2055 and item not in shoe_items and item not in accessories_lst:
                    final_champ.append(item)
            final_lst.append(final_champ)

        modified_lst = []

        for sublist in final_lst:
            if len(sublist[3:]) > 2:
                modified_sublist = [sublist[0], sublist[1], sublist[2], ', '.join(map(str, sublist[3:6]))]
                modified_lst.append(modified_sublist)

        for lst in modified_lst:
            result.append(lst)
            ex_data_count += 1

    print(f'표본수 : {ex_data_count}개')
    columns = ['championId', 'teamPosition' ,'win', 'itemBuild']

    item_build_df = pd.DataFrame(result, columns=columns)
    item_build_df['win'] = item_build_df['win'].astype(int)

    top_item_builds = item_build_df.groupby(['championId', 'teamPosition', 'itemBuild']).size().reset_index(name='pickCount')
    top_item_builds = top_item_builds.sort_values(['championId', 'teamPosition', 'pickCount'], ascending=[True, True, False])
    top_5_item_builds = top_item_builds.groupby(['championId', 'teamPosition']).head(5)  # 추천 수 설정
    wins_with_skill_build = item_build_df[item_build_df['win'] == 1].groupby(['championId', 'teamPosition', 'itemBuild']).size().reset_index(name='winCount')
    top_5_item_builds = pd.merge(top_5_item_builds, wins_with_skill_build, on=['championId', 'teamPosition', 'itemBuild'], how='left')
    top_5_item_builds['winCount'] = top_5_item_builds['winCount'].fillna(0)

    total_games_per_champion = item_build_df.groupby(['championId', 'teamPosition']).size().reset_index(
        name='totalGames')
    top_5_item_builds = pd.merge(top_5_item_builds, total_games_per_champion, on=['championId', 'teamPosition'])

    top_5_item_builds['pickRate'] = round((top_5_item_builds['pickCount'] / top_5_item_builds['totalGames']) * 100, 2)
    top_5_item_builds['winRate'] = round((top_5_item_builds['winCount'] / top_5_item_builds['pickCount']) * 100, 2)
    top_5_item_builds['winCount'] = top_5_item_builds['winCount'].astype(int)

    return top_5_item_builds



item_build_data = item_build_data(df)
item_build_sort = item_build_data.sort_values(['pickRate'],ascending=False)

# ----------------------------------------------------------------------------------------------------------------------
# 밴률 데이터
def ban_rate_data(raw_data):
    result = []
    for x in tqdm(range(len(raw_data))):
        ban_lst = raw_data.iloc[x]['matches']['bans']
        for ban in ban_lst:
            if ban != 0 and ban != -1:
                result.append(ban)

    columns = ['championId']
    df = pd.DataFrame(result, columns=columns)
    ban_rate_df = df.groupby(['championId']).size().reset_index(name='banCount')

    ban_rate_df['banTotal'] = ban_rate_df['banCount'].sum()
    ban_rate_df['banRate'] = round((ban_rate_df['banCount'] / ban_rate_df['banTotal'])*100, 2)

    return ban_rate_df


ban_rate_df = ban_rate_data(df)
sort_ban_rate = ban_rate_df.sort_values(['banRate'], ascending = False)

# ----------------------------------------------------------------------------------------------------------------------
# 라인 데이터
def lane_data(df):
    result = []
    for x in tqdm(range(len(df))):
        summoner = df.iloc[x]['matches']['participants']
        for player in range(len(summoner)):
            championId = summoner[player]['championId']
            teamPosition = summoner[player]['teamPosition']
            win = summoner[player]['win']
            result.append([championId, teamPosition, win])

    columns = ['championId', 'teamPosition', 'win']
    df = pd.DataFrame(result, columns=columns)
    df['win'] = df['win'].astype(int)

    champion_pick_counts = df.groupby('championId').size().reset_index(name='championPickCount')
    lane_groupBy = df.groupby(['championId', 'teamPosition']).agg({'win': ['sum', 'size']}).reset_index()
    lane_groupBy.columns = ['championId', 'teamPosition', 'winCount', 'pickCount']
    lane_groupBy = lane_groupBy.merge(champion_pick_counts, on='championId')
    lane_groupBy['pickRate'] = round((lane_groupBy['pickCount'] / lane_groupBy['championPickCount']) * 100, 2)
    lane_groupBy['winRate'] = round((lane_groupBy['winCount'] / lane_groupBy['pickCount']) * 100, 2)
    lane_groupBy = lane_groupBy[lane_groupBy['pickRate'] > 5]
    lane_groupBy.dropna(inplace=True)
    lane_groupBy.reset_index(drop=True, inplace=True)
    result_df = lane_groupBy[['championId', 'teamPosition','pickCount','winCount','pickRate','winRate']]
    return result_df

lane_data = lane_data(df)

# ----------------------------------------------------------------------------------------------------------------------
df.iloc[0]['matches']['participants'][0]['teamPosition']





















