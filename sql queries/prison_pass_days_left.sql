SELECT prisoner_id as ID, 
	prisoner_name as Name,
    prisoner_surname as Surname, 
    start_date, 
    finish_date, 
    TIMESTAMPDIFF(day, now(), finish_date) as Days_Left 
FROM prison.pass
LEFT JOIN prison.prisoner On prisoner_prisoner_id=prisoner_id
WHERE Now() BETWEEN start_date AND finish_date;