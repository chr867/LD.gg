import datetime
import time
import pandas as pd
import requests
from tqdm import tqdm
import my_utils as mu
import json
import multiprocessing as mp
import logging
tqdm.pandas()

api_key = mu.riot_api_key

tiers = ['IRON', 'BRONZE', 'SILVER', 'GOLD', 'PLATINUM', 'DIAMOND']
divisions = ['IV', 'III', 'II', 'I']

summoner_leagues = []
for tier in tqdm(tiers):
    for division in tqdm(divisions):
        print(tier, division)
        tmp_lst = []
        page_p = 1
        while True:
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

# summoner_info_columns = ['summoner_name', 's_level', 'profile_icon_id', 'games', 'tier', 'wins', 'losses', 'lp',
#                          'ranking', 'revision_date']
# league = ['tier', 'leagueId', 'queueType', 'summonerName', 'leaguePoints', 'wins', 'losses', 'tier', 'wins'+'loses']

summoner_ids = [i['summonerId'] for i in summoner_leagues]

for summoner_id in summoner_ids:
    url = f'https://kr.api.riotgames.com/lol/summoner/v4/summoners/2-SCJRP1c3zeRE8A_sSDinXqBIo5A53o3mZZDZTxFOiYFWY-6I1IljjVRw?api_key={api_key}'
