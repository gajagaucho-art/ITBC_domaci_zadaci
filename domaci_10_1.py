#1
import pandas as pd
m = pd.read_parquet(R + 'matches_2025_26.parquet')

m.loc[(m['home_goals'] > 0) & (m['away_goals'] > 0)]

m.loc[(m['home_goals'] - m['away_goals'] == 1) & (m['home_goals'] > m['away_goals'])]

len(m.loc[(m['home_goals'] == 0) & (m['away_goals'] == 0)])

m['total_goals'] = m['home_goals'] + m['away_goals']

m.sort_values(['total_goals'], ascending=False).head(10)

#2

m = pd.read_parquet(R + 'matches_2025_26.parquet')

m = m.loc[(m['home_team'] == 'GMW') | (m['away_team'] == 'GMW')]

m.loc[(m['home_team'] == 'GMW') & (m['home_goals'] > m['away_goals'])]

m.loc[(m['home_team'] == 'GMW') & (m['home_goals'] <  m['away_goals'])]

m.loc[(m['home_team'] == 'GMW') & (m['home_goals'] == m['away_goals'])]

m.loc[(m['away_team'] == 'GMW') & (m['home_goals'] > m['away_goals'])]

m.loc[(m['away_team'] == 'GMW') & (m['home_goals'] <  m['away_goals'])]

m.loc[(m['away_team'] == 'GMW') & (m['home_goals'] == m['away_goals'])]

m.loc[(m['away_team'] == 'GMW') & (m['home_goals']).sum()] #za ukupno golova mi ne radi dobro , vraca mi sve redove a  ocekujem jedan red sa uk golova
m.loc[(m['away_team'] == 'GMW') & (m['away_goals']).sum()] #za ukupno golova mi ne radi dobro , vraca mi sve redove a  ocekujem jedan red sa uk golova

m.loc[(m['home_team'] == 'GMW') | (m['away_team'] == 'GMW')].sort_values(['home_goals'], ascending=False).head(1)


#3
m = pd.read_parquet(R + 'matches_2025_26.parquet')

m['stadium'].unique()

m['stadium'].value_counts().head(1)

m.groupby('stadium')['attendance'].mean()

m.groupby('stadium')['attendance'].mean().sort_values(ascending=False).head(5)

# imam nejasnocu u drugom zadatku za sumiranje golova.