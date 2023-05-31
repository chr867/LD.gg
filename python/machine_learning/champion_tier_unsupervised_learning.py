# --------------------------------------------------------
# Package
import pandas as pd
from matplotlib import pyplot as plt, cm
from sklearn.decomposition import PCA
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
from sklearn.preprocessing import StandardScaler, LabelEncoder, PolynomialFeatures
from sklearn.cluster import KMeans

from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, silhouette_score, \
    silhouette_samples
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix
from imblearn.under_sampling import RandomUnderSampler
from imblearn.over_sampling import SMOTE
import joblib
from sklearn.preprocessing import MinMaxScaler
from sklearn.preprocessing import StandardScaler

# # RIOT-API-KEY
# riot_api_key = 'RGAPI-14667a4e-7c3c-45fa-ac8f-e53c7c3f5fe1'
# pd.set_option('display.max_columns', None)
# pd.set_option('display.max_rows', None)
# ----------------------------------------------------------------------------------------------------------------------
conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict(f"SELECT * FROM champion_tier", conn))
conn.close()

conn = mu.connect_mysql()
champion_info_df = pd.DataFrame(mu.mysql_execute_dict(f"SELECT champion_id,champion_kr_name FROM champion_info", conn))
conn.close()
champion_info_df = champion_info_df.rename(columns={'champion_id': 'championId'})
# ----------------------------------------------------------------------------------------------------------------------
# 모델 학습용 데이터 연산 코드
print("시작!")
conn = mu.connect_mysql()
matchId_count = pd.DataFrame(mu.mysql_execute_dict(f"SELECT match_id_substr FROM match_raw_patch", conn))
conn.close()
print(f'매치아이디 갯수 : {len(matchId_count.match_id_substr.unique())}개')

batch_size = 50000
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
result_df = champion_stats_df.merge(meta_score_df, on=['championId', 'teamPosition'])
print("끝")
# ----------------------------------------------------------------
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
# -------------------------------------------------------------------------------------------------------------------
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

champion_tier_df = machine_learning_score(win_pick_lst_result, ban_rate_lst_result, meta_score_lst_result)
champion_tier_df = champion_tier_df['tier'].astype(int)
learning_df = result_df.merge(ai_score_df,on=['championId', 'teamPosition'])
learning_df = learning_df.merge(champion_info_df, on=['championId'])

copy_df = learning_df.copy()
# -------------------------------------------------------------------------------------------------------------------
# 필요한 컬럼만 선택
selected_columns = ['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions', 'totalDamageTaken',
                    'timeCCingOthers', 'total_gold', 'aiScore']

X = copy_df[selected_columns]

# 데이터 스케일링
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)


# K-means 클러스터링
kmeans = KMeans(n_clusters=5, random_state=0)  # 클러스터의 수를 5으로 설정
kmeans.fit(X_scaled)

# 클러스터링 결과
clusters = kmeans.labels_

# 모델 저장
joblib.dump(kmeans, 'championTierPredictionModel4.pkl')


print('클러스터링 결과:', clusters)
copy_df['clusters'] = clusters
copy_df = copy_df[copy_df['pickRate'] >= 0.01]
copy_df['clusters'] = copy_df['clusters'].replace({1: 3, 2: 1, 3: 5, 0: 2})
# --------------------------------
# PCA로 데이터를 2차원으로 줄이기
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X_scaled)

# 클러스터의 중심점 구하기
centers = kmeans.cluster_centers_
centers_pca = pca.transform(centers)

# 시각화
plt.figure(figsize=(10, 10))
scatter = plt.scatter(X_pca[:, 0], X_pca[:, 1], c=clusters, cmap='viridis')
plt.scatter(centers_pca[:, 0], centers_pca[:, 1], c='red', marker='X')
plt.legend(*scatter.legend_elements(), title="Clusters")
plt.title('K-means Clustering with 2 dimensions')
plt.show()
# --------------------------------
n_clusters = 5
# 실루엣 스코어는 -1에서 1사이의 값을 가집니다. 높을수록 클러스터링이 잘 되었다는 것을 의미합니다.
silhouette_avg = silhouette_score(X_scaled, clusters)
print("For n_clusters =", n_clusters,
      "The average silhouette_score is :", silhouette_avg)

# 각 클러스터의 실루엣 스코어를 계산합니다.
sample_silhouette_values = silhouette_samples(X_scaled, clusters)

