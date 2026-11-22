#1
import requests

def get_space_station() -> dict:
    url = 'http://api.open-notify.org/iss-now.json'
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return data['iss_position']
    else:
        print(f'Error, status_code: {response.status_code}')

print(get_space_station())


#2
def get_universities(country: str) -> list:
    url = 'http://universities.hipolabs.com/search'
    response = requests.get(url, params={'country': country})
    if response.status_code == 200:
        data = response.json()
        return [university['name'] for university in data]
    else:
        print(f'Error, status_code: {response.status_code}')

print(get_universities('United States'))

#3

def get_exchange_rate(base: str, target: str) -> float:
  url = f"https://api.frankfurter.dev/v1/latest/{base}"
  response = requests.get(url)
  if response.status_code == 200:
    data = response.json()
    return data['rates'][target]
  else:
    print(f'Error, status_code: {response.status_code}')
    return None
print(get_exchange_rate("EUR", "RSD"))



