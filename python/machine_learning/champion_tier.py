# --------------------------------------------------------
# Package
import pandas as pd
from tqdm import tqdm
import my_utils as mu
import json
import time
import numpy as np
import plotly.offline as pyo
import plotly.graph_objs as go

tqdm.pandas()
import data_load as dl
from scipy.stats import zscore
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.cluster import KMeans

from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix
from imblearn.under_sampling import RandomUnderSampler

import joblib

# # RIOT-API-KEY
# riot_api_key = 'RGAPI-14667a4e-7c3c-45fa-ac8f-e53c7c3f5fe1'
# pd.set_option('display.max_columns', None)
# pd.set_option('display.max_rows', None)
# ----------------------------------------------------------------------------------------------------------------------
# start_time = time.time()
# df = dl.match_raw_patch(1)
# print("JSON 변환 시작")
# df['matches'] = df['matches'].apply(json.loads)
# df['timeline'] = df['timeline'].apply(json.loads)
# end_time = time.time()
# print("변환 시간: {:.2f}초".format(end_time - start_time))
# print("JSON 변환 종료")
#
# df.iloc[0].matches
# ----------------------------------------------------------------------------------------------------------------------
# 모델 학습용 데이터 연산 코드
print("시작!")
print(f'총 데이터 갯수 : 796000 개')

batch_size = 100000
win_pick_lst_result = []
ban_rate_lst_result = []
meta_score_lst_result = []
cnt = 0
for limit in tqdm(range(0, 796000, batch_size)):
    conn = mu.connect_mysql()
    query = f"SELECT * FROM match_solr_rank LIMIT {limit}, {batch_size}"
    row = pd.DataFrame(mu.mysql_execute_dict(query, conn))
    conn.close()

    for _, player in tqdm(row.iterrows()):
        lst = []
        lst.append(player['championId'])
        lst.append(player['win'])
        lst.append(player['teamPosition'])
        win_pick_lst_result.append(lst)
        cnt += 1
    for _, player in tqdm(row.iterrows()):
        lst = []
        if player['ban_champion_id'] != 0 and player['ban_champion_id'] != -1:
            lst.append(player['teamPosition'])
            lst.append(player['ban_champion_id'])
            ban_rate_lst_result.append(lst)

    for _, player in tqdm(row.iterrows()):
        lst = []
        lst.append(player['championId'])
        lst.append(player['teamPosition'])
        lst.append(player['kda'])
        lst.append(player['totalDamageDealtToChampions'])
        lst.append(player['totalDamageTaken'])
        lst.append(player['timeCCingOthers'])
        lst.append(player['total_gold'])
        meta_score_lst_result.append(lst)
print("데이터 셀렉트 및 리스트 저장완료")
# ----------------------------------------------------------------
win_pick_columns = ['championId', 'win', 'teamPosition']
win_pick_df = pd.DataFrame(win_pick_lst_result, columns=win_pick_columns)
win_pick_df['win'] = win_pick_df['win'].astype(int)
groupBy_df = win_pick_df.groupby(['championId', 'teamPosition']).agg({'win': ['sum', 'count']})
groupBy_df.columns = ['winCount', 'pickCount']
groupBy_df['lineTotalCount'] = groupBy_df.groupby('teamPosition')['pickCount'].transform('sum')
groupBy_df['winRate'] = round((groupBy_df['winCount'] / groupBy_df['pickCount']) * 100, 2)
groupBy_df['pickRate'] = round((groupBy_df['pickCount'] / groupBy_df['lineTotalCount']) * 100, 2)
groupBy_df = groupBy_df.reset_index()
win_pick_rate_df = groupBy_df[['championId', 'teamPosition', 'winRate', 'pickRate']]
# ----------------------------------------------------------------
columns = ['teamPosition', 'championId']
ban_df = pd.DataFrame(ban_rate_lst_result, columns=columns)
ban_rate_df = ban_df.groupby(['teamPosition', 'championId']).size().reset_index(name='banCount')

ban_rate_df['banPositionTotal'] = ban_rate_df.groupby('teamPosition')['banCount'].transform('sum')
ban_rate_df['banRate'] = round((ban_rate_df['banCount'] / ban_rate_df['banPositionTotal']) * 100, 2)
ban_rate_df = ban_rate_df.dropna()
ban_rate_df = ban_rate_df[['teamPosition', 'championId', 'banRate']]
# ----------------------------------------------------------------
meta_score_columns = ['championId', 'teamPosition', 'kda', 'totalDamageDealtToChampions', 'totalDamageTaken',
                      'timeCCingOthers', 'total_gold']
