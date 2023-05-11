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

# RIOT-API-KEY
riot_api_key = 'RGAPI-3c09d778-af7b-4f6b-94b4-e7784679bc11'
# ----------------------------------------------------------------------------------------------------------------------
# RawData
conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict('select * from match_solr_rank',conn))
conn.close()

df = df[(df.gameDuration > 900) & (df.gameDuration <10000)]

df

sample = df[['match_id','championName','championId','win','teamPosition','g_15','teamId','kills','deaths','assists','dealToChamp','towerDestroy','cs','ban_champion_id']]

# 각 팀 킬 수 합쳐서 team_kills 컬럼에 추가
sample['team_kills'] = sample.groupby(['match_id', 'teamId'])['kills'].transform('sum')

sample
#팀별로 테이블 분리
blue = sample[sample['teamId'] == 100]
red =sample[sample['teamId']==200]

#팀별 컬럼 리네임
blue_tmp = blue[['match_id','championName','teamPosition','g_15','kills','deaths','assists','team_kills']].rename(columns={'championName':'enemy_champ','g_15':'enemy_g_15','kills':'enemy_kills', 'deaths':'enemy_deaths', 'assists':'enemy_assists', 'team_kills':'enemy_team_kills'})
red_tmp = red[['match_id','championName','teamPosition','g_15','kills','deaths','assists','team_kills']].rename(columns={'championName':'enemy_champ','g_15':'enemy_g_15','kills':'enemy_kills', 'deaths':'enemy_deaths', 'assists':'enemy_assists', 'team_kills':'enemy_team_kills'})

#분리한 팀별 테이블 merge해서 비교
blue_merge = pd.merge(blue,red_tmp, on=['match_id','teamPosition'])
red_merge = pd.merge(red,blue_tmp, on=['match_id','teamPosition'])

# append를 통해서 다시 하나의 테이블로
result = blue_merge.append(red_merge)

# 인덱스 재설정
result = result.reset_index(drop=True)

# 게임아이디랑 팀 아이디 별로 정렬
result = result.sort_values(by=['gameId','teamId'])

win_df = result.copy()

# 팀포지션컬럼을 라인으로 리네임
win_df.rename(columns={'teamPosition': 'lane'},inplace=True)

# 챔피언 이름 , 라인, 적 챔피언 순으로 그룹화 해서 라인승리 누적횟수와 게임승리 누적횟수를 보여줌
cnt_df = win_df.groupby(['championName','lane','enemy_champ'])[['win','g_15','kills','deaths','assists','totalDamageDealtToChampions','team_kills','enemy_kills','enemy_deaths','enemy_assists','enemy_team_kills']].sum().rename(columns={'win':'win_cnt'})

# 전체 게임수를 카운트해서 game_cnt라는 컬럼의 값으로 넣음
game_df = win_df.groupby(['championName','lane','enemy_champ'])[['win']].count().rename(columns={'win':'game_cnt'})

#merge를 통해 전체 게임수와 누적 승리를 보여줌
result_df = pd.merge(cnt_df,game_df,on=['championName','lane','enemy_champ'])

# 게임수가 많은 순으로 정렬
r_df = result_df.sort_values('game_cnt',ascending=False)

# 승률
r_df['win_rate']=round((r_df['win_cnt']/r_df['game_cnt'])*100,2)
#kda
r_df['kda']=round((r_df['kills']+r_df['assists'])/r_df['deaths'],2)
#라인킬 확률
r_df['lane_kills'] = round((r_df['kills']/r_df['deaths'])/((r_df['kills']/r_df['deaths'])+(r_df['enemy_kills']/r_df['enemy_deaths']))*100,2)
#킬관여율
r_df['kill_participation'] = round(( ((r_df['kills']+r_df['assists'])/r_df['team_kills']) /(((r_df['kills']+r_df['assists'])/r_df['team_kills']) + ((r_df['enemy_kills']+r_df['enemy_assists'])/r_df['team_kills']))  )*100,2)
#챔피언에게 가한 피해량
r_df['deal_to_champ'] = round(r_df['totalDamageDealtToChampions']/r_df['game_cnt'])
#15분대의 골드 획득량
r_df['avg_g_15'] = round(r_df['g_15']/r_df['game_cnt'])
#타워 파괴 횟수

r_df_o = r_df[['lane_kills','kda','kill_participation','deal_to_champ','win_rate','win_cnt','game_cnt']]

# multi-level index로 설정된 경우
r_df_o.loc[r_df_o.index.get_level_values('championName') == 'Yorick']