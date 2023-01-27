/*
 How many officers per capita are assigned to each police district?
 Count only the ones that are active (i.e., have active set to true in data_officer).
 Please calculate your answer in officers per 10,000 community members. Your output should have the district name
 (from data_policeunit.unit_name) and its officers per capita sorted in descending order so that the most heavily
 policed districts come first. Hint: you can find the population of each district by joining with the table
 data_racepopulation. You may need to do some string manipulation to line up the unit names.
 */


WITH officer_counts AS (SELECT o.last_unit_id, COUNT(id) as count_officers
                        FROM data_officer o
                        WHERE o.active = 'Yes'
                          AND o.last_unit_id IS NOT NULL
                        GROUP BY o.last_unit_id
                        ORDER BY o.last_unit_id),

area_pop AS (
    SELECT area_id, SUM(count) as population
    FROM data_racepopulation
    GROUP BY area_id
    ORDER BY area_id
), district_names as (SELECT p.area_id, SUBSTRING(a.name, 1, LENGTH(a.name) -2) as district_id, p.population
                     FROM area_pop p
                     JOIN (SELECT * FROM data_area WHERE area_type = 'police-districts') a
                        ON p.area_id = a.id
                     ORDER BY p.area_id),

police_districts AS(
SELECT c.last_unit_id, c.count_officers, u.description, u.unit_name
FROM officer_counts c JOIN data_policeunit u ON c.last_unit_id = CAST(u.unit_name as integer)
WHERE description like 'District%'),

police_pop AS (SELECT area_id, population,  district_id, count_officers, unit_name
FROM district_names JOIN police_districts ON CAST(district_id as integer) = last_unit_id)

SELECT unit_name as district_name, (CAST(count_officers AS float) / CAST(population as float)) * 10000 as per_capita
FROM police_pop
ORDER BY per_capita DESC;

--Below is where I tested different tables to figure out how to join correctly

WITH officer_counts AS (SELECT o.last_unit_id, COUNT(DISTINCT o.id) as count_officers
                        FROM data_officer o
                        WHERE o.active = 'Yes'
                          AND o.last_unit_id IS NOT NULL
                        GROUP BY o.last_unit_id
                        ORDER BY o.last_unit_id)
SELECT c.last_unit_id, c.count_officers, u.description, u.unit_name
FROM officer_counts c JOIN data_policeunit u ON c.last_unit_id = CAST(u.unit_name as integer)
WHERE description like 'District%';

--Test area_id, district_id cut, population per
WITH area_pop AS (
    SELECT area_id, SUM(count) as population
    FROM data_racepopulation
    GROUP BY area_id
    ORDER BY area_id
),

districts as(SELECT p.area_id, SUBSTRING(a.name, 1, LENGTH(a.name) -2) as district_id, p.population
                     FROM area_pop p
                     JOIN (SELECT * FROM data_area WHERE area_type = 'police-districts') a
                        ON p.area_id = a.id
                     ORDER BY p.area_id)

SELECT *, CAST(district_id as INTEGER) as test
FROM districts


WITH officer_counts AS (SELECT o.last_unit_id, COUNT(id) as count_officers
                        FROM data_officer o
                        WHERE o.active = 'Yes'
                          AND o.last_unit_id IS NOT NULL
                        GROUP BY o.last_unit_id
                        ORDER BY o.last_unit_id),

area_pop AS (
    SELECT area_id, SUM(count) as population
    FROM data_racepopulation
    GROUP BY area_id
    ORDER BY area_id
), district_names as (SELECT p.area_id, SUBSTRING(a.name, 1, LENGTH(a.name) -2) as district_id, p.population
                     FROM area_pop p
                     JOIN (SELECT * FROM data_area WHERE area_type = 'police-districts') a
                        ON p.area_id = a.id
                     ORDER BY p.area_id),

police_districts AS(
SELECT c.last_unit_id, c.count_officers, u.description, u.unit_name
FROM officer_counts c JOIN data_policeunit u ON c.last_unit_id = CAST(u.unit_name as integer)
WHERE description like 'District%')


SELECT area_id, population,  district_id, count_officers, unit_name
FROM district_names JOIN police_districts ON CAST(district_id as integer) = last_unit_id;
/*
SELECT unit_name as district_name, (CAST(count_officers AS float) / CAST(population as float)) * 10000 as per_capita
FROM police_pop
ORDER BY per_capita DESC;
 */