SELECT 
	block_id AS Block, 
	max(TIMESTAMPDIFF(year, prisoner.admission_date,prisoner.release_date)) AS Longest_sentence
FROM prison.prisoner
LEFT JOIN(cell INNER JOIN block ON block_block_id=block_id) ON cell_cell_id=cell_id
WHERE prisoner.release_date>now()
GROUP BY block_id
ORDER BY block_id;