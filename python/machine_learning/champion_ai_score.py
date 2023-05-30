# --------------------------------------------------------
# Module
import pandas as pd
import seaborn as sns
from matplotlib import pyplot as plt
from sklearn.compose import ColumnTransformer
from sklearn.feature_selection import SelectKBest, f_regression
from sklearn.neighbors import KNeighborsRegressor
from sklearn.pipeline import Pipeline
from tqdm import tqdm
from xgboost import XGBRegressor
import my_utils as mu
import json
import time
import numpy as np
import plotly.offline as pyo
import plotly.graph_objs as go
import data_load as dl
from scipy.stats import zscore
from sklearn.preprocessing import StandardScaler, LabelEncoder, PolynomialFeatures, MinMaxScaler
from sklearn.cluster import KMeans
from sklearn.model_selection import RandomizedSearchCV, KFold, train_test_split, cross_val_score, GridSearchCV
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor, AdaBoostRegressor, StackingRegressor, GradientBoostingRegressor
from sklearn.metrics import make_scorer, mean_squared_error, accuracy_score, precision_score, recall_score, f1_score, mean_absolute_error, classification_report, confusion_matrix
from imblearn.under_sampling import RandomUnderSampler
from imblearn.over_sampling import SMOTE
import joblib
import xgboost as xgb
# --------------------------------------------------------
print("시작!")
conn = mu.connect_mysql()
matchId_count = pd.DataFrame(mu.mysql_execute_dict(f"SELECT match_id_substr FROM match_raw_patch", conn))
conn.close()
print(f'매치아이디 갯수 : {len(matchId_count.match_id_substr.unique())}개')

batch_size = 100000
win_pick_lst_result = []
ban_rate_lst_result = []
meta_score_lst_result = []
for limit in tqdm(range(0, len(matchId_count.match_id_substr.unique()), batch_size)):
    conn = mu.connect_mysql()
    query = f"SELECT matches FROM match_raw_patch LIMIT {limit}, {batch_size}"
    df = pd.DataFrame(mu.mysql_execute_dict(query, conn))
    conn.close()

    df['matches'] = df['matches'].apply(json.loads)


    for x in tqdm(range(len(df))):
        for player in df.iloc[x]['matches']['participants']:
            lst = []
            lst.append(player['championId'])
            lst.append(player['win'])
            lst.append(player['teamPosition'])  # 팀 포지션 추가
            win_pick_lst_result.append(lst)

    for x in tqdm(range(len(df))):
        ban_lst = df.iloc[x]['matches']['bans']
        for idx, ban in enumerate(ban_lst):
            if ban != 0 and ban != -1:
                lst = []
                team_position = df.iloc[x]['matches']['participants'][idx]['teamPosition']
                if team_position:
                    lst.append(team_position)
                    lst.append(ban)
                    ban_rate_lst_result.append(lst)

    for x in tqdm(range(len(df))):
        summoner = df.iloc[x]['matches']['participants']
        for player in summoner:
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
champion_stats_result_df = champion_stats_df.merge(meta_score_df, on=['championId', 'teamPosition'])
result_df = champion_stats_result_df.copy()
# ----------------------------------------------------------------
# Zscore 설정
result_df[['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions',
           'totalDamageTaken', 'timeCCingOthers', 'total_gold']] = result_df[['winRate', 'pickRate',
                                                                              'banRate', 'kda',
                                                                              'totalDamageDealtToChampions',
                                                                              'totalDamageTaken', 'timeCCingOthers',
                                                                              'total_gold']].apply(zscore)
# AI_SCORE
result_df['aiScore'] = result_df['winRate'] * 0.30 + result_df['pickRate'] * 0.25 + \
                        result_df['banRate'] * 0.15 + result_df['kda'] * 0.05 + \
                        result_df['totalDamageDealtToChampions'] * 0.05 + \
                        result_df['totalDamageTaken'] * 0.05 + result_df['timeCCingOthers'] * 0.05 + \
                        result_df['total_gold'] * 0.05

# MinMaxScaler를 이용해 0과 100 사이로 AI_SCORE를 변환합니다.
scaler = MinMaxScaler(feature_range=(0, 100))
result_df['aiScore'] = scaler.fit_transform(result_df[['aiScore']])

