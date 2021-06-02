SELECT prisoner_id AS ID, 
	prisoner_name AS Name,
    prisoner_surname AS Surname, 
    start_date, 
    finish_date, 
    TIMESTAMPDIFF(day, now(), finish_date)+1 AS Days_Left 
FROM prison.pass
LEFT JOIN prison.prisoner ON prisoner_prisoner_id=prisoner_id
WHERE Now() BETWEEN start_date AND finish_date
ORDER BY Days_Left;