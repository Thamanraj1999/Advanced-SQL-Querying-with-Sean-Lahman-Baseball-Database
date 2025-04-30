select round(yearID, -1) AS year_1, count(distinct SchoolID) AS schools
from schools
group by year_1
order by year_1;

select s.schoolID, count(Distinct s.PlayerID) AS Player_count, sd.name_Full
from Schools s
LEFT join School_details sd
on s.schoolID = sd.schoolID
group by s.schoolID, sd.name_Full
order by  count(s.PlayerID) Desc
Limit 5;

select round(yearID, -1) AS year_1, SchoolID, count(Distinct PlayerID) AS Player_Num,
dense_rank() over (partition by round(yearID, -1) order by count(Distinct PlayerID)DESC) AS Rank_1
from schools
group by year_1, SchoolID
order by year_1;

With cte as (select round(yearID, -1) AS year_1, SchoolID, count(Distinct PlayerID) AS Player_Num,
dense_rank() over (partition by round(yearID, -1) order by count(Distinct PlayerID)DESC) AS Rank_1
from schools
group by round(yearID, -1), SchoolID
order by year_1)
select cte.year_1, cte.SchoolID, cte.Player_Num, sd.name_Full
from cte 
LEFT join School_details sd
on cte.schoolID = sd.schoolID
where cte.Rank_1 between 1 and 3 ;

select nameGiven,
STR_TO_DATE(CONCAT(birthYear, '-', birthMonth, '-', birthDay), '%Y-%m-%d') AS Birthdate
from players;  

With CTE AS (select nameGiven,
STR_TO_DATE(CONCAT(birthYear, '-', birthMonth, '-', birthDay), '%Y-%m-%d') AS Birthdate
from players)
select birthdate, group_concat(nameGiven, ' ' ) AS Names
from  CTE 
Where Birthdate is not null and year(Birthdate) Between 1900 and 2000
Group by birthdate
order by birthdate;

select s.teamID, count(s.playerID) AS Player_Count,
(Count(case when p.bats = 'R' THEN 1 END) / count(s.playerID))*100 AS Rights_Bats_Man,
(count(case when p.bats = 'L' THEN 1 END) / count(s.playerID))*100 AS Lefts_Bats_Man,
(count(case when p.bats = 'B' THEN 1 END) / count(s.playerID))*100 AS Both_Bats_Man
from salaries s
left join players p
on p.playerID = s.playerID
group by s.teamID;
    
     
 select Round(Year(debut),-1) AS decade, AVG(height), AVG(weight)
 from players
 where height is not null
 and weight is not null
 and debut is not null
 group by decade
 order by Round(Year(debut),-1);
     
With cte as (select Round(Year(debut),-1) AS decade, AVG(height) AS AVG_Height, AVG(weight) AS AVG_Weight
 from players
 group by decade)

 select decade, AVG_Height, AVG_Weight,
 AVG_Height - lag(AVG_Height) over(order by AVG_Height) AS height_Diff,
 AVG_Weight - lag(AVG_weight) over(order by AVG_weight) AS weight_Diff
 from cte;

select nameGiven,
timestampdiff(Year, cast(concat(birthYear, '-', birthMonth, '-', birthDay) AS DATE), debut) AS starting_age,
timestampdiff(Year, cast(concat(birthYear, '-', birthMonth, '-', birthDay) AS DATE), finalGame) AS end_age,
timestampdiff(Year, debut, finalGame) AS career_length
from players
order by career_length DESC;

select p.nameGiven, s.yearID, s.teamID, e.yearID, e.teamID
from players p inner join salaries s
on p.playerID = s.playerID
AND Year(p.debut) = s.yearID
Inner join salaries e
ON p.playerID = e.playerID
AND Year(p.finalGame) = e.yearID;










