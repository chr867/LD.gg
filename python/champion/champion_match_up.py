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
from riotwatcher import LolWatcher, ApiError
import imp
tqdm.pandas()
imp.reload(mu)


# ----------------------------------------------------------------------------------------------------------------------
# RawData
def fetch_all_data_from_match_raw(size_controll):
    conn = mu.connect_mysql()
    query = "SELECT * FROM match_raw_patch"

    start_time = time.time()

    data_list = []  # 데이터를 저장할 리스트

    chunk_size = size_controll  # 조각의 크기
    offset = 0
    total_rows = mu.count_rows('match_raw_patch', conn)  # match_raw_patch 테이블의 총 행 개수 가져오기
    pbar = tqdm(total=total_rows, unit="row", ncols=80)  # tqdm으로 프로그레스 바 생성
    while True:
        query_chunk = f"{query} LIMIT {chunk_size} OFFSET {offset}"
        chunk_data = mu.mysql_execute_dict(query_chunk, conn)  # mu.mysql_execute_dict() 함수로 쿼리 실행
        if not chunk_data:
            break  # 데이터를 모두 불러왔으면 종료
        data_list.extend(chunk_data)
        offset += chunk_size
        pbar.update(len(chunk_data))  # 프로그레스 바 업데이트

    pbar.close()  # 프로그레스 바 종료

    end_time = time.time()
    execution_time = end_time - start_time
    print(f"Execution time: {execution_time} seconds")

    df = pd.DataFrame(data_list)
    conn.close()
    df['matches'] = df['matches'].progress_apply(lambda x: json.loads(x))  # JSON 문자열을 JSON 객체로 변환
    df['timeline'] = df['timeline'].progress_apply(lambda x: json.loads(x))  # JSON 문자열을 JSON 객체로 변환
    return df
# ----------------------------------------------------------------------------------------------------------------------
def fetch_data_from_match_raw(limit, size_controll):
    conn = mu.connect_mysql()
    query = "SELECT * FROM match_raw_patch"

    start_time = time.time()

    data_list = []  # 데이터를 저장할 리스트

    chunk_size = size_controll  # 조각의 크기
    offset = 0
    pbar = tqdm(total=limit, unit="row", ncols=80)  # tqdm으로 프로그레스 바 생성
    while len(data_list) < limit:
        query_chunk = f"{query} LIMIT {offset}, {chunk_size}"
        chunk_data = mu.mysql_execute_dict(query_chunk, conn)  # mu.mysql_execute_dict() 함수로 쿼리 실행
        data_list.extend(chunk_data)
        offset += chunk_size
        pbar.update(len(chunk_data))  # 프로그레스 바 업데이트
        if len(data_list) >= limit:
            break

    pbar.close()  # 프로그레스 바 종료

    end_time = time.time()
    execution_time = end_time - start_time
    print(f"Execution time: {execution_time} seconds")

    df = pd.DataFrame(data_list)
    conn.close()
    df['matches'] = df['matches'].progress_apply(lambda x: json.loads(x)) # JSON 문자열을 JSON 객체로 변환
    df['timeline'] = df['timeline'].progress_apply(lambda x: json.loads(x)) # JSON 문자열을 JSON 객체로 변환
    return df

