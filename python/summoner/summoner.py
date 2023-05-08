import datetime
import time
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

# summoner_rank_columns = ['tier', 'league_id', 'queue', 'summoner_name', 'lp', 'wins', 'loses', 'division', 'match_count']

rank_df = pd.DataFrame(summoner_leagues)
rank_result_df = rank_df[['tier', 'leagueId', 'queueType', 'summonerName', 'leaguePoints', 'wins', 'losses', 'rank']]
rank_result_df['match_count'] = rank_result_df['wins'] + rank_result_df['losses']
rank_result_df.columns = [['tier', 'league_id', 'queue', 'summoner_name', 'lp', 'wins', 'losses', 'division', 'match_count']]

sql_conn = mu.connect_mysql()
def insert(t, conn_):
    insert_query = (
        f'INSERT INTO SUMMONER_RANK (TIER, LEAGUE_ID, QUEUE, SUMMONER_NAME, LP, WINS, LOSSES, DIVISION,'
        f' MATCH_COUNT)'
        f'VALUES ({repr(t.tier)}, {repr(t.league_id)}, {repr(t.queue)}, {repr(t.summoner_name)}, '
        f'{t.lp}, {t.wins}, {t.losses}, {repr(t.division)}, {t.match_count})'
        f'ON DUPLICATE KEY UPDATE '
        f'tier = {repr(t.tier)}, league_id = {repr(t.league_id)}, queue = {repr(t.queue)},'
        f'summoner_name = {repr(t.summoner_name)}, lp = {t.lp}, wins = {t.wins}, losses = {t.losses}, '
        f'division = {repr(t.division)}, match_count = {t.match_count}'
    )
    mu.mysql_execute_dict(insert_query, conn_)

rank_result_df.progress_apply(lambda x: insert(x, sql_conn), axis=1)
sql_conn.commit()
sql_conn.close()


summoner_names = [i['summonerName'] for i in summoner_leagues]
summoner_info = []
for summoner_name in tqdm(summoner_names):
    tmp = []
    try:
        url = f'https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/{summoner_name}?api_key={api_key}'
        res = requests.get(url).json()
        tmp.append(res['accountId'])
    except Exception as e:
        print(f'suummoner names {e} 예외 발생 {res}, {summoner_name}, {api_key}')
        continue
    summoner_info.append(res)

summoner_names = [i['summonerName'] for i in summoner_leagues]
summoner_info = []
for summoner_name in tqdm(summoner_names):
    tmp = []
    try:
        url = f'https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/{summoner_name}?api_key={api_key}'
        res = requests.get(url).json()
        tmp.append(res['accountId'])
    except Exception as e:
        print(f'suummoner names {e} 예외 발생 {res}, {summoner_name}, {api_key}')
        continue
    summoner_info.append(res)

info_df = pd.DataFrame(summoner_info)
info_result_df = info_df[['name', 'summonerLevel', 'profileIconId', 'revisionDate']]
info_result_df.columns = ['summoner_name', 's_level', 'profile_icon_id', 'revision_date']

for_merge_df = rank_result_df[['summoner_name', 'match_count', 'tier', 'wins', 'losses', 'lp', 'division']][:20]
for_merge_df.columns = ['summoner_name', 'games', 'tier', 'wins', 'losses', 'lp', 'ranking']

info_merged_df = pd.merge(info_result_df, for_merge_df)
info_merged_df.keys()
def info_insert(s, conn):
    insert_query = (
        f'INSERT INTO SUMMONER_INFO (SUMMONER_NAME, S_LEVEL, PROFILE_ICON_ID, GAMES, TIER, WINS, LOSSES, LP, RANKING) '
        f'VALUES ({repr(s.summoner_name)}, {s.s_level}, {s.profile_icon_id}, {s.games}, {repr(s.tier)}, {s.wins}, {s.losses}, {s.lp}, {repr(s.ranking)}) '
        f'ON DUPLICATE KEY UPDATE '
        f'SUMMONER_NAME = {repr(s.summoner_name)}, S_LEVEL = {s.s_level}, PROFILE_ICON_ID = {s.profile_icon_id}, GAMES = {s.games}, '
        f'TIER = {repr(s.tier)}, WINS = {s.wins}, LOSSES = {s.losses}, LP = {s.lp}, RANKING = {repr(s.ranking)}'
    )
    mu.mysql_execute_dict(insert_query, conn)

sql_conn = mu.connect_mysql()
info_merged_df.progress_apply(lambda x: info_insert(x, sql_conn), axis=1)
sql_conn.commit()
sql_conn.close()

