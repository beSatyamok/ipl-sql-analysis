create database ipl_stats;

use ipl_stats;
Create table matches(
match_id int primary key auto_increment,
season year,
match_date date,
team1 varchar(50),
team2 varchar(50),
venue varchar(100),
winner varchar(50),
player_of_match varchar(50),
toss_winner VARCHAR(50),
toss_decision VARCHAR(10));

create table teams(
teams_id int primary key auto_increment,
team_name varchar(50),
city varchar(50),
homeground varchar(100));

create table players(
player_id int primary key auto_increment,
player_name varchar(100),
teams_id int,
player_role varchar(50),
nationality varchar(50),
foreign key (teams_id) references teams(teams_id));

insert into teams (team_name, city, homeground) Values
('Mumbai Indians', 'Mumbai', 'Wankhade Stadium'),
('Chennai Super Kings', 'Chennai', 'MA Chidambaram Stadium'),
('Royal Challengers Bangalore', 'Bangalore', 'M Chinnaswamy Stadium'),
('Kolkata Knight Riders', 'Kolkata', 'Eden Gardens'),
('Delhi Capitals', 'Delhi', 'Arun Jaitley Stadium'),
('Rajasthan Royals', 'Jaipur', 'Sawai Mansingh Stadium'),
('Punjab Kings', 'Mohali', 'IS Bindra Stadium'),
('Sunrisers Hyderabad', 'Hyderabad', 'Rajiv Gandhi Stadium'),
('Gujarat Titans', 'Ahmedabad', 'Narendra Modi Stadium'),
('Lucknow Super Giants', 'Lucknow', 'BRSABV Ekana Stadium');

insert into players (player_name, teams_id, player_role, nationality) values
('Rohit Sharma', 1, 'Batsman', 'Indian'),
('Jasprit Bumrah', 1, 'Bowler', 'Indian'),
('MS Dhoni', 2, 'Wicket-Keeper', 'Indian'),
('Ruturaj Gaikwad', 2, 'Batsman', 'Indian'),
('Virat Kohli', 3, 'Batsman', 'Indian'),
('Glenn Maxwell', 3, 'All-Rounder', 'Australian'),
('Shreyas Iyer', 4, 'Batsman', 'Indian'),
('Sunil Narine', 4, 'All-Rounder', 'West Indian'),
('David Warner', 5, 'Batsman', 'Australian'),
('Rishabh Pant', 5, 'Wicket-Keeper', 'Indian');

INSERT INTO matches (season, match_date, team1, team2, venue, winner, player_of_match, toss_winner, toss_decision) VALUES
(2026, '2026-03-28', 'Royal Challengers Bangalore', 'Sunrisers Hyderabad', 'M Chinnaswamy Stadium', 'Royal Challengers Bangalore', 'Virat Kohli', 'Royal Challengers Bangalore', 'field'),
(2026, '2026-03-29', 'Mumbai Indians', 'Kolkata Knight Riders', 'Wankhede Stadium', 'Mumbai Indians', 'Rohit Sharma', 'Mumbai Indians', 'field'),
(2026, '2026-03-30', 'Rajasthan Royals', 'Chennai Super Kings', 'Sawai Mansingh Stadium', 'Rajasthan Royals', 'Rishabh Pant', 'Rajasthan Royals', 'field'),
(2026, '2026-03-31', 'Punjab Kings', 'Gujarat Titans', 'IS Bindra Stadium', 'Punjab Kings', 'Glenn Maxwell', 'Punjab Kings', 'bat'),
(2026, '2026-04-01', 'Lucknow Super Giants', 'Delhi Capitals', 'BRSABV Ekana Stadium', 'Lucknow Super Giants', 'Sunil Narine', 'Lucknow Super Giants', 'bat');

select * from teams;
select * from teams where city = 'Mumbai';

select players.player_name, players.player_role, teams.team_name
from players
join teams on players.teams_id = teams.teams_id;

select not winner, count(*) as matches_loss
from matches
where season = 2026
group by not winner
order by matches_loss Desc;

select winner, count(*) as matches_won
from matches
where season = 2026
group by winner
order by matches_won Desc;

select player_name,  player_role
from players
join teams on teams.teams_id = players.teams_id
WHERE team_name = 'Royal Challengers Bangalore';

select toss_winner, winner, count(*) as toss_than_win
from matches
where toss_winner = winner
group by toss_winner, winner;

select venue, count(*) as total_matches
from matches
group by venue;

SELECT winner, COUNT(*) as matches_won
FROM matches
GROUP BY winner
HAVING matches_won > 0;

SELECT player_of_match, COUNT(*) as potm_count
FROM matches
GROUP BY player_of_match
ORDER BY potm_count DESC;

select player_name, player_role, team_name
from players
join teams on players.teams_id = teams.teams_id
where team_name in (
	select winner
    from matches
    where season = 2026
);

select * from deliveries;

select count(*) as total_ball
from deliveries;

SELECT striker, SUM(runs_of_bat) as total_runs
FROM deliveries
GROUP BY striker
ORDER BY total_runs DESC
LIMIT 10;

SELECT bowler, SUM(runs_of_bat) as total_runs_give
FROM deliveries
GROUP BY bowler
ORDER BY total_runs_give DESC
LIMIT 10;

SELECT bowler, count(*) as total_out
FROM deliveries
where wicket_type != ""
GROUP BY bowler
ORDER BY total_out DESC
LIMIT 10;

SELECT bowler, SUM(wide) as total_wides
FROM deliveries
GROUP BY bowler
ORDER BY total_wides DESC
LIMIT 10;