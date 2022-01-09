/*
Output: company_code, founder name, total number of lead managers, total number of senior manager, total of number of managers, and total number of employees.
ASC by company_code
Join company to employee table
*/
SELECT c.*
     , COUNT(DISTINCT e.lead_manager_code)
     , COUNT(DISTINCT e.senior_manager_code)
     , COUNT(DISTINCT e.manager_code)
     , COUNT(DISTINCT e.employee_code)
  FROM company AS c, employee AS e
 WHERE c.company_code = e.company_code
 GROUP BY c.company_code, c.founder
 ORDER BY c.company_code ASC
