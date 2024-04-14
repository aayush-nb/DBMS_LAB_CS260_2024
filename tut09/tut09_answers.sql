SELECT player_name FROM players
WHERE batting_hand = 'left' AND country_name = 'England'
ORDER BY player_name;

SELECT player_name, TIMESTAMPDIFF(YEAR, dob, '2018-12-02') AS player_age
FROM players
WHERE TIMESTAMPDIFF(YEAR, dob, '2018-12-02') >= 28
AND bowling_skill = 'Legbreak googly'
ORDER BY player_age DESC, player_name;

SELECT match_id, toss_winner
FROM matches
WHERE toss_decision = 'bat'
ORDER BY match_id;

SELECT over_id, runs_scored
FROM ball_by_ball
WHERE match_id = 335987 AND runs_scored <= 7
ORDER BY runs_scored DESC, over_id;

SELECT DISTINCT p.player_name
FROM player_out po
JOIN players p ON po.player_out = p.player_id
WHERE po.kind_out = 'bowled'
ORDER BY p.player_name;

SELECT m.match_id, t1.name AS team_1, t2.name AS team_2, tw.name AS winning_team_name, m.win_margin
FROM matches m
JOIN teams t1 ON m.team_1 = t1.team_id
JOIN teams t2 ON m.team_2 = t2.team_id
JOIN teams tw ON m.match_winner = tw.team_id
WHERE m.win_margin >= 60
ORDER BY m.win_margin, m.match_id;

SELECT player_name FROM players
WHERE batting_hand = 'left' 
AND TIMESTAMPDIFF(YEAR, dob, '2018-12-02') < 30
ORDER BY player_name;

SELECT match_id, SUM(runs_scored) AS total_runs
FROM runs_scored
GROUP BY match_id
ORDER BY match_id;

SELECT rb.match_id, rb.over_id, MAX(rb.runs_scored) AS maximum_runs, p.player_name
FROM runs_scored rb
JOIN ball_by_ball bb ON rb.match_id = bb.match_id AND rb.over_id = bb.over_id
JOIN players p ON bb.bowler = p.player_id
GROUP BY rb.match_id, rb.over_id
ORDER BY rb.match_id, rb.over_id;

SELECT p.player_name, COUNT(*) AS number
FROM player_out po
JOIN players p ON po.player_out = p.player_id
WHERE po.kind_out = 'run out'
GROUP BY p.player_name
ORDER BY number DESC, p.player_name;

SELECT kind_out, COUNT(*) AS number
FROM player_out
GROUP BY kind_out
ORDER BY number DESC, kind_out;

SELECT t.name, COUNT(*) AS number
FROM matches m
JOIN teams t ON m.man_of_the_match = t.team_id
GROUP BY t.name
ORDER BY t.name;

SELECT venue
FROM extra_runs
GROUP BY venue
ORDER BY COUNT(*) DESC, venue
LIMIT 1;

SELECT venue
FROM matches
WHERE team_bowling = match_winner
GROUP BY venue
ORDER BY COUNT(*) DESC, venue;

SELECT p.player_name
FROM ball_by_ball bb
JOIN player_out po ON bb.match_id = po.match_id AND bb.over_id = po.over_id
JOIN players p ON bb.bowler = p.player_id
WHERE po.kind_out IS NOT NULL
GROUP BY bb.bowler
ORDER BY SUM(bb.runs_scored) / COUNT(*) ASC, p.player_name;

SELECT p.player_name, t.name
FROM player_role pr
JOIN players p ON pr.player_id = p.player_id
JOIN teams t ON pr.team_id = t.team_id
JOIN matches m ON pr.match_id = m.match_id
WHERE pr.role = 'CaptainKeeper' AND pr.team_id = m.match_winner
ORDER BY p.player_name;

SELECT p.player_name, SUM(rs.runs_scored) AS runs_scored
FROM runs_scored rs
JOIN players p ON rs.striker = p.player_id
GROUP BY p.player_name
HAVING SUM(rs.runs_scored) >= 50
ORDER BY runs_scored DESC, p.player_name;

SELECT p.player_name
FROM runs_scored rs
JOIN players p ON rs.striker = p.player_id
JOIN matches m ON rs.match_id = m.match_id
WHERE rs.runs_scored >= 100 AND m.match_winner != rs.team_batting
ORDER BY p.player_name;

SELECT m.match_id, m.venue
FROM matches m
JOIN teams t ON m.match_winner = t.team_id
WHERE t.name = 'KKR'
ORDER BY m.match_id;

SELECT p.player_name
FROM runs_scored rs
JOIN matches m ON rs.match_id = m.match_id
JOIN players p ON rs.striker = p.player_id
WHERE m.season_id = 5
GROUP BY p.player_name
ORDER BY SUM(rs.runs_scored) / COUNT(DISTINCT m.match_id) DESC, p.player_name
LIMIT 10;

