SELECT d.first_name, d.middle_initial, d.last_name
FROM data_officer d
WHERE d.appointed_date > '3/15/2020'
ORDER BY d.last_name, d.first_name