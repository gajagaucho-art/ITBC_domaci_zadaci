#1
def safe_divide(a: float, b: float) -> float | None:
    try: 
        return a/b
    except ZeroDivisionError:
        return None
    
print(safe_divide(10,2))
print(safe_divide(10,0))


#2
def safe_int(value: str) -> int | None:
  try:
    return int(value)
  except ValueError:
    return None
  
print(safe_int('25'))
print(safe_int('-10'))
print(safe_int('abc'))

#3
def get_grade(grades: dict, student: str) -> int | None:
    try:
        return grades[student]
    except KeyError:
        return None
    
print(get_grade({'Ana': 5, 'Marko': 4, 'Jovana': 5}, 'Marko'))
print(get_grade({'Ana': 5, 'Marko': 4, 'Jovana': 5}, 'Petar'))


#4
def read_file(path: str) -> str:
    try:
        with open(path, 'r') as file:
            return file.read()
    except FileNotFoundError:
        return 'File not found.'
    
print(read_file('../python_it_bootcamp/data/processed/raw/teams.csv'))
print('-----------------------------------------')
print(read_file('../python_it_bootcamp/data/processed/raw/employees_test.csv'))


#5
def sum_numbers(values: list) -> float:
    total = 0
    for value in values:
        try:
            total += float(value)
        except ValueError:
            continue
    return total

print(sum_numbers(['10', '7.5', 'abc', '3', 'Zdravo']))


#6
def get_age(csv_line: str) -> int | None:
  try:
    name, age = csv_line.split(',')
    return int(age)
  except ValueError:
    return None
  
print(get_age('Ana,22'))
print(get_age('Marko,abc'))
print(get_age('Jovana'))