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