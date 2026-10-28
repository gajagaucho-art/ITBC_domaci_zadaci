--1
with utakmice as(
select 
t.team_name as klub,
m.home_goals as dati_golovi,
 m.kickoff_ts as datum
from matches m join teams t on m.home_team_id = t.team_id
where m.season = '2024/25'
union all
select 
t.team_name  as klub,
m.away_goals as dati_golovi,
 m.kickoff_ts as datum
from matches m join teams t on m.away_team_id = t.team_id
where m.season = '2024/25'
),
prosek_golova as (
    select klub,dati_golovi,datum,
    count(*) over (partition by klub order by klub, datum  rows between 4 preceding and current row ) as 5_utakmica,
    avg(dati_golovi) over (partition by klub order by datum rows between 4  preceding and current row) prosek_5utakmica
    from utakmice
)
select klub,dati_golovi,datum,5_utakmica, prosek_5utakmica
from prosek_golova
where 5_utakmica = 5 -- and klub = 'Valemont United'
order by prosek_5utakmica desc;   -- najveca je vrednost 4.2 ,ne znam zasto ali upit mi vraca 680 redova umesto 100 za 5 poslednjih utakmica, ako moze samo pojasnjenje kada  :) hvalaa

-- 2

with utakmice as(
select 
t.team_name as klub,
m.home_goals as dati_golovi,
 m.kickoff_ts as datum
from matches m join teams t on m.home_team_id = t.team_id
where m.season = '2024/25'
union all
select 
t.team_name  as klub,
m.away_goals as dati_golovi,
 m.kickoff_ts as datum
from matches m join teams t on m.away_team_id = t.team_id
where m.season = '2024/25'
),
ukupno_golova as (
select 
klub, dati_golovi,datum,
sum(dati_golovi) over(partition by klub order by datum rows between unbounded preceding and current row) uk_golova
from utakmice
)
select 
klub, dati_golovi,datum,uk_golova
from ukupno_golova
where uk_golova >= 50
order by datum  -- prvi do 50 golova je stigao Kingsbridge City 



--3
with utakmice as (
select 
m.kickoff_ts as datum,
t.team_name as klub,
s.stadium_name as stadion,
m.attendance as posecenost,
lag(m.attendance) over (partition by m.home_team_id, m.season order by m.kickoff_ts ) as prethodna_posecenost
from  matches m join teams t on m.home_team_id = t.team_id
join stadiums s on m.stadium_id = s.stadium_id
where m.season = '2024/25'
)
select klub,datum,stadion,prethodna_posecenost,posecenost,
    (posecenost - prethodna_posecenost) as promena_posecenosti
from utakmice
where prethodna_posecenost is not null and klub = 'Northport City'  -- najveca je promena u 11 kolu 

