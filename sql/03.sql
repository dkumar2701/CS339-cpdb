/*
 Who is the newest officer on the force? If it is a tie, list all of the relevant individuals
 (first, middle initial, and last names) and order them by officer ID (from data_officer.id).
 */

WITH youngest_officer AS(
    SELECT appointed_date as young_date
    FROM data_officer
    WHERE active = 'Yes' AND appointed_date IS NOT NULL
    ORDER BY appointed_date DESC
    LIMIT 1
)

SELECT d.first_name, d.middle_initial, d.last_name
FROM data_officer d, youngest_officer
WHERE active = 'Yes' and appointed_date = youngest_officer.young_date
ORDER BY d.id
