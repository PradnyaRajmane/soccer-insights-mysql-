## 1.	Write a SQL query to find out where the final match of the EURO cup 2016 was played. Return venue name, city.
##soccer_venue---venue_id, venue_name, city_id, aud_capacity
##match_mast----match_no, play_stage, play_date, results, decided_by, goal_score, venue_id, referee_id, 
##audience, plr_of_match, stop1_sec, stop2_sec
##soccer_city----city_id, city, country_id
use soccer_db;
select year(play_date),venue_name,city from 
match_mast left join
soccer_venue 
using (venue_id)
left join
soccer_city 
using (city_id)
where play_stage= "F";

SELECT venue_name, city
FROM soccer_venue a
JOIN soccer_city b ON a.city_id=b.city_id
JOIN match_mast d ON d.venue_id=a.venue_id 
AND d.play_stage='F';

## 2.Write a SQL query to find the number of goals scored by each team in each match during normal play. 
### Return match number, country name and goal score.
#match_details----match_no, play_stage, team_id, win_lose, decided_by, goal_score, penalty_score, ass_ref, player_gk
###soccer_country---country_id, country_abbr, country_name

select match_no,country_name,goal_score,decided_by from 
match_details md join
soccer_country  sc
on md.team_id=sc.country_id
where decided_by= "N";

## 3.Write a SQL query to count the number of goals scored by each player within a normal play schedule. 
## Group the result set on player name and country name and sorts the result-set according to the highest to the lowest scorer. 
## Return player name, number of goals and country name.
## player_mast---player_id, team_id, jersey_no, player_name, posi_to_play, dt_of_bir, age, playing_club
##goal_details---goal_id, match_no, player_id, team_id, goal_time, goal_type, play_stage, goal_schedule, goal_half
###soccer_country---country_id, country_abbr, country_name

select player_name,count(*),country_name 
from goal_details
join player_mast pm
using (player_id)
join soccer_country sc
on
pm.team_id=sc.country_id
where goal_type = "N"
group by player_name,country_name 
order by count(*) desc;

SELECT player_name,count(*),country_name
FROM goal_details a
JOIN player_mast b ON a.player_id=b.player_id
JOIN soccer_country c ON a.team_id=c.country_id
WHERE goal_schedule = 'NT'
GROUP BY player_name,country_name
ORDER BY count(*) DESC;

## 4.Write a SQL query to find out who scored in the final of the 2016 Euro Cup Write a SQL query 
#to find out who scored the most goals in the 2016 Euro Cup.
# Return player name, country name and highest individual scorer.-

## player_mast---player_id, team_id, jersey_no, player_name, posi_to_play, dt_of_bir, age, playing_club
##goal_details---goal_id, match_no, player_id, team_id, goal_time, goal_type, play_stage, goal_schedule, goal_half
###soccer_country---country_id, country_abbr, country_name

select player_name,country_name,count(player_name)
from goal_details gd
join player_mast pm
on pm.player_id=gd.player_id
join soccer_country sc
on sc.country_id=pm.team_id
group by country_name,player_name 
having count(player_name)>= all 
(select count(player_name)
from goal_details gd
join player_mast pm
using (player_id)
join
soccer_country sc on  sc.country_id=pm.team_id
group by country_name,player_name);

###/* Q5. write a SQL query to find out who scored in the final of the 2016 Euro Cup. Return player name, jersey number and country name.*/
## player_mast---player_id, team_id, jersey_no, player_name, posi_to_play, dt_of_bir, age, playing_club
##goal_details---goal_id, match_no, player_id, team_id, goal_time, goal_type, play_stage, goal_schedule, goal_half
###soccer_country---country_id, country_abbr, country_name
select  jersey_no, player_name,country_name
from player_mast join
goal_details gd
using (player_id)
join
soccer_country sc
on gd.team_id=sc.country_id
where play_stage="F";

##/*Q6. write a SQL query to find out which country hosted the 2016 Football EURO Cup. Return country name.*/
##soccer_venue---venue_id, venue_name, city_id, aud_capacity
###soccer_country---country_id, country_abbr, country_name
###soccer_city--city_id, city, country_id

select  country_name from soccer_country
join
soccer_city
using(country_id)
join
soccer_venue
using (city_id)
group by country_name;

###/*Q7. write a SQL query to find out who scored the first goal of the 2016 European Championship. 
## Return player_name, jersey_no, country_name, goal_time, play_stage, goal_schedule, goal_half.*/

###player_mast---player_id, team_id, jersey_no, player_name, posi_to_play, dt_of_bir, age, playing_club
###soccer_country---country_id, country_abbr, country_name
#####goal_details---goal_id, match_no, player_id, team_id, goal_time, goal_type, play_stage, goal_schedule, goal_half

