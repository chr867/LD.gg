import json

import time
import pandas as pd
from tqdm import tqdm
import my_utils as mu


print("시작!")
conn = mu.connect_mysql()
df = pd.DataFrame(mu.mysql_execute_dict(f"SELECT matches,timeline FROM match_raw WHERE match_id_substr = '6491267281'", conn))
conn.close()
df['matches'] = df['matches'].apply(json.loads)
df['timeline'] = df['timeline'].apply(json.loads)
print("종료")

conn = mu.connect_mysql()
first = pd.DataFrame(mu.mysql_execute_dict(f"SELECT match_id_substr FROM match_raw LIMIT 0,100", conn))
conn.close()
conn = mu.connect_mysql()
second = pd.DataFrame(mu.mysql_execute_dict(f"SELECT match_id_substr FROM match_raw LIMIT 100,100", conn))
conn.close()
merged = pd.merge(first, second, on='match_id_substr', how='inner')
if merged.empty:
    print("겹치는 값이 없습니다.")
else:
    print("겹치는 값이 있습니다.")


print("시작!")
conn = mu.connect_mysql()
matchId_count = pd.DataFrame(mu.mysql_execute_dict(f"SELECT match_id_substr FROM match_raw", conn))
conn.close()
print(f'매치아이디 갯수 : {len(matchId_count.match_id_substr.unique())}개')
rune_list = []

batch_size = 1000

for limit in tqdm(range(0, len(matchId_count.match_id_substr.unique()), batch_size)):
    conn = mu.connect_mysql()
    query = f"SELECT matches, timeline FROM match_raw LIMIT {limit}, {batch_size}"
    row = pd.DataFrame(mu.mysql_execute_dict(query, conn))
    conn.close()

    row['matches'] = row['matches'].apply(json.loads)
    row['timeline'] = row['timeline'].apply(json.loads)
    for x in tqdm(range(len(row))):
        participants = row.iloc[x]['matches']['participants']
        for summoner in participants:
            lst = []
            lst.append(summoner['championId'])
            lst.append(summoner['defense'])
            lst.append(summoner['flex'])
            lst.append(summoner['offense'])
            lst.append(summoner['style0'])
            for primaryRune in summoner['perks0']:
                lst.append(primaryRune)
            lst.append(summoner['style1'])
            for subStyleRune in summoner['perks1']:
                lst.append(subStyleRune)
            lst.append(summoner['win'])
            rune_list.append(lst)
    # time.sleep(0.5)

print(f'표본수 : {len(rune_list)}')

columns = ['championId', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID',
           'MAIN_SUB2_ID',
           'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID', 'WIN']

rune_df = pd.DataFrame(rune_list, columns=columns)
rune_df['WIN'] = rune_df['WIN'].astype(int)
print("룬데이터 데이터프레임 제작완료")
print("룬데이터 정제 시작")
new_df = rune_df[['championId', 'WIN']].join(rune_df.iloc[:, 1:12].apply(tuple, axis=1).rename('rune_combination'))

rune_count = new_df.groupby(['championId', 'rune_combination']).agg({'WIN': ['sum', 'size']}).reset_index()
rune_count.columns = ['championId', 'rune_combination', 'winCount', 'pickCount']
rune_count = rune_count.rename(columns={'WIN/sum': 'winCount', 'WIN/size': 'pickCount'})

top_runes = pd.concat(
    [rune_count.loc[rune_count['championId'] == cid].sort_values(by='pickCount', ascending=False)[:2] for cid in
     rune_count['championId'].unique()])
top_runes['winRate'] = round((top_runes['winCount'] / top_runes['pickCount']) * 100, 2)

top_runes[['FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID', 'MAIN_SUB1_ID', 'MAIN_SUB2_ID',
           'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID', 'SUB_SUB1_ID', 'SUB_SUB2_ID']] \
    = top_runes['rune_combination'].apply(pd.Series)
top_runes = top_runes.drop('rune_combination', axis=1)
new_column_order = ['championId', 'FRAGMENT1_ID', 'FRAGMENT2_ID', 'FRAGMENT3_ID', 'MAIN_KEYSTONE_ID',
                    'MAIN_SUB1_ID', 'MAIN_SUB2_ID', 'MAIN_SUB3_ID', 'MAIN_SUB4_ID', 'SUB_KEYSTONE_ID',
                    'SUB_SUB1_ID', 'SUB_SUB2_ID', 'winCount', 'pickCount', 'winRate']
top_runes = top_runes.reindex(columns=new_column_order)

total_game_df = rune_df.groupby(['championId']).agg({'WIN': ['count']})
total_game_df.columns = ['total_game']
total_game_df.reset_index(inplace=True)
merged_df = pd.merge(top_runes, total_game_df, on='championId')
merged_df['pickRate'] = round((merged_df['pickCount'] / merged_df['total_game']) * 100, 2)
final_df = merged_df.drop(columns=['total_game'])
print("룬데이터 정제 완료")
