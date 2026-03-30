-- Seating type dimension for open restaurant seating applications
WITH seating_types AS (
   SELECT DISTINCT
       seating_interest_sidewalk AS seating_interest,
--TODO: Replace this comment with a CASE WHEN .. statement that handles the different possibilities for approved_for_sidewalk_seating and approved_for_roadway_seating in the data
--NOTE: The final result we want to select here is two boolean columns (TRUE or FALSE values in them), one column approved_for_sidewalk (TRUE or FALSE value), and one column approved_for_roadway 
    CASE 
        WHEN Upper(TRIM(approved_for_sidewalk_seating)) IN ('YES', 'Y', 'TRUE') THEN TRUE
        ELSE FALSE
      END AS approved_for_sidewalk,
    CASE 
        WHEN UPPER(TRIM(approved_for_roadway_seating)) IN ('YES', 'Y', 'TRUE') THEN TRUE
        ELSE FALSE
       END AS approved_for_roadway   
   FROM {{ref('stg_nyc_open_restaurant_apps') }}--TODO: reference the appropriate staging table!
   WHERE seating_interest_sidewalk IS NOT NULL
),
seating_dimension AS (
   SELECT
       {{ dbt_utils.generate_surrogate_key([
           'seating_interest',
           'approved_for_sidewalk',
           'approved_for_roadway'
       ]) }} AS seating_type_key,

       -- TODO: fill in the rest of this SELECT statement
       --  based on the dimensional model!

   FROM seating_types
)

SELECT * FROM seating_dimension

