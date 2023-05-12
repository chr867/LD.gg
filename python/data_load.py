import time
import pandas as pd
from tqdm import tqdm
import my_utils as mu

def matches_timeline_data_select(count):
    start_time = time.time()
    conn = mu.connect_mysql()
    cursor = conn.cursor()
    cursor.close()
    print(f"총 {count}개 데이터 SELECT 시작합니다.")
    batch_size = 1000
    dfs = []
    count = 0
    for offset in tqdm(range(0, count, batch_size)):
        query = f'SELECT matches,timeline FROM match_raw LIMIT {batch_size} OFFSET {offset}'
        df = pd.read_sql(query, conn)
        dfs.append(df)
        count += 1000
        print(f"데이터 : {count}개")
        time.sleep(0.1)
    conn.close()

    df = pd.concat(dfs, ignore_index=True)
    end_time = time.time()
    print("데이터 SELECT 종료")
    print("데이터 로딩 시간 : {:.2f}초".format(end_time - start_time))
    return df

def matches_data_select(count):
    start_time = time.time()
    conn = mu.connect_mysql()
    cursor = conn.cursor()
    cursor.close()
    print(f"총 {count}개 데이터 SELECT 시작합니다.")
    batch_size = 1000
    dfs = []
    count = 0
    for offset in tqdm(range(0, count, batch_size)):
        query = f'SELECT matches FROM match_raw LIMIT {batch_size} OFFSET {offset}'
        df = pd.read_sql(query, conn)
        dfs.append(df)
        count += 1000
        print(f"데이터 : {count}개")
        time.sleep(0.1)
    conn.close()

    df = pd.concat(dfs, ignore_index=True)
    end_time = time.time()
    print("데이터 SELECT 종료")
    print("데이터 로딩 시간 : {:.2f}초".format(end_time - start_time))
    return df

def matches_data(count):
    print("데이터 SELECT 시작")
    conn = mu.connect_mysql()
    start_time = time.time()
    df = pd.DataFrame(mu.mysql_execute_dict(f"SELECT matches FROM match_raw LIMIT {count}", conn))
    conn.close()
    end_time = time.time()
    print("데이터로딩 시간: {:.2f}초".format(end_time - start_time))
    print("데이터 SELECT 종료")
    return df

def matches_timeline_data(count):
    conn = mu.connect_mysql()
    print("데이터 SELECT 시작")
    start_time = time.time()
    df = pd.DataFrame(mu.mysql_execute_dict(f"SELECT matches,timeline FROM match_raw LIMIT {count}", conn))
    conn.close()
    end_time = time.time()
    print("데이터로딩 시간: {:.2f}초".format(end_time - start_time))
    print("데이터 SELECT 종료")
    return df