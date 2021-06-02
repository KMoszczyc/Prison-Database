SELECT crime, Count(crime) FROM prisoner
JOIN cell ON prisoner.cell_cell_id=cell.cell_id
JOIN block ON cell.block_block_id = block.block_id
GROUP BY crime
ORDER BY Count(crime) DESC;