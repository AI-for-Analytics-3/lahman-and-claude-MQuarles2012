WITH double_league_winners AS (
    SELECT playerid
    FROM awardsmanagers
    WHERE awardid = 'TSN Manager of the Year'
    GROUP BY playerid
    HAVING bool_or(lgid = 'NL') AND bool_or(lgid = 'AL')
)
SELECT
    am.yearid                      AS year,
    am.lgid                        AS league,
    p.namefirst                    AS first_name,
    p.namelast                     AS last_name,
    m.teamid                       AS team_id,
    t.name                         AS team_name
FROM awardsmanagers am
JOIN double_league_winners d
    ON d.playerid = am.playerid
JOIN managers m
    ON m.playerid = am.playerid
   AND m.yearid   = am.yearid
   AND m.lgid     = am.lgid
JOIN people p
    ON p.playerid = am.playerid
LEFT JOIN teams t
    ON t.yearid = am.yearid
   AND t.lgid   = am.lgid
   AND t.teamid = m.teamid
WHERE am.awardid = 'TSN Manager of the Year'
ORDER BY p.namelast, p.namefirst, am.yearid;