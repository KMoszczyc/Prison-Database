SELECT 
	block_id,
	AVG(TIMESTAMPDIFF(day,start_date,finish_date)) as Average_Day_Spent
FROM prison.block
INNER JOIN (isolation_cell RIGHT JOIN isolation ON isolation_cell_isolation_cell_id= isolation_cell_id) 
ON block_block_id=block_id
GROUP BY block_id
ORDER BY block_id;