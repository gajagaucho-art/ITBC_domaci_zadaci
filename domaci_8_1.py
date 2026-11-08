#1 
def get_even_positions(data: tuple) -> tuple:
  return tuple(data[i] for i in range(0, len(data), 2))
  
print(get_even_positions((10, 20, 30, 40, 50, 60)))


#2
def find_exclusive_students(group1: set, group2: set) -> set:
  return group1 - group2
  
print(find_exclusive_students({'Ana', 'Marko', 'Jovan', 'Milica'}, {'Marko', 'Milica', 'Petar'}))

#3
def clean_tags(text: str) -> str:
  return '-'.join(tag.strip().lower() for tag in text.split('|'))
  
print(clean_tags(' Python | DATA | SQL '))

#4
def count_products(csv_lines: list) -> dict:
  products = {}
  for line in csv_lines[1:]:
    customer, product, quantity = line.split(',')
    if product in products:
      products[product] += int(quantity)
    else:
        products[product] = int(quantity)
  return products
  
print(count_products(['customer,product,quantity','Alice,laptop,2', 'Bob,mouse,3','Alice,laptop,1','Charlie,keyboard,2','Bob,mouse,1']))