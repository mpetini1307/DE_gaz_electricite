import requests
import pandas as pd

url = "https://opendata.elia.be/api/explore/v2.1/catalog/datasets/ods032/records"
params = {"limit": 20}
response = requests.get(url, params=params)
data = response.json()

# Regarde la structure brute AVANT de la transformer
print(data['results'][0])