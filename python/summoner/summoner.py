import datetime
import random
import time
import numpy as np
import pandas as pd
import requests
from tqdm import tqdm
import my_utils as mu
import json
import multiprocessing as mp
import logging
import private
tqdm.pandas()

tiers = ['IRON', 'BRONZE', 'SILVER', 'GOLD', 'PLATINUM', 'DIAMOND']
divisions = ['IV', 'III', 'II', 'I']
api_keys = private.api_keys

api_it = iter(api_keys)
summoner_leagues = []
for tier in tqdm(tiers):
    for division in tqdm(divisions):
        print(tier, division)
        tmp_lst = []
        page_p = 1
        while True:
            try:
                api_key = next(api_it)
            except StopIteration:
                api_it = iter(api_keys)
                api_key = next(api_it)

            try:
                url = f'https://kr.api.riotgames.com/lol/league/v4/entries/RANKED_SOLO_5x5/{tier}/{division}?page={page_p}&api_key={api_key}'
                res_p = requests.get(url).json()
                tmp_lst.append(res_p[0]['summonerId'])
            except IndexError:
                break
            except Exception as e:
                print(f'suummoner names {e} 예외 발생 {res_p}, {api_key}')
                time.sleep(10)
                continue

            summoner_leagues.extend(res_p)
            if len(res_p) < 50:
                break
            page_p += 1

def tier_int(t):
    if t.tier == 'IRON':
        return 1
    elif t.tier == 'BRONZE':
        return 2
    elif t.tier == 'SILVER':
        return 3
    elif t.tier == 'GOLD':
        return 4
    elif t.tier == 'PLATINUM':
        return 5
    elif t.tier == 'DIAMOND':
        return 6
    elif t.tier == 'MASTER':
        return 7
    elif t.tier == 'GRANDMASTER':
        return 8
    elif t.tier == 'CHALLENGER':
        return 9


rank_df = pd.DataFrame(summoner_leagues)
rank_result_df = rank_df[['tier', 'leagueId', 'queueType', 'summonerName', 'leaguePoints', 'wins', 'losses', 'rank']]
rank_result_df['match_count'] = rank_result_df['wins'] + rank_result_df['losses']
rank_result_df['tier_int'] = rank_result_df.apply(lambda x: tier_int(x), axis=1)
rank_result_df.columns = [['tier', 'league_id', 'queue', 'summoner_name', 'lp', 'wins', 'losses', 'division', 'match_count', 'tier_int']]

# sql_conn = mu.connect_mysql()
def insert(t, conn_):
    insert_query = (
        f'INSERT INTO SUMMONER_RANK (TIER, LEAGUE_ID, QUEUE, SUMMONER_NAME, LP, WINS, LOSSES, DIVISION,'
        f' MATCH_COUNT, TIER_INT)'
        f'VALUES ({repr(t.tier)}, {repr(t.league_id)}, {repr(t.queue)}, {repr(t.summoner_name)}, '
        f'{t.lp}, {t.wins}, {t.losses}, {repr(t.division)}, {t.match_count})'
        f'ON DUPLICATE KEY UPDATE '
        f'tier = {repr(t.tier)}, league_id = {repr(t.league_id)}, queue = {repr(t.queue)},'
        f'summoner_name = {repr(t.summoner_name)}, lp = {t.lp}, wins = {t.wins}, losses = {t.losses}, '
        f'division = {repr(t.division)}, match_count = {t.match_count}'
    )
    mu.mysql_execute_dict(insert_query, conn_)

sql_conn = mu.connect_mysql()
rank_result_df.progress_apply(lambda x: insert(x, sql_conn), axis=1)
sql_conn.commit()
sql_conn.close()
