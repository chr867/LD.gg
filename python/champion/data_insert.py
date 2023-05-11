# --------------------------------------------------------
# Package
import pandas as pd
import requests
from tqdm import tqdm
import my_utils as mu
import json
import time
import numpy as np

tqdm.pandas()

# RIOT-API-KEY
riot_api_key = 'RGAPI-73a75ebb-9e24-4870-89ae-a96274d14522'
# ----------------------------------------------------------------------------------------------------------------------
conn = mu.connect_mysql()
start_time = time.time()
df = pd.DataFrame(mu.mysql_execute_dict("SELECT * FROM match_raw LIMIT 80", conn))
conn.close()
df['matches'] = df['matches'].apply(json.loads)
df['timeline'] = df['timeline'].apply(json.loads)


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

df.iloc[0]['matches']['info']['participants'][1]['challenges']['mythicItemUsed']

df.iloc[0]['matches']['matchId']
df.iloc[0]['matches']['metadata']['matchId']

df.iloc[0]['matches']['info']['gameDuration']
df.iloc[0]['matches']['info']['gameVersion']
for userNum in len(df.iloc[0]['matches']['info']['participants']):
    df.iloc[0]['matches']['info']['participants'][userNum]['kills']
    df.iloc[0]['matches']['info']['participants'][userNum]['deaths']
    df.iloc[0]['matches']['info']['participants'][userNum]['assists']
    df.iloc[0]['matches']['info']['participants'][userNum]['challenges']['kda']
    df.iloc[0]['matches']['info']['participants'][userNum]['item0']
    df.iloc[0]['matches']['info']['participants'][userNum]['item1']
    df.iloc[0]['matches']['info']['participants'][userNum]['item2']
    df.iloc[0]['matches']['info']['participants'][userNum]['item3']
    df.iloc[0]['matches']['info']['participants'][userNum]['item4']
    df.iloc[0]['matches']['info']['participants'][userNum]['item5']
    df.iloc[0]['matches']['info']['participants'][userNum]['item6']
    df.iloc[0]['matches']['info']['participants'][userNum]['mythicItemUsed']  # 예외처리 필수

    for team in df.iloc[0]['matches']['info']['teams']:
        for ban in df.iloc[0]['matches']['info']['teams'][0]['bans']:
            print(ban['championId'])

    df.iloc[0]['matches']['info']['participants'][userNum]['perks']['statPerks']['defense']
    df.iloc[0]['matches']['info']['participants'][userNum]['perks']['statPerks']['flex']
    df.iloc[0]['matches']['info']['participants'][userNum]['perks']['statPerks']['offense']
    df.iloc[0]['matches']['info']['participants'][userNum]['perks']['styles'][0]['style']
    for perks in df.iloc[0]['matches']['info']['participants'][userNum]['perks']['styles'][0]['selections']:
        perks['perk']
    df.iloc[0]['matches']['info']['participants'][userNum]['perks']['styles'][1]['style']
    for perks in df.iloc[0]['matches']['info']['participants'][userNum]['perks']['styles'][1]['selections']:
        perks['perk']
    df.iloc[0]['matches']['info']['participants'][userNum]['perks']['styles'][1]['style']

    df.iloc[0]['matches']['info']['participants'][userNum]['summoner1Id']
    df.iloc[0]['matches']['info']['participants'][userNum]['summoner2Id']
    df.iloc[0]['matches']['info']['participants'][userNum]['participantId']
    df.iloc[0]['matches']['info']['participants'][userNum]['championId']
    df.iloc[0]['matches']['info']['participants'][userNum]['totalDamageDealtToChampions']
    df.iloc[0]['matches']['info']['participants'][userNum]['totalDamageTaken']
    df.iloc[0]['matches']['info']['participants'][userNum]['teamPosition']
    df.iloc[0]['matches']['info']['participants'][userNum]['teamId']
    df.iloc[0]['matches']['info']['participants'][userNum]['totalMinionsKilled']
    df.iloc[0]['matches']['info']['participants'][userNum]['profileIcon']
    df.iloc[0]['matches']['info']['participants'][userNum]['puuid']
    df.iloc[0]['matches']['info']['participants'][userNum]['summonerName']
    df.iloc[0]['matches']['info']['participants'][userNum]['summonerLevel']
    df.iloc[0]['matches']['info']['participants'][userNum]['challenges']['soloKills']
    df.iloc[0]['matches']['info']['participants'][userNum]['doubleKills']
    df.iloc[0]['matches']['info']['participants'][userNum]['tripleKills']
    df.iloc[0]['matches']['info']['participants'][userNum]['quadraKills']
    df.iloc[0]['matches']['info']['participants'][userNum]['pentaKills']
    df.iloc[0]['matches']['info']['participants'][userNum]['win']


