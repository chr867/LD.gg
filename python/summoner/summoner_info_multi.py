import time

import pandas as pd
import requests
from tqdm import tqdm

import my_utils as mu
import private
tqdm.pandas()

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

def get_summoner_info(k_):
    print('get_summoner_info', len(k_))
    result = []
    for k in tqdm(k_):
        while True:
            try:
                url = f'https://kr.api.riotgames.com/lol/summoner/v4/summoners/{k["summonerId"]}?api_key={k["api_key"]}'
                res = requests.get(url).json()
                if res.get('status') is None:
                    result.append(res)
                else:
                    if 'message' in res['status']['message']:
                        time.sleep(20)
                        continue
                    else:
                        print(res)
                        break
            except Exception as e:
                print(f'suummoner names {e} 예외 발생 {res}, {k["summonerId"]}, {k["api_key"]}')
                time.sleep(20)
                continue
            break
    return result

def info_insert(s, conn):
    insert_query = (
        f'INSERT INTO SUMMONER_INFO (SUMMONER_NAME, S_LEVEL, PROFILE_ICON_ID, GAMES, TIER, WINS, LOSSES, LP, RANKING, TIER_INT) '
        f'VALUES ({repr(s.summoner_name)}, {s.s_level}, {s.profile_icon_id}, {s.games}, {repr(s.tier)}, {s.wins}, {s.losses}, {s.lp}, {repr(s.ranking)}, {s.tier_int}) '
        f'ON DUPLICATE KEY UPDATE '
        f'SUMMONER_NAME = {repr(s.summoner_name)}, S_LEVEL = {s.s_level}, PROFILE_ICON_ID = {s.profile_icon_id}, GAMES = {s.games}, '
        f'TIER = {repr(s.tier)}, WINS = {s.wins}, LOSSES = {s.losses}, LP = {s.lp}, RANKING = {repr(s.ranking)}, TIER_INT = {s.tier_int}'
    )
    mu.mysql_execute_dict(insert_query, conn)

api_keys = private.riot_api_key_array_summoner
# 그마챌 만
info_list = []
summoner_list = []
rank_list = []
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
                    summoner_list.append({
                        'summonerId': summoner['summonerId'],
                        'api_key': api_key
                    })
                    rank_list.append({
                        'tier': res_p['tier'],
                        'leagueId': res_p['leagueId'],
                        'queueType': res_p['queue'],
                        'summonerName': summoner['summonerName'],
                        'leaguePoints': summoner['leaguePoints'],
                        'wins': summoner['wins'],
                        'losses': summoner['losses'],
                        'rank': summoner['rank']
                    })
            except Exception:
                if 'Forbidden' in res_p['status']['message']:
                    break
                print(f'suummoner names 예외 발생 {res_p["status"]["message"]}, {api_key}')
                time.sleep(20)
                continue
            break
        for info in tqdm(summoner_list):
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
                res_p = requests.get(url).json()

                if res_p.get('status') is not None:
                    print('status:', res_p['status'], api_key)
                    time.sleep(20)
                    continue
                else:
                    print('KeyError:', res_p)
                    break

                for summoner in res_p['entries']:
                    info_list.append({
                        'summonerId': summoner['summonerId'],
                        'api_key': api_key
                    })
                break

rank_result_df = pd.DataFrame(rank_list)
rank_result_df['match_count'] = rank_result_df['wins'] + rank_result_df['losses']
rank_result_df['tier_int'] = rank_result_df.apply(lambda x: tier_int(x), axis=1)
rank_result_df.columns = [
    ['tier', 'league_id', 'queue', 'summoner_name', 'lp', 'wins', 'losses', 'division', 'match_count', 'tier_int']]


summoner_info = get_summoner_info(summoner_list)

info_df = pd.DataFrame(summoner_info)
info_result_df = info_df[['name', 'summonerLevel', 'profileIconId', 'revisionDate']]
info_result_df.columns = ['summoner_name', 's_level', 'profile_icon_id', 'revision_date']

for_merge_df = rank_result_df[['summoner_name', 'match_count', 'tier', 'wins', 'losses', 'lp', 'division', 'tier_int']]
for_merge_df.columns = ['summoner_name', 'games', 'tier', 'wins', 'losses', 'lp', 'ranking', 'tier_int']

info_merged_df = pd.merge(info_result_df, for_merge_df)
print(len(info_merged_df))

sql_conn = mu.connect_mysql()
print('insert')
info_merged_df.progress_apply(lambda x: info_insert(x, sql_conn), axis=1)

sql_conn.commit()
sql_conn.close()
print('done')
