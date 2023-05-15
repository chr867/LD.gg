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
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import joblib

# RIOT-API-KEY
riot_api_key = 'RGAPI-14667a4e-7c3c-45fa-ac8f-e53c7c3f5fe1'
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)
# ----------------------------------------------------------------------------------------------------------------------
start_time = time.time()
df = dl.match_raw_patch(40000)
print("JSON 변환 시작")
df['matches'] = df['matches'].apply(json.loads)
df['timeline'] = df['timeline'].apply(json.loads)
end_time = time.time()
print("변환 시간: {:.2f}초".format(end_time - start_time))
print("JSON 변환 종료")


# ----------------------------------------------------------------------------------------------------------------------
def champion_stats(df):
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
    # result_df = result_df[result_df['pickCount'] > 10]
    # Z-score 계산
    result_df[['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions',
               'totalDamageTaken', 'timeCCingOthers', 'total_gold']] = result_df[['winRate', 'pickRate',
                                                                                  'banRate', 'kda',
                                                                                  'totalDamageDealtToChampions',
                                                                                  'totalDamageTaken', 'timeCCingOthers',
                                                                                  'total_gold']].apply(zscore)
    # Z-score를 이용한 스코어 계산
    result_df['totalScore'] = result_df['winRate'] * 0.30 + result_df['pickRate'] * 0.25 + \
                              result_df['banRate'] * 0.15 + result_df['kda'] * 0.05 + \
                              result_df['totalDamageDealtToChampions'] * 0.05 + \
                              result_df['totalDamageTaken'] * 0.05 + result_df['timeCCingOthers'] * 0.05 + \
                              result_df['total_gold'] * 0.05

    conditions = [
        (result_df['totalScore'] >= 2),
        (result_df['totalScore'] >= 1.5) & (result_df['totalScore'] < 2),
        (result_df['totalScore'] >= 0.5) & (result_df['totalScore'] < 1),
        (result_df['totalScore'] >= 0) & (result_df['totalScore'] < 0.5),
        (result_df['totalScore'] < 0),
        (result_df['totalScore'] < -0.5)
    ]
    labels = ['OP', '1', '2', '3', '4', '5']
    result_df['tier'] = np.select(conditions, labels, default='5')

    return result_df


champion_stats = champion_stats(df)

sort_stats = champion_stats.sort_values(by=['tier'], ascending=False)
# One-Hot Encoding
champion_stats = pd.get_dummies(champion_stats, columns=['teamPosition'])

# 특성과 레이블 분리
X = champion_stats.drop('tier', axis=1)  # 'tier' 열을 제외한 모든 열을 특성으로 사용
y = champion_stats['tier']  # 'tier' 열을 레이블로 사용

# 학습 데이터와 테스트 데이터 분리
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 랜덤 포레스트 분류기 학습
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# 예측 및 평가
y_pred = model.predict(X_test)
print('Accuracy: ', accuracy_score(y_test, y_pred))

# 모델 저장
joblib.dump(model, 'tierMachineLearning.pkl')


# ----------------------------------------------------------------------------------------------------------------------

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
        df = pd.DataFrame(result, columns=columns)
        df['win'] = df['win'].astype(int)
        groupBy_df = df.groupby(['championId', 'teamPosition']).agg({'win': ['sum', 'count']})
        groupBy_df.columns = ['winCount', 'pickCount']
        groupBy_df['lineTotalCount'] = groupBy_df.groupby('teamPosition')['pickCount'].transform('sum')  # 각 라인별 총 픽수 계산
        groupBy_df['winRate'] = round((groupBy_df['winCount'] / groupBy_df['pickCount']) * 100, 2)
        groupBy_df['pickRate'] = round((groupBy_df['pickCount'] / groupBy_df['lineTotalCount']) * 100,
                                       2)  # 각 라인별 pickRate 계산
        groupBy_df = groupBy_df.reset_index()  # 인덱스 재설정
        # groupBy_df = groupBy_df[['championId', 'teamPosition', 'winRate', 'pickRate']]  # 열 순서 조정
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
        df = pd.DataFrame(result, columns=columns)
        ban_rate_df = df.groupby(['teamPosition', 'championId']).size().reset_index(name='banCount')

        ban_rate_df['banPositionTotal'] = ban_rate_df.groupby('teamPosition')['banCount'].transform('sum')
        ban_rate_df['banRate'] = round((ban_rate_df['banCount'] / ban_rate_df['banPositionTotal']) * 100, 2)
        ban_rate_df = ban_rate_df.dropna()
        # ban_rate_df = ban_rate_df[['teamPosition', 'championId', 'banRate']]

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
                result.append(lst)

        columns = ['championId', 'teamPosition', 'kda', 'totalDamageDealtToChampions', 'totalDamageTaken',
                   'timeCCingOthers']

        meta_score_df = pd.DataFrame(result, columns=columns)

        meta_score_df = meta_score_df.groupby(['championId', 'teamPosition']).mean().reset_index()

        return meta_score_df

    meta_score_data = meta_score_data(df)

    result_df = champion_stats_df.merge(meta_score_data, on=['championId', 'teamPosition'])
    result_df = result_df[result_df['pickCount'] > 10]
    # Z-score 계산
    result_df[['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions', 'totalDamageTaken',
               'timeCCingOthers']] = result_df[['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions',
                                                'totalDamageTaken', 'timeCCingOthers']].apply(zscore)

    # Z-score를 이용한 스코어 계산
    result_df['totalScore'] = result_df['winRate'] * 0.35 + result_df['pickRate'] * 0.25 + \
                              result_df['banRate'] * 0.2 + result_df['kda'] * 0.05 + \
                              result_df['totalDamageDealtToChampions'] * 0.05 + \
                              result_df['totalDamageTaken'] * 0.05 + result_df['timeCCingOthers'] * 0.05

    # totalScore를 이용하여 티어 분류
    # result_df['tier'] = pd.qcut(result_df['totalScore'], [0, .20, .40, .60, .80, .95, 1.],
    #                           labels=['5', '4', '3', '2', '1', 'OP'])

    return result_df


machine_learning_score = machine_learning_score(df)

# One-Hot Encoding
encoding_df = pd.get_dummies(machine_learning_score, columns=['teamPosition'])
# 모델 로드
model = joblib.load('tierMachineLearning.pkl')
encoding_df = encoding_df.drop('tier', axis=1)  # 'tier' 열 제거
predictions = model.predict(encoding_df)  # 예측 수행

# 예측 결과를 'tier' 컬럼으로 추가
encoding_df['tier'] = predictions

testttt = encoding_df.sort_values('tier', ascending=True)
print(machine_learning_score.columns)

# ----------------------------------------------------------------------------------------------------------------------
