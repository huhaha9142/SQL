-- Q1
SELECT count(manager_id) haveMgrCount
FROM employees
WHERE manager_id IS NOT NULL;

-- Q2
SELECT MAX(salary) 최고임금, MIN(salary) 최저임금,
    MAX(salary) - MIN(salary) "최고임금 - 최저임금"
FROM employees;

-- Q3
SELECT TO_CHAR(MAX(hire_date), 'YYYY"년" MM"월" DD"일"')
FROM employees;

-- Q4
SELECT department_id, 
    avg(salary), max(salary), min(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id DESC;

-- Q5
SELECT job_id, ROUND(AVG(salary)), 
    MIN(salary), MAX(SALARY)
FROM employees
GROUP BY job_id
ORDER BY MIN(salary) DESC, AVG(salary) ASC;

-- Q6
SELECT TO_CHAR(MIN(hire_date), 'yyyy-mm-dd day')
FROM employees;