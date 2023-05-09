import datetime
import random
import time
import pandas as pd
import requests
from tqdm import tqdm
import private
import my_utils as mu
import json
import multiprocessing as mp
import numpy as np
import logging
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
            tmp = []
            res = None
            try:
                url = f'https://kr.api.riotgames.com/lol/summoner/v4/summoners/{k["summonerId"]}?api_key={k["api_key"]}'
                res = requests.get(url).json()
                tmp.append(res['accountId'])
                result.extend(res)
            except Exception as e:
                print(f'suummoner names {e} 예외 발생 {res}, {k["summonerId"]}, {k["api_key"]}')
                time.sleep(20)
                continue
            break
    return result

def info_insert(s, conn):
    insert_query = (
        f'INSERT INTO SUMMONER_INFO (SUMMONER_NAME, S_LEVEL, PROFILE_ICON_ID, GAMES, TIER, WINS, LOSSES, LP, RANKING) '
        f'VALUES ({repr(s.summoner_name)}, {s.s_level}, {s.profile_icon_id}, {s.games}, {repr(s.tier)}, {s.wins}, {s.losses}, {s.lp}, {repr(s.ranking)}) '
        f'ON DUPLICATE KEY UPDATE '
        f'SUMMONER_NAME = {repr(s.summoner_name)}, S_LEVEL = {s.s_level}, PROFILE_ICON_ID = {s.profile_icon_id}, GAMES = {s.games}, '
        f'TIER = {repr(s.tier)}, WINS = {s.wins}, LOSSES = {s.losses}, LP = {s.lp}, RANKING = {repr(s.ranking)}'
    )
    mu.mysql_execute_dict(insert_query, conn)

def main():
    tiers = ['IRON', 'BRONZE', 'SILVER', 'GOLD', 'PLATINUM', 'DIAMOND']
    divisions = ['IV', 'III', 'II', 'I']
    api_keys = private.api_keys

    api_it = iter(api_keys)
    summoner_leagues = []
    result = []
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
                    test = [{'summonerId': i['summonerId'], 'api_key': api_key} for i in res_p]
                    result.extend(test)
                except IndexError:
                    break
                except Exception as e:
                    print(f'suummoner names {e} 예외 발생 {res_p}, {api_key}')
                    time.sleep(10)
                    continue

                summoner_leagues.extend(res_p)
                if len(res_p) < 50:
                    break
                break
                page_p += 1
    rank_df = pd.DataFrame(summoner_leagues)
    rank_result_df = rank_df[
        ['tier', 'leagueId', 'queueType', 'summonerName', 'leaguePoints', 'wins', 'losses', 'rank']]
    rank_result_df['match_count'] = rank_result_df['wins'] + rank_result_df['losses']
    rank_result_df['tier_int'] = rank_result_df.apply(lambda x: tier_int(x), axis=1)
    rank_result_df.columns = [
        ['tier', 'league_id', 'queue', 'summoner_name', 'lp', 'wins', 'losses', 'division', 'match_count', 'tier_int']]

    # result_splits = np.array_split(result, 4)
    # result_splits = [list(split) for split in result_splits]  # numpy array를 일반 리스트로 변환

    result_splits = []
    chunk_size = len(result) // 4
    start = 0
    for _ in range(4):
        end = start + chunk_size
        result_splits.append(result[start:end])
        start = end

    summoner_info = []
    with mp.Pool(processes=4) as pool:
        results = list(tqdm(pool.imap(get_summoner_info, result_splits), total=len(result_splits)))

    for n in results:
        summoner_info.append(n)

    info_df = pd.DataFrame(summoner_info)
    info_result_df = info_df[['name', 'summonerLevel', 'profileIconId', 'revisionDate']]
    info_result_df.columns = ['summoner_name', 's_level', 'profile_icon_id', 'revision_date']

    for_merge_df = rank_result_df[['summoner_name', 'match_count', 'tier', 'wins', 'losses', 'lp', 'division']]
    for_merge_df.columns = ['summoner_name', 'games', 'tier', 'wins', 'losses', 'lp', 'ranking']

    info_result_df['summoner_name'].unique()
    for_merge_df['summoner_name'].unique()

    info_merged_df = pd.merge(info_result_df, for_merge_df)
    print(len(info_merged_df))

    sql_conn = mu.connect_mysql()
    info_merged_df.progress_apply(lambda x: info_insert(x, sql_conn), axis=1)

    # 작업이 완료될 때까지 대기
    pool.close()
    pool.join()

    sql_conn.commit()
    sql_conn.close()

if __name__ == '__main__':
    main()




