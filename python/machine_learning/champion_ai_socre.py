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

from sklearn.model_selection import train_test_split, cross_val_score, GridSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix
from imblearn.under_sampling import RandomUnderSampler
from imblearn.over_sampling import SMOTE
import joblib
from sklearn.preprocessing import MinMaxScaler
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import GridSearchCV
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
# AI_SCORE
result_df['aiScore'] = result_df['winRate'] * 0.30 + result_df['pickRate'] * 0.25 + \
                        result_df['banRate'] * 0.15 + result_df['kda'] * 0.05 + \
                        result_df['totalDamageDealtToChampions'] * 0.05 + \
                        result_df['totalDamageTaken'] * 0.05 + result_df['timeCCingOthers'] * 0.05 + \
                        result_df['total_gold'] * 0.05

# MinMaxScaler를 이용해 0과 100 사이로 AI_SCORE를 변환합니다.
scaler = MinMaxScaler(feature_range=(0, 100))
result_df['aiScore'] = scaler.fit_transform(result_df[['aiScore']])

# 기준을 10% 낮추고 정수로 변환
result_df['aiScore'] = (result_df['aiScore'] + 10).clip(lower=0).astype(int)
champion_ai_score = result_df.copy()
# ----------------------------------------------------------------
X = champion_ai_score.drop(['aiScore', 'championId', 'teamPosition'], axis=1)  # aiScore, championId, teamPosition을 제외한 모든 피처를 사용
y = champion_ai_score['aiScore']  # aiScore가 목표 변수
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 그래디언트 부스팅 회귀 모델 생성
gbr = GradientBoostingRegressor(n_estimators=100, learning_rate=0.1, max_depth=1, random_state=42)

# 모델 학습
gbr.fit(X_train, y_train)

# 학습된 모델로 테스트 데이터에 대한 예측 수행
predictions = gbr.predict(X_test)

# 모델 성능 평가 (RMSE)
mse = mean_squared_error(y_test, predictions)
rmse = np.sqrt(mse)
print("RMSE: ", rmse)

scores = cross_val_score(gbr, X, y, cv=5, scoring='neg_mean_squared_error')
rmse_scores = np.sqrt(-scores)
print("Mean: ", rmse_scores.mean())
print("Standard deviation: ", rmse_scores.std())

param_grid = {'n_estimators': [50, 100, 200], 'max_depth': [1, 2, 3], 'learning_rate': [0.1, 0.05, 0.01]}
grid_search = GridSearchCV(gbr, param_grid, cv=5, scoring='neg_mean_squared_error')
grid_search.fit(X, y)