# ----------------------------------------------------------------------------------------------------------------------
def matches_data(df):
    match_info = df['matches']['info']
    participant_list = match_info['participants']
    team_list = match_info['teams']

    matches = {
        'gameDuration': match_info['gameDuration'],
        'gameVersion': match_info['gameVersion'],
        'participants': []
    }

    for userNum in range(len(participant_list)):
        participant_dict = {
            'kills': participant_list[userNum]['kills'],
            'deaths': participant_list[userNum]['deaths'],
            'assists': participant_list[userNum]['assists'],
            'kda': participant_list[userNum]['challenges']['kda'],
            'item0': participant_list[userNum]['item0'],
            'item1': participant_list[userNum]['item1'],
            'item2': participant_list[userNum]['item2'],
            'item3': participant_list[userNum]['item3'],
            'item4': participant_list[userNum]['item4'],
            'item5': participant_list[userNum]['item5'],
            'item6': participant_list[userNum]['item6'],
            'mythicItemUsed': participant_list[userNum].get('mythicItemUsed', 0),
            'defense': participant_list[userNum]['perks']['statPerks']['defense'],
            'flex': participant_list[userNum]['perks']['statPerks']['flex'],
            'offense': participant_list[userNum]['perks']['statPerks']['offense'],
            'style0': participant_list[userNum]['perks']['styles'][0]['style'],
            'perks0': [perks['perk'] for perks in participant_list[userNum]['perks']['styles'][0]['selections']],
            'style1': participant_list[userNum]['perks']['styles'][1]['style'],
            'perks1': [perks['perk'] for perks in participant_list[userNum]['perks']['styles'][1]['selections']],
            'summoner1Id': participant_list[userNum]['summoner1Id'],
            'summoner2Id': participant_list[userNum]['summoner2Id'],
            'participantId': participant_list[userNum]['participantId'],
            'totalMinionsKilled': participant_list[userNum]['totalMinionsKilled'],
            'championId': participant_list[userNum]['championId'],
            'win': participant_list[userNum]['win'],
            'totalDamageDealtToChampions': participant_list[userNum]['totalDamageDealtToChampions'],
            'damageDealtToObjectives': participant_list[userNum]['damageDealtToObjectives'],
            'totalDamageTaken': participant_list[userNum]['totalDamageTaken'],
            'inhibitorKills': participant_list[userNum]['inhibitorKills'],
            'teamPosition': participant_list[userNum]['teamPosition'],
            'teamId': participant_list[userNum]['teamId'],
            'profileIcon': participant_list[userNum]['profileIcon'],
            'puuid': participant_list[userNum]['puuid'],
            'summonerName': participant_list[userNum]['summonerName'],
            'summonerLevel': participant_list[userNum]['summonerLevel'],
            'soloKills': participant_list[userNum]['challenges']['soloKills'],
            'doubleKills': participant_list[userNum]['doubleKills'],
            'tripleKills': participant_list[userNum]['tripleKills'],
            'quadraKills': participant_list[userNum]['quadraKills'],
            'pentaKills': participant_list[userNum]['pentaKills'],
        }
        matches['participants'].append(participant_dict)

    ban_list = []
    for team in team_list:
        for ban in team['bans']:
            ban_list.append(ban['championId'])

    matches['bans'] = ban_list
    return matches


test = matches_data(df.iloc[0])


# ----------------------------------------------------------------------------------------------------------------------
def time_line_data(df):
    time_line = {}
    for i, frame in enumerate(df['timeline']['info']['frames']):
        result = {'events': [], 'participantFrames': []}
        events = []
        for event in frame['events']:
            if event['type'] == 'SKILL_LEVEL_UP' or event['type'] == 'ITEM_PURCHASED' or event[
                'type'] == 'BUILDING_KILL':
                events.append(event)
        result['events'].extend(events)
        for participant in range(len(frame['participantFrames'])):
            participant_dict = {
                'participantId': frame['participantFrames'][f'{participant + 1}']['participantId'],
                'level': frame['participantFrames'][f'{participant + 1}']['level'],
                'totalGold': frame['participantFrames'][f'{participant + 1}']['totalGold']
            }
            result['participantFrames'].append(participant_dict)
        time_line[i] = result
    return time_line


time_line_data = time_line_data(df.iloc[0])


