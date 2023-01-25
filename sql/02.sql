WITH complaint AS (
    SELECT COUNT(DISTINCT crid) AS complaints
    FROM data_allegation
    WHERE is_officer_complaint = true
), total AS(
    SELECT COUNT(*) AS total_complaints
    FROM data_allegation
)

SELECT (CAST(complaints AS float) / CAST(total_complaints AS float)) * 100 AS percentage
FROM complaint, total