meta_score_df = pd.DataFrame(meta_score_lst_result, columns=meta_score_columns)
meta_score_df = meta_score_df.groupby(['championId', 'teamPosition']).mean().reset_index()

# ----------------------------------------------------------------
champion_stats_df = win_pick_rate_df.merge(ban_rate_df, on=['championId', 'teamPosition'])
result_df = champion_stats_df.merge(meta_score_df, on=['championId', 'teamPosition'])
# ----------------------------------------------------------------
# Zscore 설정
result_df[['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions',
           'totalDamageTaken', 'timeCCingOthers', 'total_gold']] = result_df[['winRate', 'pickRate',
                                                                              'banRate', 'kda',
                                                                              'totalDamageDealtToChampions',
                                                                              'totalDamageTaken', 'timeCCingOthers',
                                                                              'total_gold']].apply(zscore)
# Zscore 가중치 연산
result_df['totalScore'] = result_df['winRate'] * 0.30 + result_df['pickRate'] * 0.25 + \
                          result_df['banRate'] * 0.15 + result_df['kda'] * 0.05 + \
                          result_df['totalDamageDealtToChampions'] * 0.05 + \
                          result_df['totalDamageTaken'] * 0.05 + result_df['timeCCingOthers'] * 0.05 + \
                          result_df['total_gold'] * 0.05
# Zscore 이용하여 엄격하게 티어분류
conditions = [
    (result_df['totalScore'] >= 1.8),
    (result_df['totalScore'] >= 1.3) & (result_df['totalScore'] < 1.8),
    (result_df['totalScore'] >= 0.5) & (result_df['totalScore'] < 1.3),
    (result_df['totalScore'] >= 0.15) & (result_df['totalScore'] < 0.5),
    (result_df['totalScore'] >= 0) & (result_df['totalScore'] < 0.15),
    (result_df['totalScore'] < 0)
]
# OP = 0
labels = ['0', '1', '2', '3', '4', '5']
result_df['tier'] = np.select(conditions, labels, default='5')
champion_tier_machine_learning = result_df.copy()
sort_data = champion_tier_machine_learning.sort_values(by=['tier'], ascending=True)
print("데이터 연산 완료")
# ----------------------------------------------------------------
# 특성 가중치를 직접 결정하여 간편하고 직관적이지만 특성 가중치 간의 상호작용을 고려하지 못해 데이터의 주관성 발생
# 이를 머신러닝 데이터 학습을 통하여 최적의 특성 가중치 자동결정 특성간 복잡한 상호작용 고려 및 데이터의 객관성 보완

# 지도학습으로 랜덤 포레스트 분류기 모델 사용

# One-Hot Encoding
# 머신러닝에 맞게 이진벡터 변환
champion_tier_machine_learning = pd.get_dummies(champion_tier_machine_learning, columns=['teamPosition'])

# 특성
X = champion_tier_machine_learning.drop('tier', axis=1)  # 'tier' 열을 제외한 모든 열을 특성으로 사용
# 레이블
y = champion_tier_machine_learning['tier']  # 'tier' 열을 레이블로 사용

# 학습 데이터와 테스트 데이터 분리
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 랜덤 포레스트 분류기 학습
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# 예측 및 평가
y_pred = model.predict(X_test)
print('Accuracy: ', accuracy_score(y_test, y_pred))
# 예측값(y_pred)과 실제값(y_test)을 이용해 정밀도, 재현율, F1 점수를 측정
print(classification_report(y_test, y_pred))
# Confusion Matrix
print(confusion_matrix(y_test, y_pred))
# 교차 검증
scores = cross_val_score(model, X, y, cv=10)
# 교차 검증 결과 출력
print("Cross Validation Scores:", scores)
print("Mean Accuracy:", scores.mean())

# 모델 저장
joblib.dump(model, 'championTierPredictionModel2.pkl')

