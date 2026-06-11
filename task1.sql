-- 1. Ім'я, прізвище, номер департаменту та назва департаменту для кожного працівника
SELECT e.first_name, e.last_name, e.department_id, d.depart_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 2. Ім'я, прізвище, назва департаменту, місто та регіон для кожного працівника
SELECT e.first_name, e.last_name, d.depart_name, l.city, l.state_province
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;

-- 3. Ім'я, прізвище, номер та назва департаменту для працівників з департаментів 80 або 40
SELECT e.first_name, e.last_name, e.department_id, d.depart_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IN (40, 80);

-- 4. Усі департаменти, включаючи ті, де немає жодного працівника
SELECT d.department_id, d.depart_name, e.first_name, e.last_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

-- 5. Ім'я кожного працівника разом з ім'ям його менеджера
SELECT e.first_name AS "Employee Name", m.first_name AS "Manager Name"
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 6. Назва посади, повне ім'я працівника та різниця між максимальною зарплатою для цієї посади і реальної зарплатою працівника
SELECT j.job_title, (e.first_name || ' ' || e.last_name) AS "Full Name", (j.max_salary - e.salary) AS "Salary Difference"
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id;

-- 7. Назва посади та середня зарплата працівників на цій посаді
SELECT j.job_title, ROUND(AVG(e.salary), 2) AS "Average Salary"
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title;

-- 8. Повне ім'я та зарплата тих працівників, які працюють у будь-якому департаменті, розташованому в Лондоні
SELECT (e.first_name || ' ' || e.last_name) AS "Full Name", e.salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'London';

-- 9. Назва департаменту та кількість працівників у кожному з них
SELECT d.depart_name, COUNT(e.employee_id) AS "Employee Count"
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.depart_name;