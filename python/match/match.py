import datetime
import time
import pandas as pd
import requests
from tqdm import tqdm
import my_utils as mu
import json
import multiprocessing as mp
import logging
tqdm.pandas()

sql_conn = mu.connect_mysql()

df = pd.DataFrame(mu.mysql_execute_dict('select * from match_raw', sql_conn))

