--1
select 
e.player_id, concat(p.first_name,  ' ' , p.last_name) as igrac,
count(*) as golovi,
DENSE_RANK() OVER (ORDER BY count(*) DESC) AS lista_strelaca
from match_events e join matches m on e.match_id = m.match_id
join players p on e.player_id = p.player_id
where m.season = '2024/25' and e.event_type in ('goal','penalty_goal')
group by e.player_id,p.first_name, p.last_name
order by golovi desc;



--2

with golovi as (
select
t.team_id,
t.team_name,
concat(p.first_name, ' ',p.last_name) as igrac,
p.player_id,
count(e.match_id) as uk_golova
from matches m join match_events e on m.match_id = e.match_id
join players p on e.player_id = p.player_id
join teams t on e.team_id = t.team_id
where m.season = '2024/25' and e.event_type in ('goal','penalty_goal')
group by t.team_id,t.team_name,p.player_id,p.first_name,p.last_name
),
rangiranje_igraca as (
select 
team_name,
igrac,
uk_golova,
row_number() over (partition by team_name order by uk_golova desc) strelci_po_timu
from golovi
)

select 
team_name,
igrac,
uk_golova
from rangiranje_igraca
where strelci_po_timu <= 3 order by team_name, uk_golova desc;

--3
with utakmice as (
select 
t.team_name as klub,
m.kickoff_ts as datum,
m.home_goals as dati_golovi
from matches m join teams t on m.home_team_id = t.team_id
where m.season = '2024/25'
union all
select 
t.team_name as klub,
m.kickoff_ts as datum,
m.away_goals as dati_golovi
from matches m join teams t on m.away_team_id = t.team_id
where m.season = '2024/25'
),
golovi_prethodna_utakmica as (
select  klub,datum, dati_golovi, lag(dati_golovi) over ( partition by klub order by datum) as golovi_prethodna_utakmica
from utakmice
)
select  klub,datum,dati_golovi,
golovi_prethodna_utakmica,
(dati_golovi - golovi_prethodna_utakmica) as razlika_golova
from golovi_prethodna_utakmica
order by klub, datum;