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
import logging
tqdm.pandas()

riot_api_keys = private.riot_api_key_array_summoner

# 티어별 유저 이름, 이름으로 puuid, puuid로 match id
def load_summoner_names_worker():
    api_key = riot_api_keys[0]
    tier_division = ['C', 'GM', 'M']
    name_set = set()

    for i in tqdm(tier_division):
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
                    name_set.add(summoner['summonerId'])
            except Exception:
                if 'Forbidden' in res_p['status']['message']:
                    break

                print(f'suummoner names 예외 발생 {res_p["status"]["message"]}, {api_key}')
                time.sleep(20)
                continue
            break

        print('load_summoner_names END')

        name_lst = list(name_set)
        random.shuffle(name_lst)
        match_set = set()
        api_it = iter(riot_api_keys)
        for summoner_name in tqdm(name_lst[:25]):
            while True:
                index = 0
                start = 1673362800  # 시즌 시작 Timestamp
                # tmp = 1683438967290
                try:
                    api_key = next(api_it)
                except StopIteration:
                    api_it = iter(riot_api_keys)
                    api_key = next(api_it)

                try:
                    url = f'https://kr.api.riotgames.com/lol/summoner/v4/summoners/{summoner_name}?api_key={api_key}'
                    res = requests.get(url).json()
                    puuid = res['puuid']

                    while True:
                        url = f'https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/{puuid}/ids?startTime={start}&type=ranked&start={index}&count=100&api_key={api_key}'
                        res = requests.get(url).json()
                        index += 100
                        if len(res) == 1:
                            print(res)
                            time.sleep(5)
                            continue

                        match_set.update(res)

                        if len(res) < 10:
                            print(len(match_set))
                            break

                except Exception as e:
                    if 'found' in res['status']['message']:
                        print(summoner_name, 'not found')
                        break

                    print(f'{e} 예외 발생, {res["status"]["message"]},{api_key}')
                    time.sleep(20)
                    continue

                break

    match_list = list(match_set)
    print('load_match_ids END', len(match_list))
    return match_list
# 끝

# match_id, matches, timeline 폼으로 만들기
def get_match_info_worker(args):
    _match_ids, i = args
    _result = []
    api_key = private.riot_api_key_array[i]
    tmp = set()
    random.shuffle(_match_ids)

    for match_id in tqdm(_match_ids):  # 수정점
        while True:
            try:
                get_match_url = f'https://asia.api.riotgames.com/lol/match/v5/matches/{match_id}?api_key={api_key}'
                get_match_res = requests.get(get_match_url).json()
                tmp.update(get_match_res['metadata'])
            except Exception as e:
                print(f'{e} match, {get_match_res["status"]["message"]},{api_key}')
                if 'found' in get_match_res['status']['message']:
                    break
                if 'Forbidden' in get_match_res['status']['message']:
                    break
                time.sleep(20)
                continue

            try:
                get_timeline_url = f'https://asia.api.riotgames.com/lol/match/v5/matches/{match_id}/timeline?api_key={api_key}'
                get_timeline_res = requests.get(get_timeline_url).json()
                tmp.update(get_timeline_res['metadata'])
            except Exception as e:
                print(f'{e} timeline, {get_timeline_res},{api_key}')
                if 'found' in get_timeline_res['status']['message']:
                    break
                if 'Forbidden' in get_timeline_res['status']['message']:
                    break
                time.sleep(20)
                continue

            _result.append([api_key, match_id, get_match_res, get_timeline_res])
            tmp.clear()
            break

    result_df = pd.DataFrame(_result, columns=['api_key', 'match_id', 'matches', 'timeline'])
    print('get_match_info END len = ', len(result_df))
    return result_df
