-- Regrouper 2 tables (orderdetails et products via la clé commune productCode), regrouper toutes les totalQuantity (produits commandés)
-- pour faire une somme. Ensuite on les ordonne (par ordre decroissant) et on met LIMIT 5 pour fafficher que les 5 premiers
SELECT orderdetails.productCode, products.productLine, products.productName, SUM(orderdetails.quantityOrdered) AS totalQuantity,
 SUM(orderdetails.priceEach * orderdetails.quantityOrdered) AS totalAmount, products.quantityInStock
FROM orderdetails
INNER JOIN products ON orderdetails.productCode = products.productCode
GROUP BY orderdetails.productCode
ORDER BY totalQuantity DESC
LIMIT 5;