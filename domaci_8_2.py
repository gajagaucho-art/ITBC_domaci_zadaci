#19
import csv
def get_header(path: str) -> list:
  with open(path, 'r') as file:
    reader = csv.reader(file)
    return next(reader)
  
print(get_header('../python_it_bootcamp/data/processed/raw/teams.csv'))

#20
def read_rows(path: str) -> list:
  with open(path, 'r') as file:
    reader = csv.reader(file)
    next(reader)
    return [row for row in reader]
  
print(read_rows('../python_it_bootcamp/data/processed/raw/teams.csv'))

#21
def total_points(path: str) -> int:
  with open(path, 'r') as file:
    reader = csv.DictReader(file)
    return sum(int(row['points']) for row in reader)
  
print(total_points('../python_it_bootcamp/data/processed/raw/teams.csv'))

#22
def write_rows(path: str, rows: list) -> None:
  with open(path, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(rows)
  
write_rows('../python_it_bootcamp/data/processed/people.csv', [['name', 'age'], ['Ana', 20], ['Marko', 22]])
print(open('../python_it_bootcamp/data/processed/people.csv').read())

#23
def write_dicts(path: str, rows: list) -> None:
  with open(path, 'w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=rows[0].keys())
    writer.writeheader()
    writer.writerows(rows)
  
write_dicts('../python_it_bootcamp/data/processed/people.csv', [{'name': 'Ana', 'age': 20}, {'name':'Marko', 'age': 22}])
print(open('../python_it_bootcamp/data/processed/people.csv').read())