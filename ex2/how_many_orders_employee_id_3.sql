USE pizza_store;
SELECT count(*) FROM `order`
JOIN employee ON `order`.employeeId = employee.employeeId
WHERE `order`.employeeId = 3;