result_df['aiScore'] = result_df['aiScore'].astype(int)
champion_ai_score = result_df.copy()
# ---------------------------------------------------
# 클래스로 분류하는 Tier 와 다르게 AI SCORE 는 회귀모델을 사용하여 특성간의 상호작용을 머신러닝으로 조금 더 객관적으로 판단하여
# 점수로 부여 하였고 유저들이 Tier 와는 다른 데이터로 조금 더 챔피언에 대해서 객관적으로 판단할 수 있는 정보를 제공하기 위하여 개발
# 과적합을 줄이기 위한 정규화 기법과 트리 앙상블 방법을 결합한 강력한 모델로 Gradient Boosting 알고리즘을 기반으로 한
# XGBoost 라이브러리의 회귀 모델인 XGBRegressor 사용

# 'teamPosition' 열을 원-핫 인코딩(one-hot encoding)을 사용하여 범주형 피처로 변환
champion_ai_score = pd.get_dummies(champion_ai_score, columns=['teamPosition'])
# 데이터 준비
X = champion_ai_score.drop('aiScore', axis=1)  # 'aiScore' 열을 제외한 모든 열을 특성으로 사용
y = champion_ai_score['aiScore']

# MinMaxScaler를 사용하여 특성(X) 데이터를 정규화
scaler = MinMaxScaler()
X = scaler.fit_transform(X)

# PolynomialFeatures를 사용하여 상호작용 피처 추가
# 상호작용 피처 추가 전 교차검증 당시 일부 특성에 대해 낮은 정확도를 나타 내 균일한 정확도를 위해 피처 추가
# 상호작용 피처를 추가하면 각 피처들 간의 상호작용에 대한 정보를 추가로 얻을 수 있음
# 이를 통해 모델이 어떤 피처들이 서로 상호작용하여 영향을 미치는지 파악가능
poly = PolynomialFeatures(degree=2, interaction_only=True, include_bias=False)
X_interact = poly.fit_transform(X)

# 데이터 분할
X_train, X_val, y_train, y_val = train_test_split(X_interact, y, test_size=0.2, random_state=42)

# 모델 정의
# 최적의 하이퍼 파라미티 값을 찾아서 앙상블에 사용 할 트리의 개수, 각 트리의 기여 정도를 조절 하는 학습률,
# 각 트리의 최대 깊이, 모델의 학습 속도를 위한 학습시 샘플 비율, 모델의 재현성을 위한 난수시드 설정을 찾아 회귀 모델 정의
model = XGBRegressor(n_estimators=500, learning_rate=0.1, max_depth=2, subsample=0.6, random_state=42)

# 모델 학습
model.fit(X_train, y_train, early_stopping_rounds=10, eval_set=[(X_val, y_val)])

# 예측
y_pred = model.predict(X_val)

# 성능 평가
rmse = mean_squared_error(y_val, y_pred, squared=False)
mae = mean_absolute_error(y_val, y_pred)

# 결과 출력  RMSE(Root Mean Squared Error), MAE(Mean Absolute Error)
# RMSE는 예측값과 실제값 간의 차이를 제곱한 후 평균을 구한 후, 다시 제곱근을 취한 값
# MAE는 예측값과 실제값 간의 차이의 절댓값의 평균
print("RMSE:", rmse)
print("MAE:", mae)

# KFold 정의
#  데이터를 K개의 폴드로 나누고, 각 폴드를 한 번씩 검증 데이터로 사용하여 모델을 교차검증 평가
kfold = KFold(n_splits=10, shuffle=True, random_state=42)

# 교차 검증
scores = cross_val_score(model, X_interact, y, cv=kfold, scoring='neg_root_mean_squared_error')
rmse_scores = -scores

# 교차 검증 결과 출력
print("교차 검증 RMSE 점수: ", rmse_scores)
print("교차 검증 RMSE 평균 점수: ", rmse_scores.mean())

joblib.dump(model, 'championAiScorePredictionModel1.pkl')

