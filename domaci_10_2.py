#1
import numpy as np
import pandas as pd

sati = [f'Sat {i}' for i in range(1, 13)]
korisnici_arr = np.array([120, 145, 190, 260, 410, 530, 620, 595, 480, 390, 310, 215])
s = pd.Series(korisnici_arr, index=sati, name='Aktivni korisnici')
peti_sat_label = s.index[4]
peti_sat_broj = s.iloc[4]
poslednja_4_sata = s.iloc[-4:]
ukupno_korisnika = s.sum()
prosecan_broj = s.mean()
najveci_sat = s.idxmax()
najveci_broj = s.max()

print('Aktivni korisnici po satima:')
print(s)
print(f'Peti sat ({peti_sat_label}): {peti_sat_broj}')
print('Poslednja 4 sata: ',poslednja_4_sata)
print(f'Ukupno korisnika (12h): {ukupno_korisnika}')
print(f'Prosecan broj korisnika po satu: {prosecan_broj:.2f}')
print(f'Sat sa najvecim brojem korisnika: {najveci_sat} ({najveci_broj})')


#2
serveri = ['Server 1', 'Server 2', 'Server 3', 'Server 4', 'Server 5']
metrike = ['CPU', 'RAM', 'Disk']

metrika = np.array([
    [45.0, 62.5, 70.0],
    [78.0, 81.0, 65.5],
    [32.5, 48.0, 55.0],
    [88.5, 74.0, 82.0],
    [60.0, 55.5, 61.5]
])
df = pd.DataFrame(metrika, index=serveri, columns=metrike)
dimenzije = metrika.shape
broj_servera, broj_metrika = metrika.shape
prosek_po_metrici = df.mean(axis=0)
prosek_po_serveru = df.mean(axis=1)
najveci_server = prosek_po_serveru.idxmax()
najveci_prosek = prosek_po_serveru.max()
print('podaci o potrosnji resursa (%):')
print('dimenzije matrice:', dimenzije)
print(f'broj servera: {broj_servera}, Broj metrika: {broj_metrika}')
print('prosecna vrednost po metrici (%):')
print(prosek_po_metrici.round(2))
print('prosecna potrosnja po serveru (%):')
print(prosek_po_serveru.round(2))
print(f'server sa najvecom prosecnom potrosnjom: {najveci_server} ({najveci_prosek:.2f}%)')

#3
procesi = [f'Proces {i}' for i in range(1, 16)]
vreme_arr = np.array([
    25.0, 112.5, 45.0, 88.0, 140.2,
    19.5, 63.0, 105.0, 49.8, 95.4,
    31.2, 128.0, 72.5, 40.0, 15.0
])
s = pd.Series(vreme_arr, index=procesi, name='Trajanje (s)')
duze_od_100 = s[s > 100]
izmedju_40_i_100 = s[(s >= 40) & (s <= 100)]
broj_krace_od_50 = int((s < 50).sum())
pozicioni_indeksi_gt_100 = np.where(vreme_arr > 100)[0]
nazivi_gt_100 = duze_od_100.index.tolist()
prosecno_vreme = s.mean()

print('Trajanje procesa (s):')
print(s)
print('Procesi duzi od 100s:')
print(duze_od_100)
print('Procesi izmedju 40 i 100s:')
print(izmedju_40_i_100)
print(f'Broj procesa kracih od 50s: {broj_krace_od_50}')
print(f'Pozicioni indeksi (>100s): {pozicioni_indeksi_gt_100.tolist()}')
print(f'Nazivi procesa (>100s): {nazivi_gt_100}')
print(f'Prosecno vreme izvrsavanja: {prosecno_vreme:.2f} s')

#4
kategorije = ['Elektronika', 'Odeca', 'Kuca i basta', 'Sport']
meseci = ['Jan', 'Feb', 'Mar', 'Apr', 'Maj', 'Jun']

