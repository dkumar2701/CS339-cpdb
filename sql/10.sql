/*
 What are the 5 most common civilian complaints? Display their category, allegation name, and count with the most common one first.
 */

SELECT ac.category, ac.allegation_name, COUNT(*) AS count
FROM data_allegation a, data_officerallegation oa, data_allegationcategory ac
WHERE a.is_officer_complaint = 'False' AND a.crid = oa.allegation_id AND oa.allegation_category_id = ac.id
GROUP BY ac.category, ac.allegation_name
ORDER BY count DESC
LIMIT 5