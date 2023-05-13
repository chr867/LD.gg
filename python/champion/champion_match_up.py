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
    query = f"SELECT * FROM match_raw LIMIT {limit}"

    start_time = time.time()

    # 데이터를 가져올 때 tqdm 적용
    with tqdm(total=limit) as pbar:
        data = []
        for row in tqdm(mu.mysql_execute_dict(query, conn)):
            data.append(row)
            pbar.update(1)

    end_time = time.time()
    execution_time = end_time - start_time
    print(f"Execution time: {execution_time} seconds")

    df = pd.DataFrame(data)
    conn.close()
    df['matches'] = df['matches'].progress_apply(lambda x: json.loads(x))
    df['timeline'] = df['timeline'].progress_apply(lambda x: json.loads(x))
    return df
# ----------------------------------------------------------------------------------------------------------------------
def fetch_all_data_from_match_raw():
    conn = mu.connect_mysql()
    query = "SELECT * FROM match_raw"

    start_time = time.time()

    # 데이터를 가져올 때 tqdm 적용
    data = []
    with tqdm() as pbar:
        for row in mu.mysql_execute_dict(query, conn):
            data.append(row)
            pbar.update(1)

    end_time = time.time()
    execution_time = end_time - start_time
    print(f"Execution time: {execution_time} seconds")

    df = pd.DataFrame(data)
    conn.close()
    df['matches'] = df['matches'].progress_apply(lambda x: json.loads(x))
    df['timeline'] = df['timeline'].progress_apply(lambda x: json.loads(x))
    return df
# ----------------------------------------------------------------------------------------------------------------------
df = fetch_data_from_match_raw(1000)
# ----------------------------------------------------------------------------------------------------------------------
# 매치업 데이터 정제
df_creater = []
columns = [
    'match_id', 'game_duration', 'game_version',
    'participant_id', 'champion_name', 'champion_id', 'ban_champion_id', 'team_position',
    'team_id', 'win', 'kills', 'deaths', 'assists', 'tower_destroy',
    'deal_to_champ', 'cs', 'spell_1', 'spell_2', 'g_15', 'FRAGMENT1_ID', 'FRAGMENT2_ID',
    'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID', 'MAIN_SUB2_ID',
    'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID'
]
def lane_processing(tower_lane, tower_team, teamPosition, teamId):
    if (tower_lane[0] == teamPosition[0]) and (tower_team != teamId):
        return True
    else:
        return False

for m_idx, m in tqdm(enumerate(df['matches'])):
    if m['gameDuration'] < 900:  # 15분 미만 게임 제거
        continue
    if any(p['teamPosition'] == '' for p in m['participants']):  # 팀포지션이 없는 소환사가 있는 게임 제거
        print('팀포지션이 공백인 데이터가 있는 게임', df.iloc[m_idx]['match_id'])
        continue
    else:
        for p_idx, p in enumerate(m['participants']):
            game_end = list(df.iloc[m_idx]['timeline'].keys())[-1]
            participant_frames = df.iloc[m_idx]['timeline'][game_end]['participantFrames']

            minions_killed = participant_frames[p_idx]['minionsKilled']
            jungle_minions_killed = participant_frames[p_idx]['jungleMinionsKilled']
            cs = minions_killed + jungle_minions_killed

            timeline_data = df.iloc[m_idx]['timeline'].values()
            all_events = [event for events in timeline_data for event in events['events']]
            building_kill_events = [event for event in all_events if
                                    event['type'] == 'BUILDING_KILL' and event.get('towerType') == 'OUTER_TURRET']
            tower_destroy = 0
            try:
                for t_log in building_kill_events:
                    lane = t_log['laneType']
                    team_num = t_log['teamId']
                    if lane_processing(lane, team_num, p['teamPosition'], p['teamId']):
                        tower_destroy = round(t_log['timestamp'] / 1000)
            except Exception as e:
                print(e, lane, type(p['teamPosition']), p['teamPosition'])

            team = 0 if p['teamId'] == 100 else 1

            df_creater.append([
                df.iloc[m_idx]['match_id'],
                m['gameDuration'],
                m['gameVersion'],
                p['participantId'],
                p['championName'],
                p['championId'],
                m['bans'][p_idx],
                p['teamPosition'],
                p['teamId'],
                p['win'],
                p['kills'],
                p['deaths'],
                p['assists'],
                tower_destroy,
                p['totalDamageDealtToChampions'],
                cs,
                p['summoner1Id'],  # 스펠1
                p['summoner2Id'],  # 스펠2
                df.iloc[m_idx]['timeline']['15']['participantFrames'][p_idx]['totalGold']
            ])
            # 룬 데이터
            df_creater[-1].append(p['defense']) # 룬파편1
            df_creater[-1].append(p['flex']) # 룬파편2
            df_creater[-1].append(p['offense']) # 룬파편3
            df_creater[-1].append(p['style0']) # 핵심 룬 빌드
            for primaryRune in p['perks0']: # 핵심 룬 1, 일반 룬 3
                df_creater[-1].append(primaryRune)
            df_creater[-1].append(p['style1']) # 보조 룬 빌드
            for subStyleRune in p['perks1']: # 일반 룬 2
                df_creater[-1].append(subStyleRune)