# ---------------------------------------------------
def ai_score_df(win_pick_lst, ban_lst, meta_lst):
    def win_rate_pick_rate_data(result):
        columns = ['championId', 'win', 'teamPosition']
        win_pick_df = pd.DataFrame(result, columns=columns)
        win_pick_df['win'] = win_pick_df['win'].astype(int)
        groupBy_df = win_pick_df.groupby(['championId', 'teamPosition']).agg({'win': ['sum', 'count']})
        groupBy_df.columns = ['winCount', 'pickCount']
        groupBy_df['lineTotalCount'] = groupBy_df.groupby('teamPosition')['pickCount'].transform('sum')
        groupBy_df['winRate'] = round((groupBy_df['winCount'] / groupBy_df['pickCount']) * 100, 2)
        groupBy_df['pickRate'] = round((groupBy_df['pickCount'] / groupBy_df['lineTotalCount']) * 100, 2)
        groupBy_df = groupBy_df.reset_index()
        groupBy_df = groupBy_df[['championId', 'teamPosition', 'winRate', 'pickRate']]
        return groupBy_df

    win_rate_pick_rate_df = win_rate_pick_rate_data(win_pick_lst)

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

    champion_stats_df = win_rate_pick_rate_df.merge(ban_rate_df, on=['championId', 'teamPosition'])

    def meta_score_data(result):
        columns = ['championId', 'teamPosition', 'kda', 'totalDamageDealtToChampions', 'totalDamageTaken',
                   'timeCCingOthers', 'total_gold']
        meta_score_df = pd.DataFrame(result, columns=columns)

        meta_score_df = meta_score_df.groupby(['championId', 'teamPosition']).mean().reset_index()

        return meta_score_df

    meta_score_df = meta_score_data(meta_lst)

    result_df = champion_stats_df.merge(meta_score_df, on=['championId', 'teamPosition'])

    result_df[['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions',
               'totalDamageTaken', 'timeCCingOthers', 'total_gold']] = result_df[['winRate', 'pickRate',
                                                                                  'banRate', 'kda',
                                                                                  'totalDamageDealtToChampions',
                                                                                  'totalDamageTaken', 'timeCCingOthers',
                                                                                  'total_gold']].apply(zscore)
    result_df['aiScore'] = result_df['winRate'] * 0.30 + result_df['pickRate'] * 0.25 + \
                           result_df['banRate'] * 0.15 + result_df['kda'] * 0.05 + \
                           result_df['totalDamageDealtToChampions'] * 0.05 + \
                           result_df['totalDamageTaken'] * 0.05 + result_df['timeCCingOthers'] * 0.05 + \
                           result_df['total_gold'] * 0.05

    result_df = pd.get_dummies(result_df, columns=['teamPosition'])

    model = joblib.load('championAiScorePredictionModel1.pkl')

    X = result_df.drop('aiScore', axis=1)
    scaler = MinMaxScaler()
    X_scaled = scaler.fit_transform(X)

    poly = PolynomialFeatures(degree=2, interaction_only=True, include_bias=False)
    poly.fit(X_scaled)  # PolynomialFeatures를 적합시킵니다.

    X_interact = poly.transform(X_scaled)

    ai_scores = model.predict(X_interact)

    result_df['aiScore'] = ai_scores

    result_df['teamPosition'] = result_df[['teamPosition_BOTTOM', 'teamPosition_JUNGLE', 'teamPosition_MIDDLE',
                                           'teamPosition_TOP', 'teamPosition_UTILITY']].idxmax(axis=1)
    result_df['teamPosition'] = result_df['teamPosition'].str.replace('teamPosition_', '')

    final_df = result_df[['championId', 'teamPosition', 'aiScore']]
    final_df['aiScore'] = final_df['aiScore'].astype(int)
    return final_df

ai_score_df = ai_score_df(win_pick_lst_result, ban_rate_lst_result, meta_score_lst_result)


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
    # final_df = final_df[(final_df['winRate'] < 90) & (final_df['pickRate'] != 0)]

    return final_df

tier_df = machine_learning_score(win_pick_lst_result, ban_rate_lst_result, meta_score_lst_result)

tier_ai_score_df = tier_df.merge(ai_score_df,on=['championId', 'teamPosition'])

tessttt = tier_ai_score_df.sort_values(by=['aiScore'], ascending=False)

def insert_tier_data(x, conn):
    query = (
        f"INSERT INTO champion_tier (champion_id, team_position , win_rate ,"
        f" pick_rate,ban_rate ,tier,ai_score) "
        f"VALUES ({x.championId}, {repr(x.teamPosition)},{x.winRate},{x.pickRate},{x.banRate},{x.tier},{x.aiScore})"
    )
    try:
        mu.mysql_execute(query, conn)
    except Exception as e:
        print(e)
    return

conn = mu.connect_mysql()
tier_ai_score_df.progress_apply(lambda x: insert_tier_data(x, conn), axis=1)
conn.commit()