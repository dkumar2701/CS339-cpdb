/*
 Give the names of the officers who joined on or after March 15, 2020.
 Please give their first name, middle initial, and last name and sort them by last name using their first name
 in the event of a tie.
 */

SELECT d.first_name, d.middle_initial, d.last_name
FROM data_officer d
WHERE d.appointed_date >= '3/15/2020'
ORDER BY d.last_name, d.first_name