WITH youngest_officer AS(
    SELECT appointed_date as young_date
    FROM data_officer
    WHERE active = 'Yes' AND appointed_date IS NOT NULL
    ORDER BY appointed_date DESC
    LIMIT 1
)

SELECT first_name, middle_initial, last_name
FROM data_officer, youngest_officer
WHERE active = 'Yes' and appointed_date = youngest_officer.young_date
ORDER BY id