-- 1) Je veux connaître mon chiffre d'affaire des deux derniers mois par pays

SELECT offices.country, DATE_FORMAT(orders.orderDate, "%Y-%m") AS mois ,SUM(orderdetails.quantityOrdered * orderdetails.priceEach) as Turnover 
FROM orders
INNER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN customers ON customers.customerNumber = orders.customerNumber
INNER JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
INNER JOIN offices ON offices.officeCode = employees.officeCode
WHERE DATE_FORMAT(orders.orderDate, "%Y-%m-%d") >= DATE_SUB(DATE_FORMAT(NOW(),"%Y-%m-01"), INTERVAL 2 MONTH) AND DATE_FORMAT(orders.orderDate, "%Y-%m-%d") < DATE_FORMAT(NOW(), "%Y-%m-01")	 			-- Or put NOW() to display the day 
GROUP BY offices.country, mois
ORDER BY offices.country, mois DESC;