def df_refine(df):
    def matches_data(df):

        match_info = df['matches']['info']
        participant_list = match_info['participants']
        team_list = match_info['teams']

        matches = {
            'gameDuration': match_info['gameDuration'],
            'gameVersion': match_info['gameVersion'],
            'participants': []
        }

        for userNum in range(len(participant_list)):
            participant_dict = {
                'kills': participant_list[userNum]['kills'],
                'deaths': participant_list[userNum]['deaths'],
                'assists': participant_list[userNum]['assists'],
                'kda': participant_list[userNum]['challenges']['kda'],
                'item0': participant_list[userNum]['item0'],
                'item1': participant_list[userNum]['item1'],
                'item2': participant_list[userNum]['item2'],
                'item3': participant_list[userNum]['item3'],
                'item4': participant_list[userNum]['item4'],
                'item5': participant_list[userNum]['item5'],
                'item6': participant_list[userNum]['item6'],
                'mythicItemUsed': participant_list[userNum].get('mythicItemUsed', 0),
                'defense': participant_list[userNum]['perks']['statPerks']['defense'],
                'flex': participant_list[userNum]['perks']['statPerks']['flex'],
                'offense': participant_list[userNum]['perks']['statPerks']['offense'],
                'style0': participant_list[userNum]['perks']['styles'][0]['style'],
                'perks0': [perks['perk'] for perks in participant_list[userNum]['perks']['styles'][0]['selections']],
                'style1': participant_list[userNum]['perks']['styles'][1]['style'],
                'perks1': [perks['perk'] for perks in participant_list[userNum]['perks']['styles'][1]['selections']],
                'summoner1Id': participant_list[userNum]['summoner1Id'],
                'summoner2Id': participant_list[userNum]['summoner2Id'],
                'participantId': participant_list[userNum]['participantId'],
                'totalMinionsKilled': participant_list[userNum]['totalMinionsKilled'],
                'championId': participant_list[userNum]['championId'],
                'win': participant_list[userNum]['win'],
                'totalDamageDealtToChampions': participant_list[userNum]['totalDamageDealtToChampions'],
                'damageDealtToObjectives': participant_list[userNum]['damageDealtToObjectives'],
                'totalDamageTaken': participant_list[userNum]['totalDamageTaken'],
                'inhibitorKills': participant_list[userNum]['inhibitorKills'],
                'teamPosition': participant_list[userNum]['teamPosition'],
                'teamId': participant_list[userNum]['teamId'],
                'profileIcon': participant_list[userNum]['profileIcon'],
                'puuid': participant_list[userNum]['puuid'],
                'summonerName': participant_list[userNum]['summonerName'],
                'summonerLevel': participant_list[userNum]['summonerLevel'],
                'soloKills': participant_list[userNum]['challenges']['soloKills'],
                'doubleKills': participant_list[userNum]['doubleKills'],
                'tripleKills': participant_list[userNum]['tripleKills'],
                'quadraKills': participant_list[userNum]['quadraKills'],
                'pentaKills': participant_list[userNum]['pentaKills'],
            }
            matches['participants'].append(participant_dict)

        ban_list = []
        for team in team_list:
            for ban in team['bans']:
                ban_list.append(ban['championId'])

        matches['bans'] = ban_list
        return matches

    def time_line_data(df):
        time_line = {}
        for i, frame in enumerate(df['timeline']['info']['frames']):
            result = {'events': [], 'participantFrames': []}
            events = []
            for event in frame['events']:
                if event['type'] == 'SKILL_LEVEL_UP' or event['type'] == 'ITEM_PURCHASED' or event[
                    'type'] == 'BUILDING_KILL':
                    events.append(event)
            result['events'].extend(events)
            for participant in range(len(frame['participantFrames'])):
                participant_dict = {
                    'participantId': frame['participantFrames'][f'{participant + 1}']['participantId'],
                    'level': frame['participantFrames'][f'{participant + 1}']['level'],
                    'totalGold': frame['participantFrames'][f'{participant + 1}']['totalGold']
                }
                result['participantFrames'].append(participant_dict)
            time_line[i] = result
        return time_line

    match_id = df['matches']['metadata']['matchId']
    matches = matches_data(df)
    time_line = time_line_data(df)

    columns = ['match_id', 'matches', 'time_line']
    refine_df = pd.DataFrame([[match_id, matches, time_line]], columns=columns)
    return refine_df


refine_df = pd.concat([df_refine(row) for _, row in df.iterrows()], ignore_index=True)
refine_df.iloc[0]['time_line']