sum_df = pd.DataFrame(df_creater, columns=columns)
sum_df['win'] = sum_df['win'].astype(int)
#  ---------------------------------------------------------------------------------------------------------------------
#포지션 별 승률 픽률,밴률 데이터 프레임 정제용
sample2 = sum_df[['match_id','champion_id','win','team_position','ban_champion_id']]
# 포지션 별 승률 픽률 계산
sample3 = sample2.groupby(['champion_id','team_position'])['win'].agg(['sum','count']).reset_index().rename(columns={'sum':'win_cnt','count':'pick_cnt'})
sample3['win_rate'] = round((sample3['win_cnt']/sample3['pick_cnt'])*100,2)
sample3['lane_cnt'] = sample3.groupby(['team_position'])[['pick_cnt']].transform('sum')
sample3['pick_rate'] = round((sample3['pick_cnt']/sample3['lane_cnt'])*100,2)
win_pick_sample = sample3.sort_values(by=['pick_cnt', 'win_rate'], ascending=False).reset_index(drop=True).drop('lane_cnt', axis=1)
# 챔피언 별 밴률 계산
ban_sample = sample2[['ban_champion_id','team_position','win']].rename(columns={'ban_champion_id':'champion_id'})
ban_sample = ban_sample.groupby(['champion_id','team_position'])['win'].agg(['count']).reset_index().rename(columns={'count':'ban_pick_cnt'})
ban_sample = ban_sample[ban_sample['champion_id'] != -1]
ban_sample = ban_sample.sort_values(by='ban_pick_cnt', ascending=False).reset_index(drop=True)
ban_sample['lane_cnt'] = ban_sample.groupby(['team_position'])[['ban_pick_cnt']].transform('sum')
ban_sample['ban_rate'] = (ban_sample['ban_pick_cnt']/ban_sample['lane_cnt'])*100
ban_sample = ban_sample.groupby(['champion_id'])[['ban_pick_cnt','ban_rate']].sum().sort_values(by='ban_rate', ascending=False).reset_index()
ban_sample['ban_rate'] = round(ban_sample['ban_rate'],2)
# 머지
wpb_sample = pd.merge(win_pick_sample,ban_sample, on=['champion_id'])
wpb_sample = wpb_sample.sort_values(by=['pick_rate','win_rate','ban_rate'], ascending=False).reset_index(drop=True)
#  ---------------------------------------------------------------------------------------------------------------------
#match_up 2차 정제

sample = sum_df[['match_id','champion_name','champion_id','win','team_position','g_15'
                 ,'team_id','kills','deaths','assists','deal_to_champ','tower_destroy'
                 ,'cs','ban_champion_id','spell_1','spell_2', 'FRAGMENT1_ID', 'FRAGMENT2_ID',
    'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID','MAIN_SUB2_ID',
    'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID']]
