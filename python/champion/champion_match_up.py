# --------------------------------------------------------
# Package
import bs4
import pandas as pd
import requests
import cx_Oracle
import pymysql
from requests import request
from tqdm import tqdm
import my_utils as mu
import json
import time
import numpy as np
tqdm.pandas()


# ----------------------------------------------------------------------------------------------------------------------
# RawData
def fetch_data_from_match_raw(limit):
    conn = mu.connect_mysql()
    query = f"select * from match_raw limit {limit}"

    start_time = time.time()
    data = mu.mysql_execute_dict(query, conn)
    end_time = time.time()
    execution_time = end_time - start_time
    print(f"Execution time: {execution_time} seconds")

    df = pd.DataFrame(data)
    conn.close()

    return df
# ----------------------------------------------------------------------------------------------------------------------
df = fetch_data_from_match_raw(1000)
df['matches'] = df['matches'].progress_apply(lambda x: json.loads(x))
df['timeline'] = df['timeline'].progress_apply(lambda x: json.loads(x))

df_creater = []
columns = [
    'api_key', 'match_id', 'gameDuration', 'gameVersion', 'summonerName', 'summonerId', 'summonerLevel',
    'participantId', 'championName', 'championId', 'ban_champion_id', 'champExperience', 'teamPosition',
    'teamId', 'win', 'kills', 'deaths', 'assists', 'towerDestroy', 'inhibitorDestroy', 'dealToObject',
    'dealToChamp', 'cs', 'g_5', 'g_6', 'g_7', 'g_8', 'g_9', 'g_10', 'g_11', 'g_12', 'g_13', 'g_14', 'g_15',
    'g_16', 'g_17', 'g_18', 'g_19', 'g_20', 'g_21', 'g_22', 'g_23', 'g_24', 'g_25'
]

for m_idx, m in tqdm(enumerate(df['matches'])):
    if m['gameDuration'] < 900:
        continue

    tower_destroy = 0
    bans = 0

    for p_idx, p in enumerate(m['participants']):
        game_end = list(df.iloc[m_idx]['timeline'].keys())[-1]
        participant_frames = df.iloc[m_idx]['timeline'][game_end]['participantFrames']

        minions_killed = participant_frames[p_idx]['minionsKilled']
        jungle_minions_killed = participant_frames[p_idx]['jungleMinionsKilled']
        cs = minions_killed + jungle_minions_killed

        event_lst = [event for events in df.iloc[m_idx]['timeline'].values() for event in events['events']]
        tower_destroy = sum(1 for event in event_lst if event['type'] == 'BUILDING_KILL' and event['killerId'] == p_idx)

        team = 0 if p['teamId'] == 100 else 1

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
            m['bans'][p_idx],
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

        for t in range(5, 26):
            try:
                g_each = df.iloc[m_idx]['timeline'][str(t)]['participantFrames'][p_idx]['totalGold']
                df_creater[-1].append(g_each)
            except Exception as e:
                df_creater[-1].append(0)

        bans += 1

sum_df = pd.DataFrame(df_creater, columns=columns)



# ----------------------------------------------------------------
#match_up

sample = sum_df[['match_id','championName','championId','win','teamPosition','g_15','teamId','kills','deaths','assists','dealToChamp','towerDestroy','cs','ban_champion_id']]

# win 컬럼 boolean에서 int로 변경
sample['win'] =sample.apply(lambda x:  1 if x.win ==True else 0 , axis = 1)

sample.rename(columns={'championName': 'champion_name','championId': 'champion_id','teamPosition': 'team_position','teamId': 'team_id','dealToChamp': 'deal_to_champ','towerDestroy': 'tower_destroy'}, inplace=True)

# 각 팀 킬 수 합쳐서 team_kills 컬럼에 추가
sample['team_kills'] = sample.groupby(['match_id', 'team_id'])['kills'].transform('sum')

#팀별로 테이블 분리
blue = sample[sample['team_id'] == 100]
red =sample[sample['team_id']==200]

#팀별 컬럼 리네임
blue_tmp = blue[['match_id','champion_name','champion_id','team_position','g_15','kills','deaths','assists','team_kills']].rename(columns={'champion_name':'enemy_champ','champion_id':'enemy_champ_id','g_15':'enemy_g_15','kills':'enemy_kills', 'deaths':'enemy_deaths', 'assists':'enemy_assists', 'team_kills':'enemy_team_kills'})
red_tmp = red[['match_id','champion_name','champion_id','team_position','g_15','kills','deaths','assists','team_kills']].rename(columns={'champion_name':'enemy_champ','champion_id':'enemy_champ_id','g_15':'enemy_g_15','kills':'enemy_kills', 'deaths':'enemy_deaths', 'assists':'enemy_assists', 'team_kills':'enemy_team_kills'})