select goal_id,player_name,jersey_no,country_name,goal_time, play_stage, goal_schedule, goal_half from 
goal_details join player_mast pm
using (player_id)
join
soccer_country sc
on pm.team_id=sc.country_id
where goal_id=1;

###/*Q8. write a SQL query to find the referee who managed the opening match. Return referee name, country name.*/

###soccer_country---country_id, country_abbr, country_name
##referee_mast---referee_id, referee_name, country_id
###match_mast----match_no, play_stage, play_date, results, decided_by, goal_score, venue_id, referee_id, audience, plr_of_match, stop1_sec, stop2_sec

select match_no,referee_name,country_name from
soccer_country
join
referee_mast
using (country_id)
join
match_mast
using (referee_id)
where match_no=1;

###/*Q9. write a SQL query to find the referee who managed the final match. Return referee name, country name.*/
select play_stage,referee_name,country_name from
soccer_country
join
referee_mast
using (country_id)
join
match_mast
using (referee_id)
where play_stage="F";

/*Q10. write a SQL query to find the referee who assisted the referee in the opening match. 
Return associated referee name, country name.*/

##select ass_ref_name,country_name
#from referee_mast join
#soccer_country
#using (country_id)
#join
#asst_referee_mast arm
#on 
select match_no,ass_ref_name,country_name
from asst_referee_mast arm join
match_details md on md.ass_ref=arm.ass_ref_id
join
soccer_country
using(country_id)
where match_no=1;

use soccer_db;

###11.	Write a SQL query to find the referee who assisted the referee in the final match.
## Return associated referee name, country name.
##match_mast---match_no, play_stage, play_date, results, decided_by, goal_score, venue_id, referee_id,
## audience, plr_of_match, stop1_sec, stop2_sec
##match_details---match_no, play_stage, team_id, win_lose, decided_by, goal_score, penalty_score, ass_ref, player_gk
##soccer_country---country_id, country_abbr, country_name
###asst_referee_mast---ass_ref_id, ass_ref_name, country_id
select ass_ref_name, country_name 
from match_details md
join asst_referee_mast arm
on arm.ass_ref_id=md.ass_ref
join soccer_country
using (country_id)
where md.play_stage="F";

##/*Q12. write a SQL query to find the city where the opening match of EURO cup 2016 took place. Return venue name, city.*/
##soccer_venue---venue_id, venue_name, city_id, aud_capacity
###soccer_city--city_id, city, country_id
##match_mast---match_no, play_stage, play_date, results, decided_by, goal_score, venue_id, referee_id,
## audience, plr_of_match, stop1_sec, stop2_sec
select venue_name,city
from match_mast 
join soccer_venue 
using(venue_id)
join soccer_city
using (city_id)
where match_no=1;


/*Q13. write a SQL query to find out which stadium hosted the final match of the 2016 Euro Cup. 
Return venue_name, city, aud_capacity, audience.*/
##soccer_venue---venue_id, venue_name, city_id, aud_capacity
###soccer_city--city_id, city, country_id
##match_mast---match_no, play_stage, play_date, results, decided_by, goal_score, venue_id, referee_id,
## audience, plr_of_match, stop1_sec, stop2_sec
select venue_name,city,aud_capacity,audience
from match_mast 
join soccer_venue 
using(venue_id)
join soccer_city
using (city_id)
where play_stage="F";

/*Q14. write a SQL query to count the number of matches played at each venue. Sort the result-set on venue name. 
Return Venue name, city, and number of matches.*/
select venue_name,city,count(match_no) as number_of_matches
from match_mast 
join soccer_venue 
using(venue_id)
join soccer_city
using (city_id)
group by  venue_name,city
order by venue_name;

/*Q15. write a SQL query to find the player who was the first player to be sent off at the tournament EURO cup 2016. 
Return match Number, country name and player name. */

##player_booked---match_no, team_id, player_id, booking_time, sent_off, play_schedule, play_half
##player_mast---player_id, team_id, jersey_no, player_name, posi_to_play, dt_of_bir, age, playing_club
##soccer_country---country_id, country_abbr, country_name

select match_no,country_name,player_name
from player_booked
join player_mast pm
using (player_id)
join soccer_country sc
on pm.team_id=sc.country_id
and  sent_off= "Y"
and match_no=(select min(match_no)from player_booked);

