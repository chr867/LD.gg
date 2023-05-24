import json

import pandas as pd
from tqdm import tqdm

import data_load
import my_utils as mu
tqdm.pandas()

print("시작!")
conn = mu.connect_mysql()
matchId_count = pd.DataFrame(mu.mysql_execute_dict(f"SELECT match_id_substr FROM match_raw_patch", conn))
conn.close()
print(f'매치아이디 갯수 : {len(matchId_count.match_id_substr.unique())}개')

batch_size = 20000
win_pick_lst_result = []
ban_rate_lst_result = []
meta_score_lst_result = []
# len(matchId_count.match_id_substr.unique())
for limit in tqdm(range(0, len(matchId_count.match_id_substr.unique()), batch_size)):
    conn = mu.connect_mysql()
    query = f"SELECT * FROM match_raw_patch LIMIT {limit}, {batch_size}"
    df = pd.DataFrame(mu.mysql_execute_dict(query, conn))

    df['matches'] = df.progress_apply(lambda x: json.loads(x['matches']), axis=1)
    df['timeline'] = df.progress_apply(lambda x: json.loads(x['timeline']), axis=1)

    record_df_creater = []
    columns = [
        'match_id', 'summoner_name','game_duration', 'game_mode', 'champ_name', 'champ_level', 'team_id', 'win', 'kills',
        'deaths', 'assists', 'kda', 'cs', 'main_rune', 'main_rune1', 'main_rune2', 'main_rune3', 'main_rune4', 'sub_rune',
        'sub_rune1', 'sub_rune2', 'rune_stat1', 'rune_stat2', 'rune_stat3', 'item1', 'item2', 'item3', 'item4', 'item5',
        'item6', 'item7', 'red_ward_placed', 'total_damage_dealt', 'dealt_to_champ', 'damage_taken', 'lane', 'spell1',
        'spell2', 'team_baron_kills', 'team_champion_kills', 'team_champion_deaths', 'team_dragon_kills', 'team_tower_kills',
        'sight_point'
    ]
    for idx, i in tqdm(enumerate(df['matches'])):
        for p_idx, p in enumerate(i['participants']):
            if p_idx <= 4:
                versus_index = 6
                deaths = i['participants'][versus_index]['objectives'][0]['champion']['kills']
            else:
                versus_index = 0
                deaths = i['participants'][versus_index]['objectives'][0]['champion']['kills']

            obj = p['objectives'][0]
            row = df.iloc[idx]

            record_df_creater.append([
                row['match_id'],
                p['summonerName'],
                i['gameDuration'],
                i['gameMode'],
                p['championName'],
                p['champ_level'],
                p['teamId'],
                p['win'],
                p['kills'],
                p['deaths'],
                p['assists'],
                p['kda'],
                # cs
                (row['timeline'][str(len(row['timeline']) - 1)]['participantFrames'][p_idx]['minionsKilled'] +
                row['timeline'][str(len(row['timeline']) - 1)]['participantFrames'][p_idx]['jungleMinionsKilled']),
                p['style0'],
                p['perks0'][0],
                p['perks0'][1],
                p['perks0'][2],
                p['perks0'][3],
                p['style1'],
                p['perks1'][0],
                p['perks1'][1],
                # rune_stat1
                p['offense'],
                # rune_stat2
                p['flex'],
                # rune_stat3
                p['defense'],
                p['item0'],
                p['item1'],
                p['item2'],
                p['item3'],
                p['item4'],
                p['item5'],
                p['item6'],
                p['red_ward_placed'],
                p['total_damage_dealt'],
                p['totalDamageDealtToChampions'],
                p['totalDamageTaken'],
                p['teamPosition'],
                p['summoner1Id'],
                p['summoner2Id'],
                obj['baron']['kills'],
                obj['champion']['kills'],
                deaths,
                obj['dragon']['kills'],
                obj['tower']['kills'],
                p['sight_point']
            ])

    record_df = pd.DataFrame.from_records(record_df_creater, columns=columns)

    def insert(t, conn):
        sql = (
            f'insert ignore into record (match_id, summoner_name, game_duration, game_mode, champ_name, champ_level,'
            f'team_id, win, kills, deaths, assists, kda, cs, main_rune, main_rune1, main_rune2, main_rune3, main_rune4,'
            f'sub_rune, sub_rune1, sub_rune2, rune_stat1, rune_stat2, rune_stat3, item1, item2, item3, item4, item5, item6,'
            f'item7, red_ward_placed, total_damage_dealt, dealt_to_champ, damage_taken, lane, spell1, spell2, team_baron_kills,'
            f'team_champion_kills, team_champion_deaths, team_dragon_kills, team_tower_kills, sight_point) '
            f'values ({repr(t.match_id)}, {repr(t.summoner_name)}, {t.game_duration}, {repr(t.game_mode)}, {repr(t.champ_name)},'
            f'{t.champ_level}, {t.team_id}, {t.win}, {t.kills}, {t.deaths}, {t.assists}, {t.kda}, {t.cs}, {t.main_rune}, '
            f'{t.main_rune1}, {t.main_rune2}, {t.main_rune3}, {t.main_rune4}, {t.sub_rune}, {t.sub_rune1}, {t.sub_rune2}, '
            f'{t.rune_stat1}, {t.rune_stat2}, {t.rune_stat3}, {t.item1}, {t.item2}, {t.item3}, {t.item4}, '
            f'{t.item5}, {t.item6}, {t.item7}, {t.red_ward_placed}, {t.total_damage_dealt}, {t.dealt_to_champ}, {t.damage_taken}, '
            f'{repr(t.lane)}, {t.spell1}, {t.spell2}, {t.team_baron_kills}, {t.team_champion_kills}, {t.team_champion_deaths},'
            f' {t.team_dragon_kills}, {t.team_tower_kills}, {t.sight_point})'
        )
        mu.mysql_execute(sql, conn)

    sql_conn = mu.connect_mysql()
    record_df.progress_apply(lambda x: insert(x, sql_conn), axis=1)
    sql_conn.commit()
    sql_conn.close()

