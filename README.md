# Prison-Database
## About
Prison Database Model with example SQL queries and python script to fill the database with custom data.

## Databse Model
![EER_Diagram](https://user-images.githubusercontent.com/61971053/120490176-7b99ae00-c3b8-11eb-9ceb-784ce5958b25.png)

## Queries

#### Prisoner Reprimand Count
|ID|Name|Surname|Reprimand Count|
|----|------|-------|--|
|9040|JUSTIN|EMANUEL|11|
|9178|JAYSON|BEDELL |9 |
|6713|PRINCE|CEPHAS |8 |
|9538|LEON  |HOUSER |8 |
|8467|COLE  |BESSER |8 |

#### Longest Sentences
|ID|Name|Surname|Admission Date|Release Date|Years|Months|Days|Days Left|
|---|--------|--------|-----------|----------|----|--|--|-------|
|2573|GEOFFREY|PIERCE	|1973-05-13	|2031-02-01|	48|	1|22|3530|
|3650|NEAL    |MUNGUIA	|1974-01-27 |2023-03-18|	47|	5|8 |653|
|2714|LUIGI   |DEBOSE	|1979-05-08	|2025-01-17|	42|	1|27|1324|
|4374|PARKER	 |STRAHAN	|1979-12-04	|2029-12-12|	41|	7|1	|3114|
|3653|LEWIS	 |DEPALMA	|1973-10-30	|2012-10-03|	38|	1|6	|Released|


#### Prisoner's crimes
|Crime|Count|
|----|----|
|Prostitution|	203|
|Identity Theft|	195|
|Burglary|	181|
|Credit / Debit Card Fraud|	181|
|Attempt|	180|

#### Job assignments per block
|Block ID|Job|Prisoners assigned|
|----|----|----|
|1	|not assigned|	36|
|1	|laundry	|16|
|1|	workshop	|16|
|1|	commisary|	9|
|1|	kitchen	|8|

#### Prison Pass Days Left
|ID|Name|Surname|Start Date|End Date|Days Left|
|----|----|----|---|----|----|
|6680	|THOMAS|	PERES|2021-05-26|	2021-06-04	|1|
|6198	|AGUSTIN	|HOLE	|2021-06-01|	2021-06-07|	4|
|7011	|KENT	|BRADT	|2021-06-02|	2021-06-09	|6|
|8019	|NICOLAS|MCSHERRY	|2021-06-02	|2021-06-07|	4|
|7548	|GENE	|ROBICHAUX	|2021-06-02	|2021-06-08|	5|


#### Longest Current Sentence Per Block
|BLOCK ID |Longest Sentence in Years|
|-|-|
|8	|62|
|7	|60|
|29|	59|
|14	|57|
|27|	56|

#### Prisoner Visits

|ID|Name|Surname|Total Time in Minutes|Number of Visits|
|----|------|-----|-----|---|
|1442 |ELMER|	HAMLET     | 375	|10|
|4925	|ARNOLD	|HAMMONTREE| 326|	7|
|4132	|DENIS|	LAMPKIN	   | 19|	9|
|1404	|MARCELLUS	|PILAND| 302|	7|
|3608	|NORMAND|	BUTTS    |  297|	7|