y_lower = 10
for i in range(n_clusters):
    # 클러스터 i에 속하는 데이터 포인트들의 실루엣 스코어를 수집하고 정렬합니다.
    ith_cluster_silhouette_values = sample_silhouette_values[clusters == i]
    ith_cluster_silhouette_values.sort()

    size_cluster_i = ith_cluster_silhouette_values.shape[0]
    y_upper = y_lower + size_cluster_i

    color = cm.nipy_spectral(float(i) / n_clusters)
    plt.fill_betweenx(np.arange(y_lower, y_upper),
                      0, ith_cluster_silhouette_values,
                      facecolor=color, edgecolor=color, alpha=0.7)

    # 클러스터 레이블을 중앙에 표시합니다.
    plt.text(-0.05, y_lower + 0.5 * size_cluster_i, str(i))

    y_lower = y_upper + 10  # 다음 클러스터를 위해 10의 공간을 남깁니다.

plt.title("The silhouette plot for the various clusters.")
plt.xlabel("The silhouette coefficient values")
plt.ylabel("Cluster label")

# 실루엣 평균값을 빨간 선으로 표시합니다.
plt.axvline(x=silhouette_avg, color="red", linestyle="--")

plt.yticks([])  # y축 눈금을 지웁니다.
plt.xticks([-0.1, 0, 0.2, 0.4, 0.6, 0.8, 1])

plt.show()
# ----------------------------------------------------------------
# 클러스터의 수를 바꿔가며 KMeans를 수행하고 SSE를 저장합니다
sse = []
for i in range(1, 11):
    kmeans = KMeans(n_clusters=i, random_state=0)
    kmeans.fit(X_scaled)
    sse.append(kmeans.inertia_)  # kmeans.inertia_는 SSE를 의미합니다

# 클러스터의 수에 따른 SSE를 시각화합니다
plt.plot(range(1, 11), sse)
plt.title('Elbow Method')
plt.xlabel('Number of clusters')
plt.ylabel('SSE')
plt.show()
# -------------------------------------------------------------------------------------------------------------------
feature = ['winRate', 'pickRate', 'banRate', 'kda', 'totalDamageDealtToChampions',
           'totalDamageTaken', 'timeCCingOthers', 'total_gold','ai_score','tier']

# 지도학습으로 랜덤 포레스트 분류기 모델 사용

# One-Hot Encoding
# 머신러닝에 맞게 이진벡터 변환
champion_tier_machine_learning = pd.get_dummies(champion_tier_machine_learning, columns=['teamPosition'])

# 특성
X = champion_tier_machine_learning.drop('tier', axis=1)  # 'tier' 열을 제외한 모든 열을 특성으로 사용
# 레이블
y = champion_tier_machine_learning['tier']  # 'tier' 열을 레이블로 사용

# MinMaxScaler 정규화
scaler = MinMaxScaler()
X = scaler.fit_transform(X)

# SMOTE 적용
# OP티어와 1티어 클래스의 학습 데이터가 극단적으로 부족하여 클래스 불균형이 일어나 해소하기 위하여 이를 해결하기 위해
# SMOTE를 이요하여 소수 클래스 샘플을 합성하여 데이터를 증강하는 과대표집 기법을 사용하여 문제 해결
sm = SMOTE(k_neighbors=4, random_state=42)
X_res, y_res = sm.fit_resample(X, y)

# 학습 데이터와 테스트 데이터 분리
X_train, X_test, y_train, y_test = train_test_split(X_res, y_res, test_size=0.2, random_state=42)

# 랜덤 포레스트 분류기 학습
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# 예측 및 평가
y_pred = model.predict(X_test)
print('정확성 : ', accuracy_score(y_test, y_pred))

# 예측값(y_pred)과 실제값(y_test)을 이용해 정밀도, 재현율, F1 점수를 측정
# F1 점수는 정밀도와 재현율의 조화 평균으로 계산
# F1 점수는 0부터 1까지의 범위를 가지며, 1에 가까울수록 모델의 분류 성능이 우수하다는 것을 나타냄
print(classification_report(y_test, y_pred))
# Confusion Matrix
print(confusion_matrix(y_test, y_pred))
# 교차 검증
scores = cross_val_score(model, X_res, y_res, cv=10)
# 교차 검증 결과 출력
print("교차 검증 결과 리스트:", scores)
print("교차 검증 평균:", scores.mean())
joblib.dump(model, 'championTierPredictionModel3.pkl')
# -------------------------------------------------------------
def insert_tier_data(x, conn):
    query = (
        f"INSERT INTO champion_tier (champion_id, team_position , win_rate ,"
        f" pick_rate,ban_rate ,tier,ai_score) "
        f"VALUES ({x.championId}, {repr(x.teamPosition)},{x.winRate},{x.pickRate},{x.banRate},{x.clusters},{x.aiScore})"
    )
    try:
        mu.mysql_execute(query, conn)
    except Exception as e:
        print(e)
    return

conn = mu.connect_mysql()
copy_df.progress_apply(lambda x: insert_tier_data(x, conn), axis=1)
conn.commit()