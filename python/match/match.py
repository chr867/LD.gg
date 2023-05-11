import datetime
import time
import pandas as pd
import requests
from tqdm import tqdm
import my_utils as mu
import json
import multiprocessing as mp
import logging
from collections import OrderedDict

tqdm.pandas()

sql_conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict('select * from match_raw limit 200', sql_conn))
sql_conn.close()

df['matches'] = df.apply(lambda x: json.loads(x['matches']), axis=1)
df['timeline'] = df.apply(lambda x: json.loads(x['timeline']), axis=1)

df_creater = []
columns = [
    'api_key', 'match_id', 'gameDuration', 'gameVersion', 'summonerName', 'summonerId', 'summonerLevel', 'participantId', 'championName',
    'championId', 'ban_champion_id', 'champExperience', 'teamPosition', 'teamId', 'win', 'kills', 'deaths', 'assists', 'towerDestroy', 'inhibitorDestroy',
    'dealToObject', 'dealToChamp', 'cs',
    'g_5', 'g_6', 'g_7', 'g_8', 'g_9', 'g_10', 'g_11', 'g_12', 'g_13', 'g_14', 'g_15', 'g_16',
    'g_17', 'g_18', 'g_19', 'g_20', 'g_21', 'g_22', 'g_23', 'g_24', 'g_25'
]
for m_idx, m in tqdm(enumerate(df['matches'])):
    if m['gameDuration'] < 900:
        continue
    p_idx = 1
    tower_destroy = 0
    bans = 0

    for p in m['participants']:
        game_end = list(df.iloc[m_idx]['timeline'].keys())[-1]
        minions_killed = df.iloc[m_idx]['timeline'][game_end]['participantFrames'][p_idx]['minionsKilled']
        jungle_minions_killed = df.iloc[m_idx]['timeline'][game_end]['participantFrames'][p_idx]['jungleMinionsKilled']
        cs = minions_killed + jungle_minions_killed

        tmp_lst = list(map(lambda x: x['events'], df.iloc[m_idx]['timeline'].values()))
        event_lst = [element for array in tmp_lst for element in array]
        tower_log = [i for i in event_lst if i['type'] == 'BUILDING_KILL']
        tower_destroy = 0
        for event in tower_log:
            if p_idx == event['killerId']:
                tower_destroy += 1

        if p['teamId'] == 100:
            team = 0
        else:
            team = 1

        if bans == 5:
            bans = 0

        df_creater.append([
            df['api_key'][m_idx],
            df.iloc[m_idx]['match_id'],
            m['gameDuration'],
            m['gameVersion'],
            p['summonerName'],
            p['summonerId'],
            p['summonerLevel'],
            p['participantId'],
            p['championName'],
            p['championId'],
            m['teams'][team]['bans'][bans]['championId'],
            p['champExperience'],
            p['teamPosition'],
            p['teamId'],
            p['win'],
            p['kills'],
            p['deaths'],
            p['assists'],
            tower_destroy,
            p['inhibitorKills'],
            p['damageDealtToObjectives'],
            p['totalDamageDealtToChampions'],
            cs
        ])
        p_idx += 1
        bans += 1

        for t in range(5, 26):
            try:
                p_id = str(p['participantId'])
                g_each = df.iloc[m_idx]['timeline']['info']['frames'][t]['participantFrames'][p_id]['totalGold']
                df_creater[-1].append(g_each)
            except:
                df_creater[-1].append(0)
sum_df = pd.DataFrame(df_creater, columns=columns)

def summoner_tier(x):
    url = f'https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/{x.summonerId}?api_key={x.api_key}'
    res = requests.get(url).json()
    try:
        res = res[0]['tier']
    except Exception as e:
        print(f'Error: {e}, {x.summonerName}')
        res = 0
    return res

sum_df['summonerTier'] = sum_df.progress_apply(lambda x: summoner_tier(x), axis=1)

def insert(t, conn):
    sql = (
        f"insert ignore into match_solr_rank (api_key, match_id, gameDuration, gameVersion, summonerName, summonerId," 
        f"summonerTier, 'summonerLevel', participantId, championName, championId, ban_champion_id, champExperience, teamPosition,"
        f"teamId, win, kills, deaths, assists, towerDestroy, inhibitorDestroy, dealToObject, dealToChamp, cs,"
        f"g_5, g_6, g_7, g_8, g_9, g_10, g_11, g_12, g_13, g_14, g_15, g_16, g_17, g_18, g_19, g_20, g_21, g_22,"
        f"g_23, g_24, g_25) "
        f"values ({repr(t.api_key)}, {repr(t.match_id)}, {t.gameDuration}, {repr(t.gameVersion)}, {repr(t.summonerName)},"
        f"{repr(t.summonerId)}, {repr(t.summonerTier)}, {t.summonerLevel}, {t.participantId}, {repr(t.championName)}, {t.championId},"
        f"{t.ban_champion_id}, {t.champExperience}, {repr(t.teamPosition)}, {repr(t.teamId)}, {repr(t.win)}, {t.kills},"
        f"{t.deaths}, {t.assists}, {t.towerDestroy}, {t.inhibitorDestroy}, {t.dealToObject}, {t.dealToChamp}, {t.cs},"
        f"{t.g_5}, {t.g_6}, {t.g_7}, {t.g_8}, {t.g_9}, {t.g_10}, {t.g_11}, {t.g_12}, {t.g_13}, {t.g_14}, {t.g_15},"
        f"{t.g_16}, {t.g_17}, {t.g_18}, {t.g_19}, {t.g_20}, {t.g_21}, {t.g_22}, {t.g_23}, {t.g_24}, {t.g_25})"
    )
    mu.mysql_execute(sql, conn)

sql_conn = mu.connect_mysql()
sum_df.progress_apply(lambda x: insert(x, sql_conn), axis=1)
sql_conn.commit()
sql_conn.close()