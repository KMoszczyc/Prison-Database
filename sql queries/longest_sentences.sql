SELECT prisoner_id AS ID,prisoner_name AS Name, prisoner_surname AS Surname, admission_date, release_date,
if(release_date>Now(), Year(DATE_ADD("0000-01-01", INTERVAL datediff(now(),admission_date) DAY)), Year(DATE_ADD("0000-01-01", INTERVAL datediff(release_date,admission_date) DAY))) AS Years,
if(release_date>Now(), Month(DATE_ADD("0000-01-01", INTERVAL datediff(now(),admission_date) DAY)), Month(DATE_ADD("0000-01-01", INTERVAL datediff(release_date,admission_date) DAY))) AS Months,
if(release_date>Now(), Day(DATE_ADD("0000-01-01", INTERVAL datediff(now(),admission_date) DAY)), Day(DATE_ADD("0000-01-01", INTERVAL datediff(release_date,admission_date) DAY))) AS Days, 
if(release_date>Now(),timestampdiff(day,now(),release_date),"Released") AS DaysLeft
FROM prison.prisoner
ORDER BY Years DESC, Months DESC, Days DESC;