# ----------------------------------------------------------------------------------------------------------------------
# 데이터 프레임 연산 코드
def machine_learning_score(df):
    def win_rate_pick_rate_data(raw_data):
        result = []
        for x in tqdm(range(len(raw_data))):
            for player in raw_data.iloc[x]['matches']['participants']:
                lst = []
                lst.append(player['championId'])
                lst.append(player['win'])
                lst.append(player['teamPosition'])  # 팀 포지션 추가
                result.append(lst)

        columns = ['championId', 'win', 'teamPosition']  # 열 추가
        win_pick_df = pd.DataFrame(result, columns=columns)
        win_pick_df['win'] = win_pick_df['win'].astype(int)
        groupBy_df = win_pick_df.groupby(['championId', 'teamPosition']).agg({'win': ['sum', 'count']})
        groupBy_df.columns = ['winCount', 'pickCount']
        groupBy_df['lineTotalCount'] = groupBy_df.groupby('teamPosition')['pickCount'].transform('sum')
        groupBy_df['winRate'] = round((groupBy_df['winCount'] / groupBy_df['pickCount']) * 100, 2)
        groupBy_df['pickRate'] = round((groupBy_df['pickCount'] / groupBy_df['lineTotalCount']) * 100, 2)
        groupBy_df = groupBy_df.reset_index()  # 인덱스 재설정
        groupBy_df = groupBy_df[['championId', 'teamPosition', 'winRate', 'pickRate']]  # 열 순서 조정
        return groupBy_df

    win_rate_pick_rate_data = win_rate_pick_rate_data(df)

    # 밴률 데이터
    def ban_rate_data(raw_data):
        result = []
        for x in tqdm(range(len(raw_data))):
            ban_lst = raw_data.iloc[x]['matches']['bans']
            for idx, ban in enumerate(ban_lst):
                if ban != 0 and ban != -1:
                    lst = []
                    team_position = raw_data.iloc[x]['matches']['participants'][idx]['teamPosition']
                    if team_position:
                        lst.append(team_position)
                        lst.append(ban)
                        result.append(lst)

        columns = ['teamPosition', 'championId']
        ban_df = pd.DataFrame(result, columns=columns)
        ban_rate_df = ban_df.groupby(['teamPosition', 'championId']).size().reset_index(name='banCount')

        ban_rate_df['banPositionTotal'] = ban_rate_df.groupby('teamPosition')['banCount'].transform('sum')
        ban_rate_df['banRate'] = round((ban_rate_df['banCount'] / ban_rate_df['banPositionTotal']) * 100, 2)
        ban_rate_df = ban_rate_df.dropna()
        ban_rate_df = ban_rate_df[['teamPosition', 'championId', 'banRate']]

        return ban_rate_df

    ban_rate_df = ban_rate_data(df)

    champion_stats_df = win_rate_pick_rate_data.merge(ban_rate_df, on=['championId', 'teamPosition'])

    def meta_score_data(raw_data):
        result = []
        for x in tqdm(range(len(raw_data))):
            summoner = raw_data.iloc[x]['matches']['participants']
            for player in summoner:
                lst = []
                lst.append(player['championId'])
                lst.append(player['teamPosition'])
                lst.append(player['kda'])
                lst.append(player['totalDamageDealtToChampions'])
                lst.append(player['totalDamageTaken'])
                lst.append(player['timeCCingOthers'])
                lst.append(player['total_gold'])
                result.append(lst)

        columns = ['championId', 'teamPosition', 'kda', 'totalDamageDealtToChampions', 'totalDamageTaken',
                   'timeCCingOthers', 'total_gold']

        meta_score_df = pd.DataFrame(result, columns=columns)

        meta_score_df = meta_score_df.groupby(['championId', 'teamPosition']).mean().reset_index()

        return meta_score_df

    meta_score_data = meta_score_data(df)

    result_df = champion_stats_df.merge(meta_score_data, on=['championId', 'teamPosition'])
    result_df_copy = result_df.copy()
    result_df[['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions',
               'totalDamageTaken', 'timeCCingOthers', 'total_gold']] = result_df[['winRate', 'pickRate',
                                                                                  'banRate', 'kda',
                                                                                  'totalDamageDealtToChampions',
                                                                                  'totalDamageTaken', 'timeCCingOthers',
                                                                                  'total_gold']].apply(zscore)
    result_df['totalScore'] = result_df['winRate'] * 0.30 + result_df['pickRate'] * 0.25 + \
                              result_df['banRate'] * 0.15 + result_df['kda'] * 0.05 + \
                              result_df['totalDamageDealtToChampions'] * 0.05 + \
                              result_df['totalDamageTaken'] * 0.05 + result_df['timeCCingOthers'] * 0.05 + \
                              result_df['total_gold'] * 0.05
    result_df = pd.get_dummies(result_df, columns=['teamPosition'])
    model = joblib.load('championTierPredictionModel2.pkl')  # 모델 로드
    predictions = model.predict(result_df)  # 예측 수행
    result_df['tier'] = predictions  # 예측 결과를 'tier' 컬럼으로 추가
    columns_to_consider = ['teamPosition_BOTTOM', 'teamPosition_JUNGLE', 'teamPosition_MIDDLE', 'teamPosition_TOP',
                           'teamPosition_UTILITY']
    result_df['teamPosition'] = result_df[columns_to_consider].idxmax(axis=1)
    result_df['teamPosition'] = result_df['teamPosition'].str.replace('teamPosition_', '')  # 이진벡터값 다시 범주형으로 복원
    result_df = result_df[['championId', 'teamPosition', 'tier']]
    final_df = result_df_copy.merge(result_df, on=['championId', 'teamPosition'])
    final_df = final_df[['championId', 'teamPosition', 'winRate', 'pickRate', 'banRate', 'tier']]
    return final_df


