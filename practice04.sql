-- Q1

SELECT COUNT(salary) 
FROM employees
WHERE salary > ( SELECT AVG(salary)
                    FROM employees );

-- Q2
-- 사용할 서브쿼리
SELECT AVG(salary) avgSalary,
                        MAX(salary) maxSalary
                    FROM employees;
-- 답                    
SELECT e.employee_id, e.first_name,
    e.salary, t.avgSalary, t.maxSalary
FROM employees e, ( SELECT AVG(salary) avgSalary,
                        MAX(salary) maxSalary
                    FROM employees ) t
WHERE e.salary BETWEEN t.avgSalary AND t.maxSalary
ORDER BY salary;

-- Q3
-- 쿼리1. Steven King이 소속된 부서
SELECT department_id FROM employees
WHERE first_name='Steven' AND last_name='King';
-- 쿼리2. Steven King이 소속된 부서가 위치한 location 정보
SELECT location_id FROM departments
WHERE department_id = ( SELECT department_id 
                        FROM employees
                        WHERE first_name='Steven' 
                            AND last_name='King' );
-- 최종 쿼리
SELECT location_id,
    street_address, 
    postal_code,
    city,
    state_province,
    country_id
FROM locations
WHERE location_id = ( SELECT location_id 
                        FROM departments
                        WHERE department_id = 
                            ( SELECT department_id 
                                FROM employees
                                WHERE first_name='Steven' 
                                    AND last_name='King' 
                            )
                        );

-- Q4.
-- 쿼리 1:
SELECT salary FROM employees WHERE job_id='ST_MAN';
-- 최종 쿼리:
SELECT employee_id, first_name, salary
FROM employees
WHERE salary <ANY (SELECT salary 
                 FROM employees WHERE job_id='ST_MAN');

-- Q5
-- 쿼리 1
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

-- 최종 쿼리: 조건절 비교
SELECT employee_id, first_name,
    salary, department_id
FROM employees 
WHERE (department_id, salary) IN 
    ( SELECT department_id, MAX(salary)
        FROM employees
        GROUP BY department_id )
ORDER BY salary DESC;

-- 최종쿼리: 테이블 조인
SELECT e.employee_id, e.first_name,
    e.salary, e.department_id
FROM employees e, 
    ( SELECT department_id, MAX(salary) salary
        FROM employees
        GROUP BY department_id ) t
WHERE e.department_id = t.department_id AND
    e.salary = t.salary 
ORDER BY e.salary DESC;

-- Q6
-- 쿼리1
SELECT job_id, SUM(salary) sumSalary
FROM employees GROUP BY job_id;
-- 최종 쿼리
SELECT j.job_title,
    t.sumSalary
FROM jobs j, ( SELECT 
                    job_id, 
                    SUM(salary) sumSalary
                FROM employees GROUP BY job_id ) t
WHERE j.job_id = t.job_id
ORDER BY t.sumSalary DESC;

-- Q7
-- 쿼리1: 부서별 평균 급여
SELECT department_id, AVG(salary) salary 
FROM employees GROUP BY department_id;

-- 최종 쿼리
SELECT e.employee_id,
    e.first_name,
    e.salary
FROM employees e, 
    ( SELECT department_id, AVG(salary) salary 
        FROM employees GROUP BY department_id ) t
WHERE e.department_id = t.department_id AND
    e.salary > t.salary; 
    
    -- Q8
-- 쿼리 1
SELECT ROWNUM,
    employee_id,
    first_name,
    salary
    hire_date
FROM employees
ORDER BY hire_date asc;

-- 쿼리 2
SELECT rownum rn,
    employee_id,
    first_name,
    salary,
    hire_date
FROM ( SELECT
            employee_id,
            first_name,
            salary,
            hire_date
        FROM employees
        ORDER BY hire_date asc
    );
-- 최종 쿼리

SELECT rn,
    employee_id,
    first_name,
    salary,
    hire_date
FROM (
    SELECT rownum rn,
        employee_id,
        first_name,
        salary,
        hire_date
    FROM ( SELECT
                employee_id,
                first_name,
                salary,
                hire_date
            FROM employees
            ORDER BY hire_date asc
        )
    )
WHERE rn BETWEEN 11 AND 15;