#분리한 팀별 테이블 merge해서 비교
blue_merge = pd.merge(blue,red_tmp, on=['match_id','team_position'])
red_merge = pd.merge(red,blue_tmp, on=['match_id','team_position'])

# append를 통해서 다시 하나의 테이블로
result = blue_merge.append(red_merge)

# 인덱스 재설정
result = result.reset_index(drop=True)

# 게임아이디랑 팀 아이디 별로 정렬
result = result.sort_values(by=['match_id','team_id'])

win_df = result.copy()

# 팀포지션컬럼을 라인으로 리네임
win_df.rename(columns={'team_position': 'lane'},inplace=True)

# 챔피언 이름 , 라인, 적 챔피언 순으로 그룹화 해서 라인승리 누적횟수와 게임승리 누적횟수를 보여줌
cnt_df = win_df.groupby(['champion_name','champion_id','lane','enemy_champ','enemy_champ_id'])[['win','g_15','kills','deaths','assists','deal_to_champ','tower_destroy','cs','team_kills','enemy_kills','enemy_deaths','enemy_assists','enemy_team_kills']].sum().rename(columns={'win':'win_cnt'})

# 전체 게임수를 카운트해서 match_up_cnt 컬럼의 값으로 넣음
game_df = win_df.groupby(['champion_name','champion_id','lane','enemy_champ','enemy_champ_id'])[['win']].count().rename(columns={'win':'match_up_cnt'})

#merge를 통해 전체 게임수와 누적 승리를 보여줌
result_df = pd.merge(cnt_df,game_df,on=['champion_name','champion_id','lane','enemy_champ','enemy_champ_id'])

# 게임수가 많은 순으로 정렬
r_df = result_df.sort_values('match_up_cnt',ascending=False)

# 승률
r_df['win_rate']=round((r_df['win_cnt']/r_df['match_up_cnt'])*100,2)
#kda
r_df['kda']=round((r_df['kills']+r_df['assists'])/r_df['deaths'],2)
#라인킬 확률
r_df['lane_kill_rate'] = round((r_df['kills']/r_df['deaths'])/((r_df['kills']/r_df['deaths'])+(r_df['enemy_kills']/r_df['enemy_deaths']))*100,2)
#킬관여율
r_df['kill_participation'] = round(( ((r_df['kills']+r_df['assists'])/r_df['team_kills']) /(((r_df['kills']+r_df['assists'])/r_df['team_kills']) + ((r_df['enemy_kills']+r_df['enemy_assists'])/r_df['team_kills']))  )*100,2)
#챔피언에게 가한 피해량
r_df['deal_to_champ'] = round(r_df['deal_to_champ']/r_df['match_up_cnt'])
#15분대의 골드 획득량
r_df['avg_g_15'] = round(r_df['g_15']/r_df['match_up_cnt'])
#평균 타워 파괴 횟수
r_df['avg_tower_kill'] = round(r_df['tower_destroy']/r_df['match_up_cnt'],1)
#평균 cs
r_df['avg_cs'] = round(r_df['cs']/r_df['match_up_cnt'])

r_df_o = r_df[['lane_kill_rate','kda','kill_participation','deal_to_champ','avg_g_15','avg_tower_kill','avg_cs','win_rate','win_cnt','match_up_cnt']]

#인덱스 리셋
match_up =r_df_o.reset_index()

print(len(r_df))

match_up.rename(columns={'win_rate': 'match_up_win_rate','win_cnt': 'match_up_win_cnt'}, inplace=True)
# nan , inf 값 제거
match_up = match_up.dropna()

# multi-level index로 설정된 경우
match_up.loc[r_df_o.index.get_level_values('champion_name') == 'Yorick']