# machine_learning_score = machine_learning_score(df)
# sort_machine_learning_score = machine_learning_score.sort_values(by=['tier'])


# ----------------------------------------------------------------------------------------------------------------------
# 리스트 연산 코드
def machine_learning_score(win_pick_lst, ban_lst, meta_lst):
    def win_rate_pick_rate_data(result):
        columns = ['championId', 'win', 'teamPosition']  # 열 추가
        win_pick_df = pd.DataFrame(result, columns=columns)
        win_pick_df['win'] = win_pick_df['win'].astype(int)
        groupBy_df = win_pick_df.groupby(['championId', 'teamPosition']).agg({'win': ['sum', 'count']})
        groupBy_df.columns = ['winCount', 'pickCount']
        groupBy_df['lineTotalCount'] = groupBy_df.groupby('teamPosition')['pickCount'].transform('sum')
        groupBy_df['winRate'] = round((groupBy_df['winCount'] / groupBy_df['pickCount']) * 100, 2)
        groupBy_df['pickRate'] = round((groupBy_df['pickCount'] / groupBy_df['lineTotalCount']) * 100, 2)
        groupBy_df = groupBy_df.reset_index()  # 인덱스 재설정
        groupBy_df = groupBy_df[['championId', 'teamPosition', 'winRate', 'pickRate']]  # 열 순서 조정
        return groupBy_df

    win_rate_pick_rate_data = win_rate_pick_rate_data(win_pick_lst)

    # 밴률 데이터
    def ban_rate_data(result):
        columns = ['teamPosition', 'championId']
        ban_df = pd.DataFrame(result, columns=columns)
        ban_rate_df = ban_df.groupby(['teamPosition', 'championId']).size().reset_index(name='banCount')

        ban_rate_df['banPositionTotal'] = ban_rate_df.groupby('teamPosition')['banCount'].transform('sum')
        ban_rate_df['banRate'] = round((ban_rate_df['banCount'] / ban_rate_df['banPositionTotal']) * 100, 2)
        ban_rate_df = ban_rate_df.dropna()
        ban_rate_df = ban_rate_df[['teamPosition', 'championId', 'banRate']]

        return ban_rate_df

    ban_rate_df = ban_rate_data(ban_lst)

    champion_stats_df = win_rate_pick_rate_data.merge(ban_rate_df, on=['championId', 'teamPosition'])

    def meta_score_data(result):
        columns = ['championId', 'teamPosition', 'kda', 'totalDamageDealtToChampions', 'totalDamageTaken',
                   'timeCCingOthers', 'total_gold']
        meta_score_df = pd.DataFrame(result, columns=columns)

        meta_score_df = meta_score_df.groupby(['championId', 'teamPosition']).mean().reset_index()

        return meta_score_df

    meta_score_data = meta_score_data(meta_lst)

    result_df = champion_stats_df.merge(meta_score_data, on=['championId', 'teamPosition'])
    result_df_copy = result_df.copy()
    result_df[['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions',
               'totalDamageTaken', 'timeCCingOthers', 'total_gold']] = result_df[['winRate', 'pickRate',
                                                                                  'banRate', 'kda',
                                                                                  'totalDamageDealtToChampions',
                                                                                  'totalDamageTaken', 'timeCCingOthers',
                                                                                  'total_gold']].apply(zscore)
    result_df['totalScore'] = result_df['winRate'] * 0.30 + result_df['pickRate'] * 0.25 + \
                              result_df['banRate'] * 0.15 + result_df['kda'] * 0.05 + \
                              result_df['totalDamageDealtToChampions'] * 0.05 + \
                              result_df['totalDamageTaken'] * 0.05 + result_df['timeCCingOthers'] * 0.05 + \
                              result_df['total_gold'] * 0.05
    result_df = pd.get_dummies(result_df, columns=['teamPosition'])

    model = joblib.load('championTierPredictionModel2.pkl')  # 모델 로드

    predictions = model.predict(result_df)  # 예측 수행

    result_df['tier'] = predictions  # 예측 결과를 'tier' 컬럼으로 추가

    columns_to_consider = ['teamPosition_BOTTOM', 'teamPosition_JUNGLE', 'teamPosition_MIDDLE', 'teamPosition_TOP',
                           'teamPosition_UTILITY']
    result_df['teamPosition'] = result_df[columns_to_consider].idxmax(axis=1)
    result_df['teamPosition'] = result_df['teamPosition'].str.replace('teamPosition_', '')  # 이진벡터값 다시 범주형으로 복원
    result_df = result_df[['championId', 'teamPosition', 'tier']]
    final_df = result_df_copy.merge(result_df, on=['championId', 'teamPosition'])
    final_df = final_df[['championId', 'teamPosition', 'winRate', 'pickRate', 'banRate', 'tier']]
    final_df = final_df[(final_df['winRate'] < 90) & (final_df['pickRate'] != 0)]

    return final_df

