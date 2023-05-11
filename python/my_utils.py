import pandas as pd
import pymysql
import requests

seoul_api_key = '77676c6c566368723431555642674c'
riot_api_key = 'RGAPI-3c09d778-af7b-4f6b-94b4-e7784679bc11'

# mysql


def connect_mysql():
    mysql_conn = pymysql.connect(host='112.218.158.250', user='test_user', password='1234', db='my_db', charset='utf8',
                                 port=4000)
    return mysql_conn


def mysql_execute(query, mysql_conn):
    mysql_cursor = mysql_conn.cursor()
    mysql_cursor.execute(query)
    result = mysql_cursor.fetchall()
    return result


def mysql_execute_dict(query, mysql_conn):
    mysql_cursor = mysql_conn.cursor(cursor=pymysql.cursors.DictCursor)
    mysql_cursor.execute(query)
    result = mysql_cursor.fetchall()
    return result

def match_timeline(summoner_name, num):

    def get_puuid(summoner_name_p):
        summoner_get_url = f'https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/{summoner_name_p}?api_key={riot_api_key}'
        summoner_get_res = requests.get(summoner_get_url).json()
        summoner_puuid = summoner_get_res['puuid']
        result_p = get_matches_id(summoner_puuid)
        return result_p

    def get_matches_id(puuid):
        get_matches_url = f'https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/{puuid}/ids?type=ranked&start=0&count={num}&api_key={riot_api_key}'
        get_matches_res = requests.get(get_matches_url).json()
        result_p = get_match_info(get_matches_res)
        return result_p

    def get_match_info(match_id):
        get_match_url = f'https://asia.api.riotgames.com/lol/match/v5/matches/{match_id}?api_key={riot_api_key}'
        get_match_res = requests.get(get_match_url).json()
        get_timeline_url = f'https://asia.api.riotgames.com/lol/match/v5/matches/{match_id}/timeline?api_key={riot_api_key}'
        get_timeline_res = requests.get(get_timeline_url).json()
        result_p = {'match': get_match_res, 'timeline': get_timeline_res}
        return result_p

    result = get_puuid(summoner_name)
    return result


def get_puuid(user):
    url = f'https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/{user}?api_key={riot_api_key}'
    res = requests.get(url).json()
    puuid = res['puuid']
    return puuid


def get_match_id(puuid, num):
    url = f'https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/{puuid}/ids?type=ranked&start=0&count={num}&api_key={riot_api_key}'
    res = requests.get(url).json()
    return res


def get_matches_timelines(match_id):
    url1 = f'https://asia.api.riotgames.com/lol/match/v5/matches/{match_id}?api_key={riot_api_key}'
    res1 = requests.get(url1).json()
    url2 = f'https://asia.api.riotgames.com/lol/match/v5/matches/{match_id}/timeline?api_key={riot_api_key}'
    res2 = requests.get(url2).json()
    return res1, res2


