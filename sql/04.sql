SELECT officer_id, COUNT( DISTINCT allegation_id) AS complaint_count
FROM data_officerallegation
GROUP BY officer_id
HAVING COUNT(DISTINCT allegation_id) >= 3
ORDER BY officer_id


