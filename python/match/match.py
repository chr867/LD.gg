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

sql_conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict('select * from match_raw limit 200', sql_conn))
sql_conn.close()

df['matches'] = df.apply(lambda x: json.loads(x['matches']), axis=1)
df['timeline'] = df.apply(lambda x: json.loads(x['timeline']), axis=1)

df['matches'][0]['info']['participants'][0].keys()

game_end = len(df['timeline'][0]['info']['frames'])-1
minions_killed = df['timeline'][0]['info']['frames'][game_end]['participantFrames']['1']['minionsKilled']
jungle_minions_killed = df['timeline'][0]['info']['frames'][game_end]['participantFrames']['1']['jungleMinionsKilled']
cs = minions_killed + jungle_minions_killed


df_creater = []
columns = [
    'match_id', 'gameDuration', 'gameVersion', 'summonerName', 'summonerLevel', 'participantId', 'championName',
    'champExperience', 'teamPosition', 'teamId', 'win', 'kills', 'deaths', 'assists', 'towerDestroy', 'inhibitorDestroy',
    'dealToObject', 'dealToChamp', 'cs',
    'g_5', 'g_6', 'g_7', 'g_8', 'g_9', 'g_10', 'g_11', 'g_12', 'g_13', 'g_14', 'g_15', 'g_16',
    'g_17', 'g_18', 'g_19', 'g_20', 'g_21', 'g_22', 'g_23', 'g_24', 'g_25'
]
for m_idx, m in tqdm(enumerate(df['matches'])):
    if m['info']['gameDuration'] < 900:
        continue
    p_idx = 1
    tower_destroy = 0
    for p in m['info']['participants']:
        tower_destroy = 0
        game_end = len(df['timeline'][m_idx]['info']['frames']) - 1
        minions_killed = df['timeline'][m_idx]['info']['frames'][game_end]['participantFrames'][str(p_idx)]['minionsKilled']
        jungle_minions_killed = df['timeline'][m_idx]['info']['frames'][game_end]['participantFrames'][str(p_idx)]['jungleMinionsKilled']
        cs = minions_killed + jungle_minions_killed

        tmp_lst = list(map(lambda x: x['events'], df.iloc[m_idx]['timeline']['info']['frames']))
        event_lst = [element for array in tmp_lst for element in array]
        tower_log = [i for i in event_lst if i['type'] == 'BUILDING_KILL']

        for event in tower_log:
            if p_idx == event['killerId']:
                tower_destroy += 1
        df_creater.append([
            m['metadata']['matchId'],
            m['info']['gameDuration'],
            m['info']['gameVersion'],
            p['summonerName'],
            p['summonerLevel'],
            p['participantId'],
            p['championName'],
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
        for t in range(5, 26):
            try:
                p_id = str(p['participantId'])
                g_each = df.iloc[m_idx]['timeline']['info']['frames'][t]['participantFrames'][p_id]['totalGold']
                df_creater[-1].append(g_each)
            except:
                df_creater[-1].append(0)


df_filtered = df[df['matches'].apply(lambda x: x['info']['gameDuration'] >= 900)]
df_creater = []
columns = [
    'match_id', 'gameDuration', 'gameVersion', 'summonerName', 'summonerLevel', 'participantId', 'championName',
    'champExperience', 'teamPosition', 'teamId', 'win', 'kills', 'deaths', 'assists', 'towerDestroy', 'inhibitorDestroy',
    'dealToObject', 'dealToChamp', 'cs',
    'g_5', 'g_6', 'g_7', 'g_8', 'g_9', 'g_10', 'g_11', 'g_12', 'g_13', 'g_14', 'g_15', 'g_16',
    'g_17', 'g_18', 'g_19', 'g_20', 'g_21', 'g_22', 'g_23', 'g_24', 'g_25'
]
tower_log = [i for m in df_filtered['timeline'] for frame in m['info']['frames'] for i in frame['events'] if i['type'] == 'BUILDING_KILL']
for m_idx, m in tqdm(enumerate(df_filtered['matches'])):
    p_idx = 1
    tower_destroy = 0
    for p in m['info']['participants']:
        tower_destroy = sum(1 for event in tower_log if event['killerId'] == p_idx)
        print(df_filtered['timeline'].keys())
        game_end = len(df_filtered['timeline'][m_idx]['info']['frames']) - 1
        minions_killed = df_filtered['timeline'][m_idx]['info']['frames'][game_end]['participantFrames'][str(p_idx)]['minionsKilled']
        jungle_minions_killed = df_filtered['timeline'][m_idx]['info']['frames'][game_end]['participantFrames'][str(p_idx)]['jungleMinionsKilled']
        cs = minions_killed + jungle_minions_killed
        df_creater.append([
            m['metadata']['matchId'],
            m['info']['gameDuration'],
            m['info']['gameVersion'],
            p['summonerName'],
            p['summonerLevel'],
            p['participantId'],
            p['championName'],
            p['championName'],
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
        for t in range(5, 26):
            try:
                p_id = str(p['participantId'])
                g_each = df_filtered.iloc[m_idx]['timeline']['info']['frames'][t]['participantFrames'][p_id]['totalGold']
                df_creater[-1].append(g_each)
            except:
                df_creater[-1].append(0)

sum_df = pd.DataFrame(df_creater, columns=columns)

