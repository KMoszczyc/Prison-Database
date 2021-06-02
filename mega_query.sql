use prison;
describe prisoner;
select * from prisoner limit 0,20000;
select * from block;
select * from cell limit 0,20000;
select * from isolation_cell limit 0,4000;
delete from prisoner where prisoner_id <>0;
delete from block where block_id <>0;
delete from isolation_cell where isolation_cell_id <>0;
delete from cell where cell_id <>0;
delete from isolation where isolation_id <>0;
delete from reprimand where reprimand_id <>0;
select max(block_id) from block;
select * from cell Limit 0,10000;
select * from isolation limit 0 , 10000;
select * from duty limit 0, 20000;
select * from shift limit 0, 40000;
select * from jailer;
select * from reprimand;
select * from complaint;
select * from doctor;
select * from infirmary_visit limit 0,5000;
select * from package;
select * from deposit;
select * from object limit 0, 20000;
select * from pass;
select * from visitor;
select * from prisoner_visit;
select is1.isolation_cell_isolation_cell_id, is2.isolation_cell_isolation_cell_id, is1.start_date, is2.start_date from isolation as is1, isolation as is2 where is1.isolation_cell_isolation_cell_id = is2.isolation_cell_isolation_cell_id and DATEDIFF(is1.start_date ,is2.start_date) < 60 and DATEDIFF(is1.start_date ,is2.start_date) > 1  ;
delete from prisoner where prisoner_id=1;
delete from deposit where deposit_id=1;

SELECT prisoner_id,prisoner_name,prisoner_surname, Count(prisoner_id)
FROM prisoner
right join prison.reprimand ON prisoner.prisoner_id=reprimand.prisoner_prisoner_id
group by prisoner_id;

SELECT prisoner_id,prisoner_name,prisoner_surname,Count(prisoner_id) as ReprimandCount
FROM prison.prisoner
right join prison.reprimand ON prisoner.prisoner_id=reprimand.prisoner_prisoner_id
group by prisoner_id
Order by ReprimandCount desc;

SELECT prisoner_id AS ID,prisoner_name AS Name, prisoner_surname AS Surname, admission_date, release_date,
if(release_date>Now(), Year(DATE_ADD("0000-01-01", INTERVAL datediff(now(),admission_date) DAY)), Year(DATE_ADD("0000-01-01", INTERVAL datediff(release_date,admission_date) DAY))) AS Years,
if(release_date>Now(), Month(DATE_ADD("0000-01-01", INTERVAL datediff(now(),admission_date) DAY)), Month(DATE_ADD("0000-01-01", INTERVAL datediff(release_date,admission_date) DAY))) AS Months,
if(release_date>Now(), Day(DATE_ADD("0000-01-01", INTERVAL datediff(now(),admission_date) DAY)), Day(DATE_ADD("0000-01-01", INTERVAL datediff(release_date,admission_date) DAY))) AS Days, 
if(release_date>Now(),timestampdiff(day,now(),release_date),"Released") AS DaysLeft
FROM prison.prisoner
ORDER BY Years DESC, Months DESC, Days DESC;

SELECT crime, Count(crime) FROM prisoner
JOIN cell ON prisoner.cell_cell_id=cell.cell_id
JOIN block ON cell.block_block_id = block.block_id
GROUP BY crime
ORDER BY Count(crime) DESC;

-- select * from prisoner
-- join cell on prisoner.cell_cell_
-- order by cell_cell_id;

SELECT 
	block_id, 
    if(job_assignment="","not assigned", job_assignment) AS Job, 
    count(job_assignment) AS Prisoners_Assigned 
FROM prison.prisoner
JOIN cell ON cell_cell_id=cell_id
JOIN block ON block_block_id=block_id
WHERE release_date>now() 
GROUP BY job_assignment,block_id
ORDER BY block_id;

SELECT prisoner_id as ID, 
	prisoner_name as Name,
    prisoner_surname as Surname, 
    start_date, 
    finish_date, 
    TIMESTAMPDIFF(day, now(), finish_date) as Days_Left 
FROM prison.pass
LEFT JOIN prison.prisoner On prisoner_prisoner_id=prisoner_id
WHERE Now() BETWEEN start_date AND finish_date;

SELECT 
	block_id,
	AVG(TIMESTAMPDIFF(day,start_date,finish_date)) as Average_Day_Spent
FROM prison.block
INNER JOIN (isolation_cell RIGHT JOIN isolation ON isolation_cell_isolation_cell_id= isolation_cell_id) 
ON block_block_id=block_id
GROUP BY block_id
ORDER BY block_id;

SELECT 
	block_id,
	job_assignment AS Job,
	count(job_assignment) AS Prisoners_Assigned 
FROM prison.prisoner
JOIN cell ON cell_cell_id=cell_id
JOIN block ON block_block_id=block_id
WHERE release_date>now() 
GROUP BY job_assignment,block_id
ORDER BY block_id;

SELECT 
	block_id AS Block, 
	max(TIMESTAMPDIFF(year,prisoner.admission_date,prisoner.release_date)) AS Longest_sentence
FROM prison.prisoner
LEFT JOIN(cell INNER JOIN block ON block_block_id=block_id) ON cell_cell_id=cell_id
WHERE prisoner.release_date>now()
GROUP BY block_id
ORDER BY block_id;

SELECT jailer_id as ID,jailer_name as Name,jailer_surname as Surname ,sum(timestampdiff(hour,start_date,finish_date)) as `Last 30 days duty time`
FROM prison.duty
left Join (prison.Shift inner join prison.jailer on shift.jailer_jailer_id=jailer.jailer_id) ON duty_duty_id=duty_id
Where (timestampdiff(day,start_date,now()))<30
group by jailer_id 
order by `Last 30 days duty time`;

SELECT 
	prisoner_id AS ID,
	prisoner_name AS Name,
	prisoner_surname AS Surname,
	sum(visit_length_minutes) AS Total_visits_time,
	count(prisoner_visit_id) AS Visit_count
FROM prison.prisoner_visit 
LEFT JOIN prison.prisoner ON prisoner_prisoner_id=prisoner_id
GROUP BY prisoner_id
ORDER BY total_visits_time DESC;

explain SELECT 
	prisoner_id as id, 
	prisoner_name as name, 
	prisoner_surname as surname, 
	avg(timestampdiff(day,start_date,finish_date)) as Average_day_in_isolation,
	count(isolation_id) as Total_isolations, 
	sum(timestampdiff(day,start_date,finish_date)) as Days_in_Isolation
FROM prison.isolation
left join prisoner on prisoner_id=prisoner_prisoner_id
GROUP BY prisoner_id
ORDER BY Total_isolations DESC;

