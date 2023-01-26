/*
 List all of the officers with at least 3 unique complaint reports filed against them. In other words,
 the allegations will have different values for data officerallegation.allegation id.
 Output their officer IDs, first and last names. Sort them by their officer ID.
 Hint: The allegation_count field in data_officer will count the allegations, but not the complaint reports.
 */


WITH bad_officers as(SELECT officer_id
FROM data_officerallegation
GROUP BY officer_id
HAVING COUNT(DISTINCT allegation_id) >= 3)

SELECT officer_id,data_officer.first_name, data_officer.last_name
FROM bad_officers JOIN data_officer ON bad_officers.officer_id = data_officer.id
ORDER BY officer_id

