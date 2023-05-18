import time

import pandas as pd
import requests
from tqdm import tqdm

import my_utils as mu
import private
tqdm.pandas()

tiers = ['IRON', 'BRONZE', 'SILVER', 'GOLD', 'PLATINUM', 'DIAMOND']
divisions = ['IV', 'III', 'II', 'I']
api_keys = private.riot_api_key_array_summoner

api_it = iter(api_keys)
summoner_leagues = []
## 전체 유저 버전
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
## 전체 유저 끝

# 그마챌 만
name_list = []
api_it = iter(api_keys)
tiers = ['C', 'GM', 'M']
for i in tqdm(tiers):
    while True:
        try:
            api_key = next(api_it)
        except StopIteration:
            api_it = iter(api_keys)
            api_key = next(api_it)
        if i == 'C':
            url = f'https://kr.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5?api_key={api_key}'
        elif i == 'GM':
            url = f'https://kr.api.riotgames.com/lol/league/v4/grandmasterleagues/by-queue/RANKED_SOLO_5x5?api_key={api_key}'
        else:  # M
            url = f'https://kr.api.riotgames.com/lol/league/v4/masterleagues/by-queue/RANKED_SOLO_5x5?api_key={api_key}'
        while True:
            try:
                res_p = requests.get(url).json()
                for summoner in res_p['entries']:
                    name_list.append([
                        res_p['tier'],
                        res_p['leagueId'],
                        res_p['queue'],
                        summoner['summonerName'],
                        summoner['leaguePoints'],
                        summoner['wins'],
                        summoner['losses'],
                        1
                    ])
            except Exception:
                if 'Forbidden' in res_p['status']['message']:
                    break

                print(f'suummoner names 예외 발생 {res_p["status"]["message"]}, {api_key}')
                time.sleep(20)
                continue
            break
        break
## 그마챌 끝

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

columns = ['tier', 'leagueId', 'queueType', 'summonerName', 'leaguePoints', 'wins', 'losses', 'rank']
rank_df = pd.DataFrame(name_list, columns=columns)
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
        f'{t.lp}, {t.wins}, {t.losses}, {repr(t.division)}, {t.match_count}, {t.tier_int})'
        f'ON DUPLICATE KEY UPDATE '
        f'tier = {repr(t.tier)}, league_id = {repr(t.league_id)}, queue = {repr(t.queue)},'
        f'summoner_name = {repr(t.summoner_name)}, lp = {t.lp}, wins = {t.wins}, losses = {t.losses}, '
        f'division = {repr(t.division)}, match_count = {t.match_count}, tier_int = {t.tier_int}'
    )
    mu.mysql_execute_dict(insert_query, conn_)

sql_conn = mu.connect_mysql()
rank_result_df.progress_apply(lambda x: insert(x, sql_conn), axis=1)
sql_conn.commit()
sql_conn.close()