/*Q16. write a SQL query to find the teams that have scored one goal in the tournament. Return country_name as 
"Team", team in the group, goal_for.
Soccer_team--team_id, country_id, team_group, match_played, won, draw, lost, goal_for, goal_agnst, goal_diff, points, group_position
soccer_country---country_id, country_abbr, country_name
*/
select country_name as team,team_group,goal_for
from soccer_team st
join soccer_country sc
on st.team_id=sc.country_id
where goal_for=1;

#### question n ans not understood
/*Q17. write a SQL query to count the number of yellow cards each country has received. 
Return country name and number of yellow cards.
soccer_country---country_id, country_abbr, country_name
*/
SELECT country_name, COUNT(*)
FROM soccer_country 
JOIN player_booked
ON soccer_country.country_id=player_booked.team_id
GROUP BY country_name
ORDER BY COUNT(*) DESC;


/*Q18. write a SQL query to count the number of goals that have been seen. Return venue name and number of goals.*/
SELECT venue_name, count(venue_name)
FROM goal_details gd
JOIN soccer_country sc
ON gd.team_id=sc.country_id
JOIN match_mast mm ON gd.match_no=mm.match_no
JOIN soccer_venue sv ON mm.venue_id=sv.venue_id
GROUP BY venue_name
ORDER BY COUNT(venue_name) DESC;

/* Q19. write a SQL query to find the match where there was no stoppage time in the first half. Return match number, country name.

soccer_country---country_id, country_abbr, country_name
player_booked---match_no, team_id, player_id, booking_time, sent_off, play_schedule, play_half
match_mast---match_no, play_stage, play_date, results, decided_by, goal_score, venue_id, referee_id, audience, plr_of_match, stop1_sec, stop2_sec*/

select match_no,country_name, stop1_sec
from match_mast
join player_booked pb
using (match_no)
join soccer_country sc
on pb.team_id=sc.country_id
where stop1_sec = 0 ;

/*Q20. write a SQL query to find the team(s) who conceded the most goals in EURO cup 2016.
 Return country name, team group and match played.
 soccer_team--team_id, country_id, team_group, match_played, won, draw, lost, goal_for, goal_agnst, goal_diff, points, group_position
 soccer_cuntry--country_id
 */
 select country_name,team_group, match_played,goal_agnst
 from soccer_team st 
 join soccer_country sc
 on st.team_id=sc.country_id
 where goal_agnst = (select max(goal_agnst) from soccer_team);

/*Q21. Write a SQL query to find those matches where the highest stoppage time was added in 2nd half of play. 
Return match number, country name, stoppage time(sec.). 
match_mast---match_no, play_stage, play_date, results, decided_by, goal_score, venue_id, referee_id, 
audience, plr_of_match, stop1_sec, stop2_sec
soccer_country--country_id
match_details---match_no, play_stage, team_id, win_lose, decided_by, goal_score, penalty_score, ass_ref, player_gk
*/

select match_no,country_name,stop2_sec
from match_mast mm
join match_details md
using (match_no)
join soccer_country sc
on md.team_id=sc.country_id
where stop2_sec= (select max(stop2_sec) from match_mast);

/*Q22. write a SQL query to find the matches that ended in a goalless draw at the group stage. 
Return match number, country name.
soccer_team--team_id, country_id, team_group, match_played, won, draw, lost, goal_for, goal_agnst, goal_diff, points, group_position
 soccer_cuntry--country_id
 match_details---match_no, play_stage, team_id, win_lose, decided_by, goal_score, penalty_score, ass_ref, player_gk
*/
select match_no,country_name 
from soccer_country sc
join match_details md
on md.team_id=sc.country_id
where play_stage="G" and win_lose="D" and goal_score=0;

/*Q23. write a SQL query to find those match(s) where the second highest amount of 
stoppage time was added in the second half of the match. 
Return match number, country name and stoppage time. */

select match_no,country_name,stop2_sec
from match_mast mm
join match_details md
using (match_no)
join soccer_country sc
on md.team_id=sc.country_id
where stop2_sec=(select stop2_sec from match_mast order by stop2_sec desc limit 1,1) ;

/*Q24. write a SQL query to find the number of matches played by a player as a goalkeeper for his team. 
Return country name, player name, number of matches played as a goalkeeper. 
 soccer_cuntry--country_id
 match_details---match_no, play_stage, team_id, win_lose, decided_by, goal_score, penalty_score, ass_ref, player_gk
 player_mast---player_id, team_id, jersey_no, player_name, posi_to_play, dt_of_bir, age, playing_club
 */
 
 select country_name,player_name,count(player_gk) 
 from player_mast
 join match_details md
 using (team_id)
 join soccer_country sc
 on sc.country_id=md.team_id
 group by country_name,player_name
 order by count(player_gk) desc;
 











































































