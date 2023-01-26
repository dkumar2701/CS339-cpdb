/*
 If two or more officers are named in the same complaint report, we say those officers are co-accused. Find the unique
 pairs of officers who are co-accused where each officer is assigned to a different police unit. Output their officer
 IDs (where the left ID is less than the right) and the ID of their most recent police unit and sort on their officer
 IDs.
 */

 --Make a pairing of officer id's where left id is smaller than right
 
WITH officer_set as (
    SELECT last_unit_id, officer_id, allegation_id
    FROM data_officer JOIN data_officerallegation on data_officer.id = data_officerallegation.officer_id)

SELECT distinct l.officer_id as officer1, r.officer_id as officer2, l.last_unit_id as officer1_lastunit, --added distinct to find unique rows
       r.last_unit_id as officer2_lastunit
FROM officer_set as l JOIN officer_set as r
    ON l.allegation_id = r.allegation_id
           AND l.officer_id < r.officer_id
           AND l.last_unit_id != r.last_unit_id
ORDER BY l.officer_id, r.officer_id;