prihodi_arr = np.array([
    [12000, 13500, 14200, 12800, 15600, 17100],
    [8500,  9200,  11400, 12900, 13400, 14800],
    [6400,  7100,  7800,  8900,  9500,  10200],
    [5200,  5800,  6900,  7600,  8800,  10400]
], dtype=float)
df = pd.DataFrame(prihodi_arr, index=kategorije, columns=meseci)
ukupno_po_kategoriji = df.sum(axis=1)
ukupno_po_mesecu = df.sum(axis=0)
najveca_kategorija = ukupno_po_kategoriji.idxmax()
najveci_prihod_kat = ukupno_po_kategoriji.max()
najveci_mesec = ukupno_po_mesecu.idxmax()
najveci_prihod_mesec = ukupno_po_mesecu.max()
prosek_po_kategoriji = df.mean(axis=1)
prosecni_mesecni_prihod = ukupno_po_mesecu.mean()
print('Tabela prihoda po kategorijama i mesecima:')
print(df)
print('Ukupan prihod po kategoriji:')
print(ukupno_po_kategoriji)
print('Ukupan prihod po mesecu:')
print(ukupno_po_mesecu)
print(f'Kategorija sa najvecim ukupnim prihodom: {najveca_kategorija} ({najveci_prihod_kat:.2f})')
print(f'Mesec sa najvecim ukupnim prihodom: {najveci_mesec} ({najveci_prihod_mesec:.2f})')
print('Prosecan prihod po kategoriji:')
print(prosek_po_kategoriji.round(2))
print(f'Prosecan mesecni prihod svih kategorija: {prosecni_mesecni_prihod:.2f}')

#5
dani = [f'Dan {i}' for i in range(1, 16)]
temp_arr = np.array([
    12.5, np.nan, -25.0, 18.0, 54.5,
    8.2, 22.0, -20.0, 50.0, np.nan,
    15.4, 61.0, -3.5, -22.1, 19.8
], dtype=float)
s = pd.Series(temp_arr, index=dani, name='Temperatura (°C)')
nedostajuce_mask = s.isna()
nedostajuce_vrednosti = s[nedostajuce_mask]
nevalidne_mask = (~nedostajuce_mask) & ((s < -20) | (s > 50))
nevalidne_vrednosti = s[nevalidne_mask]
pozicioni_indeksi_nevalidni = np.where(nevalidne_mask.to_numpy())[0]
nazivi_dana_nevalidni = nevalidne_vrednosti.index.tolist()
broj_nedostajucih = int(nedostajuce_mask.sum())
broj_nevalidnih = int(nevalidne_mask.sum())
ukupno_zapisa = len(s)
broj_problematicnih = broj_nedostajucih + broj_nevalidnih
procenat_problematicnih = (broj_problematicnih / ukupno_zapisa) * 100
validne_mask = (~nedostajuce_mask) & (s >= -20) & (s <= 50)
validne_temperature = s[validne_mask]
validne_arr = validne_temperature.to_numpy()
prosecna_validna_temp = float(np.mean(validne_arr))

print('Svi dnevni zapisi (°C):')
print(s)
print('Nedostajuce vrednosti:')
print(nedostajuce_vrednosti)
print('Nevalidne temperature (< -20 ili > 50):')
print(nevalidne_vrednosti)
print(f'Pozicioni indeksi nevalidnih vrednosti: {pozicioni_indeksi_nevalidni.tolist()}')
print(f'Nazivi dana nevalidnih vrednosti: {nazivi_dana_nevalidni}')
print(f'Broj nedostajucih vrednosti: {broj_nedostajucih}')
print(f'Broj nevalidnih vrednosti: {broj_nevalidnih}')
print(f'Procenat nevalidnih i nedostajucih zajedno: {procenat_problematicnih:.2f}% ({broj_problematicnih}/{ukupno_zapisa})')
print('Novi niz validnih temperatura:')
print(validne_arr)
print(f'Prosecna validna temperatura: {prosecna_validna_temp:.2f} °C')