def insert_tier_data(x, conn):
    query = (
        f"INSERT INTO champion_tier (champion_id, team_position , win_rate ,"
        f" pick_rate,ban_rate ,tier) "
        f"VALUES ({x.championId}, {repr(x.teamPosition)},{x.winRate},{x.pickRate},{x.banRate},{x.tier})"
    )
    try:
        mu.mysql_execute(query, conn)
    except Exception as e:
        print(e)
    return


conn = mu.connect_mysql()
machine_learning_score.progress_apply(lambda x: insert_tier_data(x, conn), axis=1)
conn.commit()

# ----------------------------------------------------------------------------------------------------------------------
print("시작!")
print(f'총 데이터 갯수 : 796000 개')

batch_size = 100000
win_pick_lst_result = []
ban_rate_lst_result = []
meta_score_lst_result = []
cnt = 0
for limit in tqdm(range(0, 796000, batch_size)):
    conn = mu.connect_mysql()
    query = f"SELECT * FROM match_solr_rank LIMIT {limit}, {batch_size}"
    row = pd.DataFrame(mu.mysql_execute_dict(query, conn))
    conn.close()

    for _, player in tqdm(row.iterrows()):
        lst = []
        lst.append(player['championId'])
        lst.append(player['win'])
        lst.append(player['teamPosition'])
        win_pick_lst_result.append(lst)
        cnt += 1
    for _, player in tqdm(row.iterrows()):
        lst = []
        if player['ban_champion_id'] != 0 and player['ban_champion_id'] != -1:
            lst.append(player['teamPosition'])
            lst.append(player['ban_champion_id'])
            ban_rate_lst_result.append(lst)

    for _, player in tqdm(row.iterrows()):
        lst = []
        lst.append(player['championId'])
        lst.append(player['teamPosition'])
        lst.append(player['kda'])
        lst.append(player['totalDamageDealtToChampions'])
        lst.append(player['totalDamageTaken'])
        lst.append(player['timeCCingOthers'])
        lst.append(player['total_gold'])
        meta_score_lst_result.append(lst)

machine_learning_df = machine_learning_score(win_pick_lst_result, ban_rate_lst_result, meta_score_lst_result)
conn = mu.connect_mysql()
machine_learning_df.progress_apply(lambda x: insert_tier_data(x, conn), axis=1)
conn.commit()
print(f'총 데이터 갯수 : {cnt} 개')
print("끝!")

row.iloc[0]['total_gold']
sorted_df = machine_learning_df.sort_values(by=['tier'], ascending=True)