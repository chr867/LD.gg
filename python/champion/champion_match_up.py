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
conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict('select * from match_solr_rank',conn))
conn.close()

df = df[(df.gameDuration > 900) & (df.gameDuration <10000)]

df

sample = df[['match_id','championName','championId','win','teamPosition','g_15','teamId','kills','deaths','assists','dealToChamp','towerDestroy','cs','ban_champion_id']]

sample.rename(columns={'championName': 'champion_name','championId': 'champion_id','teamPosition': 'team_position','teamId': 'team_id','dealToChamp': 'deal_to_champ','towerDestroy': 'tower_destroy'}, inplace=True)

# 각 팀 킬 수 합쳐서 team_kills 컬럼에 추가
sample['team_kills'] = sample.groupby(['match_id', 'team_id'])['kills'].transform('sum')

sample
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

match_up.rename(columns={'win_rate': 'match_up_win_rate','win_cnt': 'match_up_win_cnt'}, inplace=True)
# nan , inf 값 제거
match_up = match_up.dropna()

# multi-level index로 설정된 경우
match_up.loc[r_df_o.index.get_level_values('champion_name') == 'Yorick']

# db에 데이터 삽입
conn = mu.connect_mysql()
# Cursor 객체 생성
cursor = conn.cursor()
# tqdm을 사용하여 데이터프레임의 각 행을 순회하며 데이터 삽입
with tqdm(total=len(match_up)) as pbar:
    for row in match_up.itertuples(index=False):
        insert_query = "INSERT INTO champion_match_up (champion_name, champion_id, lane, enemy_champ, enemy_champ_id, lane_kill_rate, kda, kill_participation, deal_to_champ, avg_g_15, avg_tower_kill, avg_cs, match_up_win_rate, match_up_win_cnt, match_up_cnt) " \
                       "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(insert_query, row)
        pbar.update(1)
# 변경사항을 커밋하여 데이터베이스에 반영
conn.commit()
# Cursor와 Connection 종료
cursor.close()
conn.close()

def insert_my(x,conn):
    query = (
        f'insert into champion_match_up (champion_name, champion_id, lane, enemy_champ, enemy_champ_id, lane_kill_rate, kda, kill_participation, deal_to_champ, avg_g_15, avg_tower_kill, avg_cs, match_up_win_rate, match_up_win_cnt, match_up_cnt)'
        f'values({repr(x.champion_name)},{x.champion_id},{repr(x.lane)},{repr(x.enemy_champ)},{x.enemy_champ_id},{x.lane_kill_rate},{x.kda},{x.kill_participation},{x.deal_to_champ},{x.avg_g_15},{x.avg_tower_kill},{x.avg_cs},{x.match_up_win_rate},{x.match_up_win_cnt},{x.match_up_cnt})'
    )
    try:
        mu.mysql_execute(query,conn)
    except Exception as e:
        print(e)
    return

conn = mu.connect_mysql()
match_up.progress_apply(lambda x: insert_my(x,conn),axis =1)
conn.commit()
conn.close()