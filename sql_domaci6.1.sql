--1
create or replace table dim_player as
select 
    player_id,
    first_name as ime,
    last_name as prezime,
    position as pozicija,
    nationality as nacionalnost
from players;

select * from dim_player; -- nova tabela nam vraca 681 red



--2
create or replace table dim_date as
select  cast(DATE_FORMAT(d, 'yyyyMMdd') as int) as date_key,
       d                                       as full_date,
       DATE_FORMAT(d, 'EEEE')                  as weekday_name,
       DAYOFWEEK(d) IN (1, 7)                  as is_weekend,
       case when MONTH(d) >= 7 then CONCAT(YEAR(d), '/', SUBSTRING(CAST(YEAR(d) + 1 as string), 3, 2))
            ELSE CONCAT(YEAR(d) - 1, '/', SUBSTRING(CAST(YEAR(d) as string), 3, 2))
       end                                     as season
from (select  EXPLODE(SEQUENCE(DATE'2023-07-01', DATE'2025-06-30', interval 1 day)) as d); 

create or replace table fact_player_match as
select 
pms.match_id,
DATE(m.kickoff_ts) as date_key,
pms.player_id,
pms.team_id,
pms.minutes_played,
pms.shots,
pms.passes,
pms.rating
from player_match_stats pms
join matches m on pms.match_id = m.match_id
where m.status = 'played';

select * from fact_player_match;  -- ova tabela ima 30400 redova , svaki red predstavlja ucinak i statistiku jednog igraca na utakmici

--3
select 
dp.pozicija as pozicija,
AVG(fpm.rating) as prosecna_ocena
from fact_player_match fpm
join dim_player dp on fpm.player_id = dp.player_id
join dim_date dd on fpm.date_key = dd.full_date
where dd.season = '2024/25' and fpm.rating is  not null
group by pozicija
order by prosecna_ocena desc;

--4
alter table fact_player_match add column goals int;

update fact_player_match
set goals = coalesce((
select count(*) 
from match_events me 
where  me.match_id = fact_player_match.match_id  and me.player_id = fact_player_match.player_id and me.event_type in ('goal', 'penalty_goal')), 0);

select sum(goals) as total_goals 
from fact_player_match; -- ukupno 2043 gola