--0
select * from teams where team_name = 'Dunmore Celtic';

--1
-- u sezoni 2024/25, Dunmore Celtic je odigrao 
select  count(*) as `Odigrane utakmice`,
        t.team_name, t.team_id,
    sum(case when (m.home_team_id = t.team_id and m.home_goals > m.away_goals) or (m.away_team_id = t.team_id and m.away_goals > m.home_goals) then 1 else 0 end)  as Pobede,
    sum(case when (m.home_team_id = t.team_id and m.home_goals < m.away_goals) or (m.away_team_id = t.team_id and m.away_goals < m.home_goals) then 1 else 0 end)  as Porazi,
    sum(case when m.away_goals = m.home_goals then 1 else 0 end)  as Neresene,
    sum(case when m.home_team_id = t.team_id then m.home_goals else m.away_goals end) as `Dati golovi`,
    sum(case when m.home_team_id = t.team_id then m.away_goals else m.home_goals end) as `Primljeni golovi`,
    sum(
        case when (m.home_team_id = t.team_id and m.home_goals > m.away_goals) or (m.away_team_id = t.team_id and m.away_goals > m.home_goals) then 3
        when  (m.home_team_id = t.team_id and m.home_goals = m.away_goals) or (m.away_team_id = t.team_id and m.away_goals = m.home_goals) then 1
        else 0 end
    ) as Bodovi 
from matches m join teams t on m.home_team_id = t.team_id or  m.away_team_id = t.team_id
where m.season = '2024/25' and 
t.team_name = 'Dunmore Celtic'
group by t.team_name,t.team_id;

--2  Stadion Dunmore Celtic je bas krs ekipa , prosipali su bodovi i kod kuce i u gostima :) 
select 
count(*),
m.home_team_id,
t.team_name,
sum(case when m.home_team_id = t.team_id and m.home_goals > m.away_goals then 1 else 0 end) as pobede,
sum(case when m.home_goals = m.away_goals then 1 else 0 end) as neresene,
sum(case when m.home_team_id = t.team_id and m.home_goals < m.away_goals then 1 else 0 end) as porazi
from matches m join teams t on m.home_team_id = t.team_id
where m.season = '2024/25' and 
t.team_name = 'Dunmore Celtic'
group by m.home_team_id,t.team_name
union 
select 
count(*),
m.away_team_id,
t.team_name,
sum(case when m.away_team_id = t.team_id and m.away_goals > m.home_goals then 1 else 0 end) as pobede,
sum(case when m.away_goals = m.home_goals then 1 else 0 end) as neresene,
sum(case when m.away_team_id = t.team_id and m.away_goals < m.home_goals then 1 else 0 end) as porazi
from matches m join teams t on m.away_team_id = t.team_id
where m.season = '2024/25' and 
t.team_name = 'Dunmore Celtic'
group by m.away_team_id,t.team_name;

-- 
select   p.player_id,p.first_name, p.last_name,
    COUNT(e.event_id) as broj_golova
from match_events e
join teams t on e.team_id = t.team_id
join players p on e.player_id = p.player_id
join matches m on e.match_id = m.match_id
where t.team_name = 'Dunmore Celtic'
  and e.event_type = 'goal' or e.event_type = 'penalty_goal' and m.season = '2024/25'
group by p.player_id, p.first_name, p.last_name
order by  broj_golova desc
limit 3;
select  p.player_id,p.first_name, p.last_name,
    COUNT(e.event_id) as broj_asistencija
from match_events e
join teams t on e.team_id = t.team_id
join players p on e.related_player_id = p.player_id
join matches m on e.match_id = m.match_id
where t.team_name = 'Dunmore Celtic'  and m.season = '2024/25'
  and e.event_type = 'goal'
  and e.related_player_id is not null
group by  p.player_id, p.first_name, p.last_name
order by  broj_asistencija desc
limit 1;


--4 prosek kartona 1.71 ukljuujuci i crvene, a prosek za ligu je 1.83
SELECT 
    t.team_name,
    COUNT(DISTINCT m.match_id) AS odigrane_utakmice,
    SUM(CASE WHEN e.event_type = 'yellow_card' THEN 1 ELSE 0 END) AS zuti_kartoni,
    SUM(CASE WHEN e.event_type IN ('red_card', 'second_yellow') THEN 1 ELSE 0 END) AS crveni_kartoni,
    COUNT(e.event_id) AS ukupno_kartona,
    ROUND(CAST(COUNT(e.event_id) AS FLOAT) / COUNT(DISTINCT m.match_id), 2) AS prosek_kartona_po_mecu
FROM matches m
JOIN teams t ON t.team_id IN (m.home_team_id, m.away_team_id)
LEFT JOIN match_events e ON m.match_id = e.match_id 
                        AND e.team_id = t.team_id 
                        AND e.event_type IN ('yellow_card', 'red_card', 'second_yellow')
WHERE t.team_name = 'Dunmore Celtic'
  AND m.status = 'played'
group by  t.team_id, t.team_name;

