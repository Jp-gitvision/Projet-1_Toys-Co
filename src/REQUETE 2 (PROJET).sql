-- 2) Je veux connaître les 2 meilleurs vendeurs du DERNIER mois (c'est à dire ceux qui ont le meilleur CA)

SELECT customers.salesRepEmployeeNumber AS ID_employee, employees.lastName, employees.firstName, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS Turnover, MONTHNAME(OrderDate) AS mois
FROM customers
INNER JOIN payments ON payments.customerNumber = customers.customerNumber
INNER JOIN orders ON orders.customerNumber = customers.customerNumber
INNER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE orderDate >= DATE_FORMAT(NOW(), '%Y-%m-01') - INTERVAL 1 MONTH AND orderDate < DATE_FORMAT(NOW(), '%Y-%m-01')GROUP BY mois, ID_employee, employees.lastName, employees.firstName
ORDER BY Turnover DESC
LIMIT 2;


WHERE orderDate >= DATE_FORMAT(NOW(), '%Y-%m-01') - INTERVAL 1 MONTH AND orderDate < DATE_FORMAT(NOW(), '%Y-%m-01')
GROUP BY ID_employee, employees.lastName, employees.firstName
ORDER BY Turnover DESC
LIMIT 2;