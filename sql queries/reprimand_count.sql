SELECT prisoner_id,prisoner_name,prisoner_surname,Count(prisoner_id) AS ReprimandCount
FROM prison.prisoner
RIGHT JOIN prison.reprimand ON prisoner.prisoner_id=reprimand.prisoner_prisoner_id
GROUP BY prisoner_id
ORDER BY ReprimandCount DESC;