select 
    COUNT(DISTINCT m.match_id) AS ukupno_utakmica_u_ligi,
    SUM(CASE WHEN e.event_type = 'yellow_card' THEN 1 ELSE 0 END) AS ukupno_zutih,
    SUM(CASE WHEN e.event_type IN ('red_card', 'second_yellow') THEN 1 ELSE 0 END) AS ukupno_crvenih,
    COUNT(e.event_id) AS ukupno_kartona,
    ROUND(CAST(COUNT(e.event_id) AS FLOAT) / COUNT(DISTINCT m.match_id), 2) AS prosek_po_utakmici_liga,
    ROUND(CAST(COUNT(e.event_id) AS FLOAT) / (COUNT(DISTINCT m.match_id) * 2), 2) AS prosek_po_timu_po_utakmici
FROM matches m
JOIN match_events e ON m.match_id = e.match_id
WHERE m.status = 'played'
  AND e.event_type IN ('yellow_card', 'red_card', 'second_yellow') and m.season = '2024/25';

--5 Dunmore Celticje imao samo jednog trenera Alan Pardew, i njegova statistika je 
select  ms.manager_name,
    count(m.match_id) AS odigrane_utakmice,
    sum(case 
        when (m.home_team_id = ms.team_id and m.home_goals > m.away_goals) or 
             (m.away_team_id = ms.team_id and m.away_goals > m.home_goals) then 1 
        else 0 
    end) as pobede,
    sum(case 
        when m.home_goals = m.away_goals then 1 
        else 0 
    end) as nereseno,
    SUM(case 
        when (m.home_team_id = ms.team_id and m.home_goals < m.away_goals) or 
             (m.away_team_id = ms.team_id and m.away_goals < m.home_goals) then 1 
        else 0 
    end) as porazi,
    SUM(case 
        when (m.home_team_id = ms.team_id and m.home_goals > m.away_goals) or 
             (m.away_team_id = ms.team_id and m.away_goals > m.home_goals) then 3
        when m.home_goals = m.away_goals then 1
        else 0
    end) AS osvojeni_bodovi,
    round(CAST(SUM(CASE 
        when (m.home_team_id = ms.team_id and m.home_goals > m.away_goals) or 
             (m.away_team_id = ms.team_id and m.away_goals > m.home_goals) then 3
        when m.home_goals = m.away_goals then 1
        else 0
    end) AS FLOAT) / COUNT(m.match_id), 2) AS prosek_bodova_po_mecu
FROM manager_spells ms
join teams t ON ms.team_id = t.team_id
join matches m ON (m.home_team_id = ms.team_id or m.away_team_id = ms.team_id)
where t.team_name = 'Dunmore Celtic'
  and m.season = '2024/25'
  and m.status = 'played'
  and m.kickoff_ts >= ms.start_date
  and (ms.end_date IS NULL or m.kickoff_ts <= ms.end_date)
GROUP BY ms.manager_name, ms.spell_id;

--6 najveca pobeda je 4:0

select 
    m.match_id,
    m.season,
    m.matchday,
    t_home.team_name AS home_team,
    t_away.team_name AS away_team,
    m.home_goals,
    m.away_goals,
    (case 
        when m.home_team_id = t.team_id THEN m.home_goals - m.away_goals
        else m.away_goals - m.home_goals
    END) AS gol_razlika
from matches m
join teams t ON t.team_name = 'Dunmore Celtic'
join teams t_home ON m.home_team_id = t_home.team_id
join teams t_away ON m.away_team_id = t_away.team_id
where (m.home_team_id = t.team_id OR m.away_team_id = t.team_id)
  and m.season = '2024/25'
  and m.status = 'played'
order by  gol_razlika desc
limit  1;
-- najveci poraz je 7 :1
SELECT 
    m.match_id,
    m.season,
    m.matchday,
    t_home.team_name AS home_team,
    t_away.team_name AS away_team,
    m.home_goals,
    m.away_goals,
    (CASE 
        WHEN m.home_team_id = t.team_id THEN m.home_goals - m.away_goals
        ELSE m.away_goals - m.home_goals
    END) AS gol_razlika
FROM matches m
JOIN teams t ON t.team_name = 'Dunmore Celtic'
JOIN teams t_home ON m.home_team_id = t_home.team_id
JOIN teams t_away ON m.away_team_id = t_away.team_id
WHERE (m.home_team_id = t.team_id OR m.away_team_id = t.team_id)
  AND m.season = '2024/25'
  AND m.status = 'played'
ORDER BY gol_razlika ASC
LIMIT 1;
--  7 ima 1 utakmica bez podataka, , prosecna poseta je 18520.68 , a procenat je 87.05
SELECT 
    COUNT(m.match_id) AS ukupno_utakmica,
    SUM(CASE WHEN m.attendance IS NULL THEN 1 ELSE 0 END) AS utakmice_bez_podataka,
    ROUND(AVG(m.attendance), 2) AS prosecna_poseta,
    ROUND(AVG(CAST(m.attendance AS FLOAT) / s.capacity) * 100, 2) AS prosecna_popunjenost_procenti
FROM matches m
JOIN teams t ON t.team_name = 'Dunmore Celtic'
JOIN stadiums s ON m.stadium_id = s.stadium_id
WHERE (m.home_team_id = t.team_id OR m.away_team_id = t.team_id)
  AND m.season = '2024/25'
  AND m.status = 'played';