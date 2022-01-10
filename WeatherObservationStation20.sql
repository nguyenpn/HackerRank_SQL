/*
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
sort LAT_N max to min using row_number()
case when even RN % 0 == 2 then average two middle value
     else odd then the middle value
 
Review data type, cast, convert https://www.sqlshack.com/overview-of-sql-server-rounding-functions-sql-round-ceiling-and-floor/
*/
WITH 
cte_temp AS (
    SELECT ROW_NUMBER() OVER(ORDER BY LAT_N DESC) AS RN
          ,ROUND(CAST(LAT_N AS DECIMAL(10,4)), 4) AS LAT_N
    FROM station
)

,cte_middle1 AS (
    SELECT LAT_N
      FROM cte_temp
    WHERE RN = (SELECT COUNT(RN) / 2
                  FROM cte_temp)
)

,cte_middle2 AS (
    SELECT LAT_N
      FROM cte_temp
    WHERE RN = (SELECT COUNT(RN) / 2 + 1
                  FROM cte_temp)
)

SELECT 
    CASE
        -- even
        WHEN COUNT(LAT_N) % 2 = 0 THEN ROUND(CAST((SELECT LAT_N FROM cte_middle1) + (SELECT LAT_N FROM cte_middle2) / 2 AS DECIMAL(10,4)), 4)
        -- odd
        WHEN COUNT(LAT_N) % 2 != 0 THEN ROUND(CAST((SELECT LAT_N FROM cte_middle2) AS DECIMAL(10,4)), 4)
    END AS Median
  FROM cte_temp
  
/*
SELECT 
    CASE
        WHEN COUNT(LAT_N) % 2 = 0 THEN ROUND((SELECT LAT_N FROM cte_middle1) + (SELECT LAT_N FROM cte_middle2) / 2, 4)
        WHEN COUNT(LAT_N) % 2 != 0 THEN ROUND((SELECT LAT_N FROM cte_middle2), 4)
    END AS Median
  FROM cte_temp
*/
