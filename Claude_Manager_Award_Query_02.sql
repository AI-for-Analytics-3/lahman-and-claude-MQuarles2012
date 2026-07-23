WITH tsn_wins AS (
    SELECT playerid, yearid, lgid
    FROM awardsmanagers
    WHERE awardid = 'TSN Manager of the Year'
),
both_leagues AS (
    SELECT playerid
    FROM tsn_wins
    GROUP BY playerid
    HAVING COUNT(DISTINCT CASE WHEN lgid = 'AL' THEN 1 END) > 0
       AND COUNT(DISTINCT CASE WHEN lgid = 'NL' THEN 1 END) > 0
)
SELECT
    p.namefirst,
    p.namelast,
    w.yearid,
    w.lgid,
    m.teamid
FROM tsn_wins w
JOIN both_leagues b ON b.playerid = w.playerid
JOIN people p ON p.playerid = w.playerid
JOIN managers m
    ON m.playerid = w.playerid
   AND m.yearid = w.yearid
   AND m.lgid = w.lgid
WHERE w.lgid IN ('AL', 'NL')
ORDER BY p.namelast, p.namefirst, w.yearid;