# ----------------------------------------------------------------------------------------------------------------------
df = fetch_all_data_from_match_raw(100) #전체 데이터를 100개씩 리스트에 담아서 데이터 프레임화
# ----------------------------------------------------------------------------------------------------------------------
df = fetch_data_from_match_raw(5000, 1000) # 5000개의 데이터를 1000개씩 리스트에 담아서 데이터 프레임화
# ----------------------------------------------------------------------------------------------------------------------
# 매치업 데이터 정제
def first_refine(df):
    df_creater = []
    accessories_lst = [3364, 3340, 3363, 3330, 3513] #장신구
    shoe_items = [3111, 3117, 3009, 3047, 3006, 3158, 3020] # #신발
    legend_item_list =[3003,3004,3011,3026,3031,3033,3036,3040,3041,3042,3046,3050,3053,3065,3068,3071,3072,3074,3075,3083,3085,3089,# 전설 아이템
     3091,3094,3095,3100,3102,3107,3109,3110,3115,3116,3119,3121,3124,3135,3139,3142,3143,3153,3156,3157,3161,3165,3179,3181,3193,3222,
     3504,3508,3742,3748,3814,4401,4628,4629,4637,4645,6035,6333,6609,6616,6664,6675,6676,6694,6695,6696,8001,8020]
    mythic_item_list = [2065,3001,3078,3084,3152,3190,4005,4633,4636,4644,6617,6630,6631,6632,6653,6655,6656,6657,6662,6665,6667,6671,6672,6673,6691,6692,6693] # 신화 아이템

    columns = [
        'match_id', 'game_duration', 'game_version',
        'participant_id', 'champion_name', 'champion_id', 'ban_champion_id', 'team_position',
        'team_id', 'win', 'kills', 'deaths', 'assists', 'tower_destroy',
        'deal_to_champ', 'cs', 'spell_1', 'spell_2', 'g_15', 'skill_tree', 'skill_build',
        'item_history','start_item','shoe_item','mythic_item','item_build','FRAGMENT1_ID', 'FRAGMENT2_ID',
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

                minions_killed = participant_frames[p_idx]['minionsKilled'] #미니언 킬
                jungle_minions_killed = participant_frames[p_idx]['jungleMinionsKilled'] #정글 미니언 킬
                cs = minions_killed + jungle_minions_killed # cs

                timeline_data = df.iloc[m_idx]['timeline'].values() # 타임라인
                all_events = [event for events in timeline_data for event in events['events']] # 시간대 별 이벤트
                building_kill_events = [event for event in all_events if event['type'] == 'BUILDING_KILL' and event.get('towerType') == 'OUTER_TURRET'] # 외곽 포탑 킬 이벤트 리스트
                skill_level_up_events = [event for event in all_events if event['type'] == 'SKILL_LEVEL_UP'] # 스킬 레벨업 이벤트 리스트
                item_purchased_events = [event for event in all_events if event['type'] == 'ITEM_PURCHASED'] # 아이템 구매 이벤트 리스트
                item_purchased_1m = [event for event in df.iloc[m_idx]['timeline']['1']['events'] if event['type'] == 'ITEM_PURCHASED'] # 1분대의 아이템 구매 이벤트 리스트
                item_purchased_2m = [event for event in df.iloc[m_idx]['timeline']['2']['events'] if event['type'] == 'ITEM_PURCHASED'] # 2분대의 아이템 구매 이벤트 리스트

                item_history=[] # 모든 아이템 구매내역
                for items in item_purchased_events:
                    if items['participantId'] == p['participantId']:
                        item_history.append(items['itemId'])
                item_history_str = ','.join(map(str, item_history))

                start_items=[] # 시작 아이템
                for item_in_1m in item_purchased_1m:
                    if item_in_1m['participantId'] == p['participantId']:
                        start_items.append(item_in_1m['itemId'])
                for item_in_2m in item_purchased_2m:
                    if item_in_2m['participantId'] == p['participantId']:
                        start_items.append(item_in_2m['itemId'])
                start_items.sort(reverse=True) # 숫자가 큰 아이템 부터 정렬
                start_items = [item for item in start_items if item not in accessories_lst]
                start_items_str = ','.join(map(str, start_items))

                item_build = [] # 아이템 빌드
                for build_item in item_history:
                    if build_item in legend_item_list or build_item in mythic_item_list:
                        item_build.append(build_item)
                item_build = list(set(item_build))
                item_build_str = ','.join(map(str, item_build))

                shoes=[] # 신발 아이템
                for shoe_item in item_history:
                    if shoe_item in shoe_items:
                        shoes.append(shoe_item)
                if shoes == []:
                    shoe = 0
                else:
                    shoe = shoes[-1] # 신발 아이템

                tower_destroy = 0 # 포탑 파괴시간
                try:
                    for t_log in building_kill_events:
                        lane = t_log['laneType']
                        team_num = t_log['teamId']
                        if lane_processing(lane, team_num, p['teamPosition'], p['teamId']):
                            tower_destroy = round(t_log['timestamp'] / 1000)
                except Exception as e:
                    print(e, lane, type(p['teamPosition']), p['teamPosition'])

                skill_log = [] # 스킬 트리
                for skills in skill_level_up_events:
                    if skills['participantId'] == p['participantId']:
                        skill_log.append(skills['skillSlot'])
                skill_log_str = ','.join(map(str, skill_log))

                skill_priority = []  # 스킬 우선순위
                skill_counts = {} # 각 스킬 빈도 수 저장
                last_occurrence = {} # 각 스킬 마지막으로 선택된 위치 저장
                for skill_idx, skill in enumerate(skill_log):
                    if skill == 4:  # 4번 스킬(R) 배제
                        continue
                    if skill not in skill_counts:
                        skill_counts[skill] = 0
                    skill_counts[skill] += 1
                    last_occurrence[skill] = skill_idx
                # 등장 빈도가 높은 순서로, 그리고 빈도가 같으면 각 스킬이 마지막으로 찍힌 위치가 빠른 순서로 스킬 정렬
                sorted_skills = sorted(skill_counts.items(), key=lambda x: (-x[1], last_occurrence[x[0]]))
                # 스킬 우선순위 출력
                skill_priority = [skill for skill, count in sorted_skills]
                skill_priority_str = ','.join(map(str, skill_priority))

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
                    df.iloc[m_idx]['timeline']['15']['participantFrames'][p_idx]['totalGold'], # 15분대 골드량
                    skill_log_str, # 스킬 트리
                    skill_priority_str, # 스킬 우선순위
                    item_history_str, # 모든 아이템 구매내역
                    start_items_str, # 시작 아이템
                    shoe, # 신발 아이템
                    p.get('mythicItemUsed', 0),  # 신화 아이템
                    item_build_str # 아이템 빌드
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
    return sum_df

sum_df = first_refine(df)
#  ---------------------------------------------------------------------------------------------------------------------
#포지션 별 승률 픽률,밴률 데이터 프레임 정제용
def refine_win_pick_ban(sum_df):
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
    return wpb_sample

wpb_sample = refine_win_pick_ban(sum_df)
#  ---------------------------------------------------------------------------------------------------------------------
#match_up 2차 정제
def second_refine(sum_df):
    sample = sum_df[['match_id','champion_name','champion_id','win','team_position','g_15'
                     ,'team_id','kills','deaths','assists','deal_to_champ','tower_destroy'
                     ,'cs','ban_champion_id','spell_1','spell_2', 'skill_tree', 'skill_build',
        'item_history','start_item','shoe_item','mythic_item','item_build', 'FRAGMENT1_ID', 'FRAGMENT2_ID',
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
    return result

result = second_refine(sum_df)
#  ---------------------------------------------------------------------------------------------------------------------
# 매치업 기본 통계
def refine_champion_match_up(result):
    win_df = result.copy()
    # 챔피언 이름 , 라인, 적 챔피언 순으로 그룹화 해서 라인승리 누적횟수와 게임승리 누적횟수를 보여줌
    cnt_df = win_df.groupby(['champion_name','champion_id','team_position','enemy_champ','enemy_champ_id'])[['win','g_15','kills','deaths','assists','deal_to_champ','tower_destroy','cs','team_kills','enemy_kills','enemy_deaths','enemy_assists','enemy_team_kills']].sum().rename(columns={'win':'match_up_win_cnt'})
    # 전체 게임수를 카운트해서 match_up_cnt 컬럼의 값으로 넣음
    game_df = win_df.groupby(['champion_name','champion_id','team_position','enemy_champ','enemy_champ_id'])[['win']].count().rename(columns={'win':'match_up_cnt'})
    #merge를 통해 전체 게임수와 누적 승리를 보여줌
    result_df = pd.merge(cnt_df,game_df,on=['champion_name','champion_id','team_position','enemy_champ','enemy_champ_id'])
    # 게임수가 많은 순으로 정렬
    r_df = result_df.sort_values('match_up_cnt',ascending=False)
    # 승률
    r_df['match_up_win_rate']=round((r_df['match_up_win_cnt']/r_df['match_up_cnt'])*100,2)
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
    match_up = r_df[['lane_kill_rate','kda','kill_participation','deal_to_champ','avg_g_15','tower_kill_time','avg_cs','match_up_win_rate','match_up_win_cnt','match_up_cnt']]
    #인덱스 리셋
    match_up =match_up.reset_index()
    # nan , inf 값 제거
    match_up = match_up.dropna()
    return match_up

match_up = refine_champion_match_up(result)
# ----------------------------------------------------------------------------------------------------------------------
# match_up_spell
# 매치업 스펠 데이터
def refine_match_up_spell(result):
    spell_df = result[['champion_id','team_position','enemy_champ_id', 'spell_1', 'spell_2', 'win']].copy()
    def sort_spells(df):
        df['spell_1'], df['spell_2'] = np.sort(df[['spell_1', 'spell_2']], axis=1).T # 스펠 순서 정렬을 통해 중복 방지
        return df.groupby(['champion_id','team_position','enemy_champ_id', 'spell_1', 'spell_2'])['win'].agg(['sum','count']).reset_index() #승리수 와 게임수 계산

    spells = sort_spells(spell_df).rename(columns={'count': 'pick_cnt', 'sum': 'win_cnt', 'spell_1': 'd_spell', 'spell_2': 'f_spell'})
    spells['game_cnt'] = spells.groupby(['champion_id','team_position','enemy_champ_id'])[['pick_cnt']].transform('sum')
    spells = spells.sort_values(['champion_id','game_cnt', 'pick_cnt','win_cnt'], ascending=[True,False,False,False])
    top2_spells = spells.groupby(['champion_id','team_position','enemy_champ_id']).head(2).reset_index(drop=True)
    top2_spells['win_rate'] = round((top2_spells['win_cnt'] / top2_spells['pick_cnt']) * 100, 2) #승률 계산
    top2_spells['pick_rate'] = round((top2_spells['pick_cnt'] / top2_spells['game_cnt']) * 100, 2) #픽률 계산
    match_up_spell = top2_spells
    print("스펠 데이터 정제 완료 ")
    return match_up_spell

match_up_spell = refine_match_up_spell(result)

# ----------------------------------------------------------------------------------------------------------------------
# match_up_runes
# 매치업 룬데이터
def refine_match_up_runes(result):
    rune_df = result[['champion_id','team_position','enemy_champ_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID',
        'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID','MAIN_SUB2_ID',
        'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID','win']].copy()

    rune_df = rune_df.groupby(['champion_id','team_position','enemy_champ_id', 'FRAGMENT1_ID', 'FRAGMENT2_ID',
        'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID','MAIN_SUB2_ID',
        'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID'])['win'].agg(['sum','count']).rename(columns={'count': 'pick_cnt', 'sum': 'win_cnt'}).reset_index()

    rune_df['game_cnt'] = rune_df.groupby(['champion_id','team_position','enemy_champ_id'])[['pick_cnt']].transform('sum')
    rune_df = rune_df.sort_values(['champion_id','game_cnt', 'pick_cnt','win_cnt'], ascending=[True,False,False,False])
    top2_runes = rune_df.groupby(['champion_id','team_position','enemy_champ_id']).head(2).reset_index(drop=True)
    top2_runes['win_rate'] = round((top2_runes['win_cnt'] / top2_runes['pick_cnt']) * 100, 2) #승률 계산
    top2_runes['pick_rate'] = round((top2_runes['pick_cnt'] / top2_runes['game_cnt']) * 100, 2) #픽률 계산
    match_up_runes = top2_runes
    return match_up_runes

match_up_runes = refine_match_up_runes(result)
# ----------------------------------------------------------------------------------------------------------------------
# match_up_skill
# 매치업 스킬 빌드
def refine_match_up_skill(result):
    skill_df = result[['champion_id','team_position','enemy_champ_id','skill_tree','skill_build','win']].copy()
    # 스킬 빌드
    skill_build_df = skill_df.groupby(['champion_id','team_position','enemy_champ_id','skill_build'])['win'].agg(['sum','count']).rename(columns={'count': 'skill_build_pick_cnt', 'sum': 'skill_build_win_cnt'})
    skill_build_df['game_cnt'] = skill_build_df.groupby(['champion_id','team_position','enemy_champ_id'])[['skill_build_pick_cnt']].transform('sum')
    skill_build_df = skill_build_df.sort_values(['champion_id','game_cnt','skill_build_pick_cnt','skill_build_win_cnt'],ascending = [True,False,False,False])
    skill_build_df['skill_build_win_rate'] = round((skill_build_df['skill_build_win_cnt'] / skill_build_df['skill_build_pick_cnt']) * 100, 2) #승률 계산
    skill_build_df['skill_build_pick_rate'] = round((skill_build_df['skill_build_pick_cnt'] / skill_build_df['game_cnt']) * 100, 2) #픽률 계산
    skill_build_df = skill_build_df.groupby(['champion_id','team_position','enemy_champ_id']).head(2).reset_index()
    # 스킬 트리
    skill_df['skill_tree'] = skill_df['skill_tree'].apply(lambda x: ','.join(x.split(',')[:12]))
    skill_tree_df = skill_df.groupby(['champion_id','team_position','enemy_champ_id','skill_tree','skill_build'])['win'].agg(['sum','count']).rename(columns={'count': 'skill_tree_pick_cnt', 'sum': 'skill_tree_win_cnt'})
    skill_tree_df['game_cnt'] = skill_tree_df.groupby(['champion_id','team_position','enemy_champ_id'])[['skill_tree_pick_cnt']].transform('sum')
    skill_tree_df = skill_tree_df.sort_values(['champion_id','game_cnt','skill_tree_pick_cnt','skill_tree_win_cnt'],ascending = [True,False,False,False])
    skill_tree_df['skill_tree_win_rate'] = round((skill_tree_df['skill_tree_win_cnt'] / skill_tree_df['skill_tree_pick_cnt']) * 100, 2) #승률 계산
    skill_tree_df['skill_tree_pick_rate'] = round((skill_tree_df['skill_tree_pick_cnt'] / skill_tree_df['game_cnt']) * 100, 2) #픽률 계산
    skill_tree_df = skill_tree_df.groupby(['champion_id','team_position','enemy_champ_id','skill_build']).head(1).reset_index()
    # 머지
    match_up_skill_df = pd.merge(skill_build_df,skill_tree_df, on=['champion_id', 'team_position', 'enemy_champ_id', 'skill_build','game_cnt'])
    return match_up_skill_df

match_up_skill_df = refine_match_up_skill(result)
#  ---------------------------------------------------------------------------------------------------------------------
# 매치업 아이템 빌드
def refine_match_up_item(result):
    item_df = result[['champion_id','team_position','enemy_champ_id','item_history','start_item','shoe_item','mythic_item','item_build','win']].copy()
    #시작템 승률 픽률
    start_item_df = item_df.groupby(['champion_id','team_position','enemy_champ_id','start_item'])['win'].agg(['sum','count'])\
        .rename(columns={'count': 'start_item_pick_cnt', 'sum': 'start_item_win_cnt'})
    start_item_df['game_cnt'] = start_item_df.groupby(['champion_id','team_position','enemy_champ_id'])[['start_item_pick_cnt']].transform('sum')
    start_item_df = start_item_df.sort_values(['champion_id','game_cnt','start_item_pick_cnt','start_item_win_cnt'],ascending = [True,False,False,False])
    start_item_df['start_item_win_rate'] = round((start_item_df['start_item_win_cnt'] / start_item_df['start_item_pick_cnt']) * 100, 2) #승률 계산
    start_item_df['start_item_pick_rate'] = round((start_item_df['start_item_pick_cnt'] / start_item_df['game_cnt']) * 100, 2) #픽률 계산
    start_item_df = start_item_df.groupby(['champion_id','team_position','enemy_champ_id']).head(1).reset_index()

    #신발템 승률 픽률
    shoe_item_df = item_df.groupby(['champion_id','team_position','enemy_champ_id','shoe_item'])['win'].agg(['sum','count'])\
        .rename(columns={'count': 'shoe_item_pick_cnt', 'sum': 'shoe_item_win_cnt'})
    shoe_item_df['game_cnt'] = shoe_item_df.groupby(['champion_id','team_position','enemy_champ_id'])[['shoe_item_pick_cnt']].transform('sum')
    shoe_item_df = shoe_item_df.sort_values(['champion_id','game_cnt','shoe_item_pick_cnt','shoe_item_win_cnt'],ascending = [True,False,False,False])
    shoe_item_df['shoe_item_win_rate'] = round((shoe_item_df['shoe_item_win_cnt'] / shoe_item_df['shoe_item_pick_cnt']) * 100, 2) #승률 계산
    shoe_item_df['shoe_item_pick_rate'] = round((shoe_item_df['shoe_item_pick_cnt'] / shoe_item_df['game_cnt']) * 100, 2) #픽률 계산
    shoe_item_df = shoe_item_df.groupby(['champion_id','team_position','enemy_champ_id']).head(1).reset_index()

    #신화템 승률 픽률
    mythic_item_df = item_df.groupby(['champion_id','team_position','enemy_champ_id','mythic_item'])['win'].agg(['sum','count'])\
        .rename(columns={'count': 'mythic_item_pick_cnt', 'sum': 'mythic_item_win_cnt'})
    mythic_item_df['game_cnt'] = mythic_item_df.groupby(['champion_id','team_position','enemy_champ_id'])[['mythic_item_pick_cnt']].transform('sum')
    mythic_item_df = mythic_item_df.sort_values(['champion_id','game_cnt','mythic_item_pick_cnt','mythic_item_win_cnt'],ascending = [True,False,False,False])
    mythic_item_df['mythic_item_win_rate'] = round((mythic_item_df['mythic_item_win_cnt'] / mythic_item_df['mythic_item_pick_cnt']) * 100, 2) #승률 계산
    mythic_item_df['mythic_item_pick_rate'] = round((mythic_item_df['mythic_item_pick_cnt'] / mythic_item_df['game_cnt']) * 100, 2) #픽률 계산
    mythic_item_df = mythic_item_df.groupby(['champion_id','team_position','enemy_champ_id']).head(1).reset_index()

    #아이템 빌드 승률 픽률
    item_build_df = item_df.groupby(['champion_id','team_position','enemy_champ_id','item_build'])['win'].agg(['sum','count'])\
        .rename(columns={'count': 'item_build_pick_cnt', 'sum': 'item_build_win_cnt'})
    item_build_df['game_cnt'] = item_build_df.groupby(['champion_id','team_position','enemy_champ_id'])[['item_build_pick_cnt']].transform('sum')
    item_build_df = item_build_df.sort_values(['champion_id','game_cnt','item_build_pick_cnt','item_build_win_cnt'],ascending = [True,False,False,False])
    item_build_df['item_build_win_rate'] = round((item_build_df['item_build_win_cnt'] / item_build_df['item_build_pick_cnt']) * 100, 2) #승률 계산
    item_build_df['item_build_pick_rate'] = round((item_build_df['item_build_pick_cnt'] / item_build_df['game_cnt']) * 100, 2) #픽률 계산
    item_build_df = item_build_df.groupby(['champion_id','team_position','enemy_champ_id']).head(1).reset_index()

    # 머지
    match_up_item_df = item_build_df.merge(start_item_df, on=['champion_id', 'team_position', 'enemy_champ_id','game_cnt'])\
        .merge(shoe_item_df, on=['champion_id', 'team_position', 'enemy_champ_id','game_cnt'])\
        .merge(mythic_item_df, on=['champion_id', 'team_position', 'enemy_champ_id','game_cnt'])
    return match_up_item_df

match_up_item_df = refine_match_up_item(result)
#  ---------------------------------------------------------------------------------------------------------------------
# db에 데이터 삽입
def insert_champion_match_up(x,conn):
    query = (
        f'insert into champion_match_up (champion_name, champion_id, team_position, enemy_champ, '
        f'enemy_champ_id, lane_kill_rate, kda, kill_participation, deal_to_champ, '
        f'avg_g_15, tower_kill_time, avg_cs, match_up_win_rate, match_up_win_cnt, match_up_cnt)'
        f'values({repr(x.champion_name)},{x.champion_id},{repr(x.team_position)},{repr(x.enemy_champ)},'
        f'{x.enemy_champ_id},{x.lane_kill_rate},{x.kda},{x.kill_participation},{x.deal_to_champ},{x.avg_g_15},'
        f'{x.tower_kill_time},{x.avg_cs},{x.match_up_win_rate},{x.match_up_win_cnt},{x.match_up_cnt})'
    )
    query2 = (
        f'INSERT INTO champion_match_up '
        f'(champion_name, champion_id, team_position, enemy_champ, enemy_champ_id, lane_kill_rate, kda, '
        f'kill_participation, deal_to_champ, avg_g_15, tower_kill_time, avg_cs, match_up_win_rate, match_up_win_cnt, match_up_cnt) '
        f'VALUES ({repr(x.champion_name)}, {x.champion_id}, {repr(x.team_position)}, {repr(x.enemy_champ)}, {x.enemy_champ_id}, '
        f'{x.lane_kill_rate}, {x.kda}, {x.kill_participation}, {x.deal_to_champ}, {x.avg_g_15}, {x.tower_kill_time}, {x.avg_cs}, {x.match_up_win_rate}, {x.match_up_win_cnt}, {x.match_up_cnt}) '
        f'ON DUPLICATE KEY UPDATE '
        f'champion_id = VALUES(champion_id), team_position = VALUES(team_position), enemy_champ = VALUES(enemy_champ), enemy_champ_id = VALUES(enemy_champ_id), '
        f'lane_kill_rate = VALUES(lane_kill_rate), kda = VALUES(kda), kill_participation = VALUES(kill_participation), deal_to_champ = VALUES(deal_to_champ), '
        f'avg_g_15 = VALUES(avg_g_15), tower_kill_time = VALUES(tower_kill_time), avg_cs = VALUES(avg_cs), '
        f'match_up_win_rate = VALUES(match_up_win_rate), match_up_win_cnt = VALUES(match_up_win_cnt), match_up_cnt = VALUES(match_up_cnt)'
    )
    try:
        mu.mysql_execute(query2,conn)
    except Exception as e:
        print(e)
    return
def insert_champion_match_up_spell(x,conn):
    query = (
        f'insert into champion_match_up_spell (champion_id, team_position, enemy_champ_id, d_spell, f_spell, win_cnt, pick_cnt, game_cnt, win_rate, pick_rate)'
        f'values({x.champion_id},{repr(x.team_position)},{x.enemy_champ_id},{x.d_spell},{x.f_spell},{x.win_cnt},{x.pick_cnt},{x.game_cnt},{x.win_rate},{x.pick_rate})'
    )
    query2 = (    )
    try:
        mu.mysql_execute(query, conn)
    except Exception as e:
        print(e)
    return
def insert_champion_match_up_rune(x, conn):
    query = (
        f'insert into champion_match_up_rune (champion_id, team_position, enemy_champ_id, FRAGMENT1_ID, FRAGMENT2_ID, FRAGMENT3_ID, MAIN_KEYSTONE_ID, MAIN_SUB1_ID, MAIN_SUB2_ID,'
        f' MAIN_SUB3_ID, MAIN_SUB4_ID, SUB_KEYSTONE_ID, SUB_SUB1_ID, SUB_SUB2_ID, win_cnt, pick_cnt, game_cnt, win_rate, pick_rate)'
        f'values({x.champion_id},{repr(x.team_position)},{x.enemy_champ_id},{x.FRAGMENT1_ID},{x.FRAGMENT2_ID},{x.FRAGMENT3_ID},{x.MAIN_KEYSTONE_ID},{x.MAIN_SUB1_ID},{x.MAIN_SUB2_ID},{x.MAIN_SUB3_ID},'
        f'{x.MAIN_SUB4_ID},{x.SUB_KEYSTONE_ID},{x.SUB_SUB1_ID},{x.SUB_SUB2_ID},{x.win_cnt},{x.pick_cnt},{x.game_cnt},{x.win_rate},{x.pick_rate})'
    )
    query2 = ()
    try:
        mu.mysql_execute(query, conn)
    except Exception as e:
        print(e)
    return
def insert_champion_match_up_skill(x, conn):
    query = (
        f'insert into champion_match_up_skill (champion_id, team_position, enemy_champ_id, skill_build, skill_build_win_cnt, skill_build_pick_cnt, game_cnt, skill_build_win_rate, skill_build_pick_rate, '
        f' skill_tree, skill_tree_win_cnt, skill_tree_pick_cnt, skill_tree_win_rate, skill_tree_pick_rate)'
        f'values({x.champion_id},{repr(x.team_position)},{x.enemy_champ_id},{repr(x.skill_build)},{x.skill_build_win_cnt},{x.skill_build_pick_cnt},{x.game_cnt},{x.skill_build_win_rate}'
        f',{x.skill_build_pick_rate},{repr(x.skill_tree)},{x.skill_tree_win_cnt},{x.skill_tree_pick_cnt},{x.skill_tree_win_rate},{x.skill_tree_pick_rate})'
    )
    query2 = ()
    try:
        mu.mysql_execute(query, conn)
    except Exception as e:
        print(e)
    return
def insert_champion_match_up_item(x, conn):
    query = (
        f'insert into champion_match_up_item (champion_id, team_position, enemy_champ_id, item_build, item_build_win_cnt, item_build_pick_cnt, game_cnt, item_build_win_rate, item_build_pick_rate,'
        f'start_item, start_item_win_cnt, start_item_pick_cnt, start_item_win_rate, start_item_pick_rate, shoe_item, shoe_item_win_cnt, shoe_item_pick_cnt, shoe_item_win_rate, shoe_item_pick_rate,'
        f'mythic_item, mythic_item_win_cnt, mythic_item_pick_cnt, mythic_item_win_rate, mythic_item_pick_rate)'
        f'values({x.champion_id},{repr(x.team_position)},{x.enemy_champ_id},{repr(x.item_build)},{x.item_build_win_cnt},{x.item_build_pick_cnt},{x.game_cnt},{x.item_build_win_rate},{x.item_build_pick_rate}'
        f',{repr(x.start_item)},{x.start_item_win_cnt},{x.start_item_pick_cnt},{x.start_item_win_rate},{x.start_item_pick_rate}'
        f',{x.shoe_item},{x.shoe_item_win_cnt},{x.shoe_item_pick_cnt},{x.shoe_item_win_rate},{x.shoe_item_pick_rate}'
        f',{x.mythic_item},{x.mythic_item_win_cnt},{x.mythic_item_pick_cnt},{x.mythic_item_win_rate},{x.mythic_item_pick_rate})'
    )
    query2 = ()
    try:
        mu.mysql_execute(query, conn)
    except Exception as e:
        print(e)
    return

conn = mu.connect_mysql()
match_up.progress_apply(lambda x: insert_champion_match_up(x,conn),axis =1)
conn.commit()
conn.close()

conn = mu.connect_mysql()
match_up_spell.progress_apply(lambda x: insert_champion_match_up_spell(x,conn),axis =1)
conn.commit()
conn.close()

conn = mu.connect_mysql()
match_up_runes.progress_apply(lambda x: insert_champion_match_up_rune(x,conn),axis =1)
conn.commit()
conn.close()

conn = mu.connect_mysql()
match_up_skill_df.progress_apply(lambda x: insert_champion_match_up_skill(x,conn),axis =1)
conn.commit()
conn.close()

conn = mu.connect_mysql()
match_up_item_df.progress_apply(lambda x: insert_champion_match_up_item(x,conn),axis =1)
conn.commit()
conn.close()
#  ---------------------------------------------------------------------------------------------------------------------
# riotwatcher library
watcher = LolWatcher(mu.riot_api_key) #riotwatcher 객체 생성
my_region = 'kr'
summoner_name = 'quad'

response = watcher.summoner.by_name(my_region, summoner_name) # 소환사 정보
print(response)
ranked_stats = watcher.league.by_summoner(my_region, response['id']) # 소환사 랭크 스텟
print(ranked_stats)
my_matches = watcher.match.matchlist_by_puuid(my_region, response['puuid'], 0, 30) # 최근 게임 30개
print(my_matches)

match_detail = watcher.match.by_id(my_region, my_matches[0]) # 매치 정보
timeline_detail = watcher.match.timeline_by_match(my_region, my_matches[0]) # 타임라인 정보

participants = []
for row in match_detail['info']['participants']:
    participants_row = {}
    participants_row['champion'] = row['championId']
    participants_row['spell1'] = row['summoner1Id']
    participants_row['spell2'] = row['summoner2Id']
    participants_row['win'] = row['win']
    participants_row['kills'] = row['kills']
    participants_row['deaths'] = row['deaths']
    participants_row['assists'] = row['assists']
    participants_row['totalDamageDealt'] = row['totalDamageDealt']
    participants_row['goldEarned'] = row['goldEarned']
    participants_row['champLevel'] = row['champLevel']
    participants_row['totalMinionsKilled'] = row['totalMinionsKilled']
    participants_row['item0'] = row['item0']
    participants_row['item1'] = row['item1']
    participants_row['item2'] = row['item2']
    participants_row['item3'] = row['item3']
    participants_row['item4'] = row['item4']
    participants_row['item5'] = row['item5']
    participants_row['item6'] = row['item6']
    participants.append(participants_row)
watcher_df = pd.DataFrame(participants)
watcher_df