# 각 팀 킬 수 합쳐서 team_kills 컬럼에 추가
sample['team_kills'] = sample.groupby(['match_id', 'team_id'])['kills'].transform('sum')
#팀별로 테이블 분리
blue = sample[sample['team_id'] == 100]
red = sample[sample['team_id'] == 200]
#팀별 컬럼 리네임
blue_tmp = blue[['match_id','champion_name','champion_id','team_position','g_15','kills','deaths','assists','team_kills']].rename(columns={'champion_name':'enemy_champ','champion_id':'enemy_champ_id','g_15':'enemy_g_15','kills':'enemy_kills', 'deaths':'enemy_deaths', 'assists':'enemy_assists', 'team_kills':'enemy_team_kills'})
red_tmp = red[['match_id','champion_name','champion_id','team_position','g_15','kills','deaths','assists','team_kills']].rename(columns={'champion_name':'enemy_champ','champion_id':'enemy_champ_id','g_15':'enemy_g_15','kills':'enemy_kills', 'deaths':'enemy_deaths', 'assists':'enemy_assists', 'team_kills':'enemy_team_kills'})
#분리한 팀별 테이블 merge해서 비교
blue_merge = pd.merge(blue,red_tmp, on=['match_id','team_position'])
red_merge = pd.merge(red,blue_tmp, on=['match_id','team_position'])
# append를 통해서 다시 하나의 테이블로
result = blue_merge.append(red_merge)
# 게임아이디랑 팀 아이디 별로 정렬 후 인덱스 재설정
result = result.sort_values(by=['match_id','team_id']).reset_index(drop=True)
#  ---------------------------------------------------------------------------------------------------------------------
# 매치업 기본 통계
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
#라인 첫 포탑 파괴 시간
r_df['tower_kill_time'] = round(r_df['tower_destroy']/r_df['match_up_cnt'])
#평균 cs
r_df['avg_cs'] = round(r_df['cs']/r_df['match_up_cnt'])
match_up = r_df[['lane_kill_rate','kda','kill_participation','deal_to_champ','avg_g_15','tower_kill_time','avg_cs','win_rate','win_cnt','match_up_cnt']]
#인덱스 리셋
match_up =match_up.reset_index()
match_up.rename(columns={'win_rate': 'match_up_win_rate','win_cnt': 'match_up_win_cnt'}, inplace=True)
# nan , inf 값 제거
match_up = match_up.dropna()
#  ---------------------------------------------------------------------------------------------------------------------
# db에 데이터 삽입
def insert_my(x,conn):
    query = (
        f'insert into champion_match_up (champion_name, champion_id, lane, enemy_champ, enemy_champ_id, lane_kill_rate, kda, kill_participation, deal_to_champ, avg_g_15, tower_kill_time, avg_cs, match_up_win_rate, match_up_win_cnt, match_up_cnt)'
        f'values({repr(x.champion_name)},{x.champion_id},{repr(x.lane)},{repr(x.enemy_champ)},{x.enemy_champ_id},{x.lane_kill_rate},{x.kda},{x.kill_participation},{x.deal_to_champ},{x.avg_g_15},{x.tower_kill_time},{x.avg_cs},{x.match_up_win_rate},{x.match_up_win_cnt},{x.match_up_cnt})'
    )
    query2 = (
        f'INSERT INTO champion_match_up '
        f'(champion_name, champion_id, lane, enemy_champ, enemy_champ_id, lane_kill_rate, kda, kill_participation, deal_to_champ, avg_g_15, tower_kill_time, avg_cs, match_up_win_rate, match_up_win_cnt, match_up_cnt) '
        f'VALUES ({repr(x.champion_name)}, {x.champion_id}, {repr(x.lane)}, {repr(x.enemy_champ)}, {x.enemy_champ_id}, {x.lane_kill_rate}, {x.kda}, {x.kill_participation}, {x.deal_to_champ}, {x.avg_g_15}, {x.tower_kill_time}, {x.avg_cs}, {x.match_up_win_rate}, {x.match_up_win_cnt}, {x.match_up_cnt}) '
        f'ON DUPLICATE KEY UPDATE '
        f'champion_id = VALUES(champion_id), lane = VALUES(lane), enemy_champ = VALUES(enemy_champ), enemy_champ_id = VALUES(enemy_champ_id), '
        f'lane_kill_rate = VALUES(lane_kill_rate), kda = VALUES(kda), kill_participation = VALUES(kill_participation), deal_to_champ = VALUES(deal_to_champ), '
        f'avg_g_15 = VALUES(avg_g_15), tower_kill_time = VALUES(tower_kill_time), avg_cs = VALUES(avg_cs), '
        f'match_up_win_rate = VALUES(match_up_win_rate), match_up_win_cnt = VALUES(match_up_win_cnt), match_up_cnt = VALUES(match_up_cnt)'
    )
    try:
        mu.mysql_execute(query2,conn)
    except Exception as e:
        print(e)
    return

