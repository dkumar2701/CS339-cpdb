/*
 What is the maximum sustained allegation count for officers in each rank.
 Hint: you can use data_officer.sustained_count for this. Use their current rank. Sort your results in descending order
 with the highest max count first.
 */

SELECT o.rank, MAX(o.sustained_count) as max_sustained_count
FROM data_officer o
GROUP BY o.rank
ORDER BY max_sustained_count DESC;