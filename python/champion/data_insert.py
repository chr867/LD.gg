# --------------------------------------------------------
# Package
import pandas as pd
import requests
from tqdm import tqdm
import my_utils as mu
import json
import time
import numpy as np
import data_load as dl
import champion_stats
tqdm.pandas()
dir(champion_stats)
# RIOT-API-KEY
riot_api_key = 'RGAPI-73a75ebb-9e24-4870-89ae-a96274d14522'
# ----------------------------------------------------------------------------------------------------------------------
start_time = time.time()
df = dl.match_raw_patch(100)
print("JSON 변환 시작")
df['matches'] = df['matches'].apply(json.loads)
df['timeline'] = df['timeline'].apply(json.loads)
end_time = time.time()
print("변환 시간: {:.2f}초".format(end_time - start_time))
print("JSON 변환 종료")
# ----------------------------------------------------------------------------------------------------------------------
def get_match_timeline(matchid):
    url = f"https://asia.api.riotgames.com/lol/match/v5/matches/{matchid}?api_key={riot_api_key}"
    res1 = requests.get(url).json()
    url2 = f"https://asia.api.riotgames.com/lol/match/v5/matches/{matchid}/timeline?api_key={riot_api_key}"
    res2 = requests.get(url2).json()
    return res1, res2
lst = []
matches, timeline = get_match_timeline('KR_6488614800')
lst.append(['KR_6487107017', matches, timeline])
df = pd.DataFrame(lst, columns=['match_id', 'matches', 'timeline'])
# ----------------------------------------------------------------------------------------------------------------------
rune_data = champ.rune_data(df)
item_df = champ.item_df(df)
shoes_data = champ.shoes_data(item_df)
mythic_item_data = champ.mythic_item_data(df)
common_item_data = champ.common_item_data(df)
start_item = champ.start_item_data(df)
accessories_data = champ.accessories_data(df)
spell_data = champ.spell_data(df)
skill_build_data = champ.skill_build_data(df)
item_build_data = champ.item_build_data(df)
lane_data = champ.lane_data(df)
# ----------------------------------------------------------------------------------------------------------------------
def insert_rune_data(x,conn):
    query = (
        f'insert into champion_match_up (championId, teamPosition, FRAGMENT1_ID, FRAGMENT2_ID, '
        f'FRAGMENT3_ID, MAIN_KEYSTONE_ID, MAIN_SUB1_ID, MAIN_SUB2_ID, MAIN_SUB3_ID, '
        f'MAIN_SUB4_ID, SUB_KEYSTONE_ID, SUB_SUB1_ID, SUB_SUB2_ID, winCount, pickCount,winRate,pickRate)'
        f'values({x.championId},{repr(x.teamPosition)},{x.FRAGMENT1_ID},{x.FRAGMENT2_ID},'
        f'{x.FRAGMENT3_ID},{x.MAIN_KEYSTONE_ID},{x.MAIN_SUB1_ID},{x.MAIN_SUB2_ID},{x.MAIN_SUB3_ID},{x.MAIN_SUB4_ID},'
        f'{x.SUB_KEYSTONE_ID},{x.SUB_SUB1_ID},{x.SUB_SUB2_ID},{x.winCount},{x.pickCount},{x.winRate},{x.pickRate})'
    )
    try:
        mu.mysql_execute(query,conn)
    except Exception as e:
        print(e)
    return
def insert_shoes_data(x,conn):
    query = (
        f'insert into champion_match_up (championId, teamPosition, itemId, pickCount, '
        f'winCount, winRate, pickRate'
        f'values({x.championId},{repr(x.teamPosition)},{x.itemId},{x.pickCount},'
        f'{x.winCount},{x.winRate},{x.pickRate}'
    )
    try:
        mu.mysql_execute(query,conn)
    except Exception as e:
        print(e)
    return
def insert_mythic_item_data(x,conn):
    query = (
        f'insert into champion_match_up (championId, teamPosition, mythicItem, pickCount, '
        f'winCount, winRate, pickRate'
        f'values({x.championId},{repr(x.teamPosition)},{x.mythicItem},{x.pickCount},'
        f'{x.winCount},{x.winRate},{x.pickRate}'
    )
    try:
        mu.mysql_execute(query,conn)
    except Exception as e:
        print(e)
    return
def insert_common_item_data(x,conn):
    query = (
        f'insert into champion_match_up (championId, teamPosition, itemId, pickCount, '
        f'winCount, winRate, pickRate'
        f'values({x.championId},{repr(x.teamPosition)},{x.itemId},{x.pickCount},'
        f'{x.winCount},{x.winRate},{x.pickRate}'
    )
    try:
        mu.mysql_execute(query,conn)
    except Exception as e:
        print(e)
    return

def insert_start_item_data(x,conn):
    query = (
        f'insert into champion_match_up (championId, teamPosition, itemId, pickCount, '
        f'winCount, winRate, pickRate'
        f'values({x.championId},{repr(x.teamPosition)},{repr(x.itemId)},{x.pickCount},'
        f'{x.winCount},{x.winRate},{x.pickRate}'
    )
    try:
        mu.mysql_execute(query,conn)
    except Exception as e:
        print(e)
    return
def insert_accessories_data(x,conn):
    query = (
        f'insert into champion_match_up (championId, teamPosition, itemId, pickCount, '
        f'winCount, winRate, pickRate'
        f'values({x.championId},{repr(x.teamPosition)},{repr(x.itemId)},{x.pickCount},'
        f'{x.winCount},{x.winRate},{x.pickRate}'
    )
    try:
        mu.mysql_execute(query,conn)
    except Exception as e:
        print(e)
    return

def insert_spell_data(x,conn):
    query = (
        f'insert into champion_match_up (championId, teamPosition, spells, pickCount, '
        f'winCount, winRate, pickRate'
        f'values({x.championId},{repr(x.teamPosition)},{repr(x.spells)},{x.pickCount},'
        f'{x.winCount},{x.winRate},{x.pickRate}'
    )
    try:
        mu.mysql_execute(query,conn)
    except Exception as e:
        print(e)
    return