#  ---------------------------------------------------------------------------------------------------------------------
# db에 데이터 삽입
def insert_my(x,conn):
    query = (
        f'insert into champion_match_up (champion_name, champion_id, lane, enemy_champ, enemy_champ_id, lane_kill_rate, kda, kill_participation, deal_to_champ, avg_g_15, avg_tower_kill, avg_cs, match_up_win_rate, match_up_win_cnt, match_up_cnt)'
        f'values({repr(x.champion_name)},{x.champion_id},{repr(x.lane)},{repr(x.enemy_champ)},{x.enemy_champ_id},{x.lane_kill_rate},{x.kda},{x.kill_participation},{x.deal_to_champ},{x.avg_g_15},{x.avg_tower_kill},{x.avg_cs},{x.match_up_win_rate},{x.match_up_win_cnt},{x.match_up_cnt})'
    )
    query2 = (
        f'INSERT INTO champion_match_up '
        f'(champion_name, champion_id, lane, enemy_champ, enemy_champ_id, lane_kill_rate, kda, kill_participation, deal_to_champ, avg_g_15, avg_tower_kill, avg_cs, match_up_win_rate, match_up_win_cnt, match_up_cnt) '
        f'VALUES ({repr(x.champion_name)}, {x.champion_id}, {repr(x.lane)}, {repr(x.enemy_champ)}, {x.enemy_champ_id}, {x.lane_kill_rate}, {x.kda}, {x.kill_participation}, {x.deal_to_champ}, {x.avg_g_15}, {x.avg_tower_kill}, {x.avg_cs}, {x.match_up_win_rate}, {x.match_up_win_cnt}, {x.match_up_cnt}) '
        f'ON DUPLICATE KEY UPDATE '
        f'champion_id = VALUES(champion_id), lane = VALUES(lane), enemy_champ = VALUES(enemy_champ), enemy_champ_id = VALUES(enemy_champ_id), '
        f'lane_kill_rate = VALUES(lane_kill_rate), kda = VALUES(kda), kill_participation = VALUES(kill_participation), deal_to_champ = VALUES(deal_to_champ), '
        f'avg_g_15 = VALUES(avg_g_15), avg_tower_kill = VALUES(avg_tower_kill), avg_cs = VALUES(avg_cs), '
        f'match_up_win_rate = VALUES(match_up_win_rate), match_up_win_cnt = VALUES(match_up_win_cnt), match_up_cnt = VALUES(match_up_cnt)'
    )
    try:
        mu.mysql_execute(query2,conn)
    except Exception as e:
        # 중복된 레코드인 경우, 해당 레코드 출력
        print(f"Duplicated record: {x}")
    return

conn = mu.connect_mysql()
match_up.progress_apply(lambda x: insert_my(x,conn),axis =1)
conn.commit()
conn.close()

# ---------------------------------------------------------------------------------------------------------------------
df = fetch_data_from_match_raw(1000)
df['matches'] = df['matches'].progress_apply(lambda x: json.loads(x))
df['timeline'] = df['timeline'].progress_apply(lambda x: json.loads(x))
# ---------------------------------------------------------------------------------------------------------------------
# match_up_spell
# 스펠 데이터

df.iloc[0]['match_id']['participants']

result = []
print("스펠 데이터 정제 시작 ")
for i in tqdm(range(len(df))):
    participants = df.iloc[i]['matches']['participants']
    for summoner in range(len(participants)):
        lst = [
            df.iloc[i]['match_id'],
            participants[summoner]['championId'],
            participants[summoner]['teamPosition'],
            participants[summoner]['summoner1Id'],
            participants[summoner]['summoner2Id'],
            participants[summoner]['win']
        ]
        result.append(lst)
columns = ['champion_id','teamPosition', 'spell_1', 'spell_2', 'win']

spell_df = pd.DataFrame(result, columns=columns)

spell_df['win'] = spell_df['win'].astype(int)

def combine_spells(df):
    df['spell_1'], df['spell_2'] = np.sort(df[['spell_1', 'spell_2']], axis=1).T # 중복제거
    return df.groupby(['champion_id','teamPosition', 'spell_1', 'spell_2'])['win'].agg(['sum','count']).reset_index() #승리수 와 게임수 계산

top3_spells = (
    combine_spells(spell_df)
    .sort_values(['champion_id', 'sum', 'count'], ascending=[True, False, False])
    .groupby('champion_id')
    .head(2)
    .rename(columns={'count': 'pick_cnt', 'teamPosition': 'lane', 'sum': 'win_cnt', 'spell_1': 'd_spell', 'spell_2': 'f_spell'})
)

top3_spells['win_rate'] = round((top3_spells['win_cnt'] / top3_spells['pick_cnt']) * 100, 2) #승률 계산

total_game_df = spell_df.groupby(['champion_id']).agg({'win': ['count']}) # 해당 챔피언이 등장한 게임수
total_game_df.columns = ['total_game']
total_game_df.reset_index(inplace=True)
merged_df = pd.merge(top3_spells, total_game_df, on='champion_id')
merged_df['pick_rate'] = round((merged_df['pick_cnt'] / merged_df['total_game']) * 100, 2)
final_df = merged_df.drop(columns=['total_game'])
print("스펠 데이터 정제 완료 ")

spell_data = spell_data(df)