SELECT 
	jailer_id AS ID,
	jailer_name AS Name,
	jailer_surname AS Surname,
	sum(timestampdiff(hour,start_date,finish_date)) AS `Last 30 days duty time`
FROM prison.duty
LEFT JOIN (prison.Shift INNER JOIN prison.jailer ON shift.jailer_jailer_id=jailer.jailer_id) ON duty_duty_id=duty_id
WHERE (timestampdiff(day, start_date,now()))<30
GROUP BY jailer_id 
ORDER BY `Last 30 days duty time`;