conn = mu.connect_mysql()
match_up.progress_apply(lambda x: insert_my(x,conn),axis =1)
conn.commit()
conn.close()
# ----------------------------------------------------------------------------------------------------------------------
# match_up_spell
# 매치업 스펠 데이터

spell_df = result[['champion_id','team_position','enemy_champ_id', 'spell_1', 'spell_2', 'win']].copy()

def sort_spells(df):
    df['spell_1'], df['spell_2'] = np.sort(df[['spell_1', 'spell_2']], axis=1).T # 스펠 순서 정렬을 통해 중복 방지
    return df.groupby(['champion_id','team_position','enemy_champ_id', 'spell_1', 'spell_2'])['win'].agg(['sum','count']).reset_index() #승리수 와 게임수 계산

spells = sort_spells(spell_df).rename(columns={'count': 'pick_cnt', 'teamPosition': 'lane', 'sum': 'win_cnt', 'spell_1': 'd_spell', 'spell_2': 'f_spell'})
spells['game_cnt'] = spells.groupby(['champion_id','team_position','enemy_champ_id'])[['pick_cnt']].transform('sum')
spells = spells.sort_values(['champion_id','game_cnt', 'pick_cnt','win_cnt'], ascending=[True,False,False,False])
top2_spells = spells.groupby(['champion_id','team_position','enemy_champ_id']).head(2).reset_index(drop=True)
top2_spells['win_rate'] = round((top2_spells['win_cnt'] / top2_spells['pick_cnt']) * 100, 2) #승률 계산
top2_spells['pick_rate'] = round((top2_spells['pick_cnt'] / top2_spells['game_cnt']) * 100, 2) #픽률 계산
match_up_spell = top2_spells
print("스펠 데이터 정제 완료 ")

# ----------------------------------------------------------------------------------------------------------------------
# match_up_runes
# 매치업 룬데이터
rune_df = result[['champion_id','team_position','enemy_champ_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID',
    'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID','MAIN_SUB2_ID',
    'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID','win']].copy()

rune_df = rune_df.groupby(['champion_id','team_position','enemy_champ_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID',
    'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID','MAIN_SUB2_ID',
    'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID'])['win'].agg(['sum','count']).rename(columns={'count': 'pick_cnt', 'teamPosition': 'lane', 'sum': 'win_cnt'}).reset_index()

rune_df['game_cnt'] = rune_df.groupby(['champion_id','team_position','enemy_champ_id'])[['pick_cnt']].transform('sum')
rune_df = rune_df.sort_values(['champion_id','game_cnt', 'pick_cnt','win_cnt'], ascending=[True,False,False,False])
top2_runes = rune_df.groupby(['champion_id','team_position','enemy_champ_id']).head(2).reset_index(drop=True)
top2_runes['win_rate'] = round((top2_runes['win_cnt'] / top2_runes['pick_cnt']) * 100, 2) #승률 계산
top2_runes['pick_rate'] = round((top2_runes['pick_cnt'] / top2_runes['game_cnt']) * 100, 2) #픽률 계산
match_up_runes = top2_runes
# ----------------------------------------------------------------------------------------------------------------------