# 끝

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
                'mythicItemUsed': participant_list[userNum]['challenges'].get('mythicItemUsed', 0),
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
                'championName': participant_list[userNum]['championName'],
                'championId': participant_list[userNum]['championId'],
                'champ_level': participant_list[userNum]['champLevel'],
                'champExperience': participant_list[userNum]['champExperience'],
                'win': participant_list[userNum]['win'],
                'total_damage_dealt': participant_list[userNum]['totalDamageDealt'],
                'totalDamageDealtToChampions': participant_list[userNum]['totalDamageDealtToChampions'],
                'damageDealtToObjectives': participant_list[userNum]['damageDealtToObjectives'],
                'totalDamageTaken': participant_list[userNum]['totalDamageTaken'],
                'inhibitorKills': participant_list[userNum]['inhibitorKills'],
                'teamPosition': participant_list[userNum]['teamPosition'],
                'teamId': participant_list[userNum]['teamId'],
                'profileIcon': participant_list[userNum]['profileIcon'],
                'puuid': participant_list[userNum]['puuid'],
                'summonerName': participant_list[userNum]['summonerName'],
                'summonerId': participant_list[userNum]['summonerId'],
                'summonerLevel': participant_list[userNum]['summonerLevel'],
                'soloKills': participant_list[userNum]['challenges']['soloKills'],
                'doubleKills': participant_list[userNum]['doubleKills'],
                'tripleKills': participant_list[userNum]['tripleKills'],
                'quadraKills': participant_list[userNum]['quadraKills'],
                'pentaKills': participant_list[userNum]['pentaKills'],
                'red_ward_placed': participant_list[userNum]['detectorWardsPlaced'],
                'sight_point': participant_list[userNum]['visionScore'],
                'total_gold': participant_list[userNum]['goldEarned'],
                'timeCCingOthers': participant_list[userNum]['timeCCingOthers']
            }

            matches['participants'].append(participant_dict)

        ban_list = []
        for team in team_list:
            for ban in team['bans']:
                ban_list.append(ban['championId'])

        matches['bans'] = ban_list

        if userNum < 4:
            team_idx = 0
        else:
            team_idx = 1

        objectives = [{'baron': match_info['teams'][team_idx]['objectives']['baron']},
                      {'dragon': match_info['teams'][team_idx]['objectives']['dragon']},
                      {'riftHerald': match_info['teams'][team_idx]['objectives']['riftHerald']}]
        matches['objectives'] = objectives

        return matches

    def time_line_data(df):
        time_line = {}
        for i, frame in enumerate(df['timeline']['info']['frames']):
            result = {'events': [], 'participantFrames': []}
            events = []
            for event in frame['events']:
                if event['type'] == 'SKILL_LEVEL_UP' or event['type'] == 'ITEM_PURCHASED' \
                        or event['type'] == 'BUILDING_KILL':
                    events.append(event)
            result['events'].extend(events)
            try:
                for participant in range(len(frame['participantFrames'])):
                    participant_dict = {
                        'participantId': frame['participantFrames'][f'{participant + 1}']['participantId'],
                        'level': frame['participantFrames'][f'{participant + 1}']['level'],
                        'totalGold': frame['participantFrames'][f'{participant + 1}']['totalGold'],
                        'minionsKilled': frame['participantFrames'][f'{participant + 1}']['minionsKilled'],
                        'jungleMinionsKilled': frame['participantFrames'][f'{participant + 1}']['jungleMinionsKilled'],
                    }
                    result['participantFrames'].append(participant_dict)
                time_line[i] = result
            except TypeError:
                print(f'{frame}')
        return time_line

    api_key = df['api_key']
    match_id = df['matches']['metadata']['matchId']
    matches = matches_data(df)
    time_line = time_line_data(df)

    columns = ['api_key', 'match_id', 'matches', 'time_line']
    refine_df = pd.DataFrame([[api_key, match_id, matches, time_line]], columns=columns)
    return refine_df

# insert  ######### insert 수정 #########
def insert(t, conn_):
    try:
        matches_json, timeline_json = conn_.escape_string(json.dumps(t.matches)), conn_.escape_string(json.dumps(t.time_line))
        sql_insert = (
            f"insert ignore into match_raw (api_key, match_id, matches, timeline) values ({repr(t.api_key)},"
            f" {repr(t.match_id)}, '{matches_json}', '{timeline_json}')"
        )
        mu.mysql_execute(sql_insert, conn_)
    except Exception as e:
        logging.exception(f"Error occurred during insert: {e}, {t.match_id}")
# insert 끝
def main():
    match_ids = load_summoner_names_worker()
    print('load_summoner_names  **get_match_info**', len(match_ids))
    match_info_output = []
    with mp.Pool(processes=8) as pool:
        chunk_size = len(match_ids)
        chunks = [match_ids[i:i + chunk_size // 8] for i in range(0, len(match_ids), chunk_size // 8)]
        for i, res in enumerate(tqdm(pool.imap(get_match_info_worker, zip(chunks, range(8))), total=len(chunks))):
            match_info_output.append(res)

    merged_df = pd.concat(match_info_output)
    print("merged_df =", len(merged_df))

    refine_df = pd.concat([df_refine(row) for _, row in merged_df.iterrows()], ignore_index=True)
    sql_conn = mu.connect_mysql()
    refine_df.progress_apply(lambda x: insert(x, sql_conn), axis=1)
    sql_conn.commit()
    sql_conn.close()
    print('done')

if __name__ == '__main__':
    for _ in tqdm(range(24)):
        try:
            main()
        except Exception as e:
            logging.exception(f'error {e}')
            continue
        print('sleep 20')
        time.sleep(20)