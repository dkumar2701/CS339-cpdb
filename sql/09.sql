/*
 How many allegations per year were sustained (SU) or exonerated (EX)?
 You may use the field data_officerallegation.final_finding for your count.
 Use the end date of the complaint report's investigation to categorize the allegations.
 */
WITH year_finding as (SELECT EXTRACT(YEAR FROM end_date) AS year, final_finding
FROM data_officerallegation
WHERE (final_finding = 'SU' or final_finding = 'EX') AND end_date IS NOT NULL)

SELECT year, COUNT(final_finding) AS allegations_SU_or_EX
FROM year_finding
GROUP BY year
ORDER BY year DESC



