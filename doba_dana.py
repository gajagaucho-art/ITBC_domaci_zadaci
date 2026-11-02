# 1

for i in range(0,24,1):
    if i >= 6 and i <12:
        print('Jutro, '+str(i)+':00 casova')
    elif i >= 12 and i <18:
        print('Popodne, '+str(i)+':00 casova')
    elif i >= 18 and i < 22:
        print('Vece, '+str(i)+':00 casova')
    else: 
        print('Noc, '+str(i)+':00 casova')

print('------------------------------------')