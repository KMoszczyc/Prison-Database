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