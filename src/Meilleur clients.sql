-- REQUETE MEILLEURS CLIENTS --
SELECT customers.customernumber, customers.customername, sum(amount) AS total_amount
FROM customers
INNER JOIN payments ON customers.customernumber=payments.customernumber
GROUP BY customernumber
ORDER BY total_amount DESC;