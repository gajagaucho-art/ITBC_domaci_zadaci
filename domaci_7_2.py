#1

def celzijus_u_farenhajt(celzijus):
  return celzijus * 1.80 + 32  

print(celzijus_u_farenhajt(10))

#2
dani_u_nedelji  = ['Ponedeljak', 'Utorak', 'Sreda', 'Cetvrtak', 'Petak', 'Subota', 'Nedelja']

def dani(n):
    if n < 1 or n > 7:
        return 'Pogresan unos'
    else:
        return dani_u_nedelji[n-1]
    
print(dani(9))

#3 

lista = [-1,-5,-17,-28,-63]
def najveci_negativni_broj(lista):
    najveci_negativni = None
    for broj in lista:
        if broj < 0:
            if najveci_negativni is None or broj > najveci_negativni:
                najveci_negativni = broj
    return najveci_negativni
print(najveci_negativni_broj(lista))

#5
lista =[1,8,26,21,33,74]

def broj_parnih_elemenata(lista):
    broj_parnih = 0
    for broj in lista:
        if broj % 2 == 0:
            broj_parnih = broj_parnih + 1
    return broj_parnih

print(broj_parnih_elemenata(lista))


#6
import math
lista = [10,11,12,13,14,15,16,17,18,19]

def zbir_brojeva_deljivih_sa2_3(lista):
    suma = 0
    for broj in lista:
        if broj % 2 == 0 or broj % 3 == 0:
            suma = suma + broj
    return suma
print(zbir_brojeva_deljivih_sa2_3(lista))


