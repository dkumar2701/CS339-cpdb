/*
 What is the average number of TRRs per officer? What about the min and max per officer?
 Make sure to include ones who have filed no TRRs in your calculations.
 */

WITH officer_trrs as (SELECT o.id as officer_id, trr.id as trr_id
FROM data_officer o LEFT OUTER JOIN trr_trr trr ON o.id = trr.officer_id
ORDER BY o.id)

SELECT AVG(trr_count) AS avg_trrcount, MIN(trr_count) AS min_trrcount, MAX(trr_count) AS max_trrcount
FROM (SELECT officer_id, COUNT(trr_id) as trr_count
FROM officer_trrs
GROUP BY officer_id) a;