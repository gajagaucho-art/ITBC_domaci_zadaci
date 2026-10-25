--1 
select
m.match_id as mec, p.match_id
from matches m join player_match_stats p on m.match_id = p.match_id
where m.season = '2024/25'; -- ima 15200 redova, taj broj smo dobili jer su se redovi umnozili

--2
select p.player_id,p.first_name,p.last_name, m.season, count(distinct pm.team_id) as uk_timova
from player_match_stats pm join matches m on pm.match_id = m.match_id
join players p on pm.player_id = p. player_id 
group by p.player_id, p.first_name,p.last_name, m.season
having count(distinct pm.team_id) = 2; --35

--3
select (home_yellow_cards + away_yellow_cards) as zuti_kartoni
from matches_flat
where (home_yellow_cards + away_yellow_cards)  > (select 
avg(home_yellow_cards + away_yellow_cards) as avg_zutih_kartona
from matches_flat); -- 365 utakmica 

--4 
select 
p.player_id,p.first_name,p.last_name
from players p 
where p.player_id in (select pm.player_id
    from player_match_stats pm
    join matches m on pm.match_id = m.match_id
    where m.season = '2024/25'
    group by pm.player_id
    having count(pm.match_id) > 10); --483 igraca je igralo viose od 10 utakmica

-- 5
select 
m.home_team_id , t.team_name
from matches m join teams t on m.home_team_id = t.team_id
where m.season = '2024/25'
union 
select 
m.away_team_id , t.team_name
from matches m join teams t on m.away_team_id = t.team_id
where m.season = '2024/25';    -- ima 20 timova 

select 
m.home_team_id , t.team_name
from matches m join teams t on m.home_team_id = t.team_id
where m.season = '2024/25'
union  all
select 
m.away_team_id , t.team_name
from matches m join teams t on m.away_team_id = t.team_id
where m.season = '2024/25' ;  -- ima 760 redova zato sto union all kombinuje utakmice i klubove 



