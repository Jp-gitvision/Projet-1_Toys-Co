-- REQUETES SALES --

-- Je veux connaître le nombre de produits vendus par catégorie et par mois, comparés au mois de l'année précédente avec taux de variation.

SELECT productlines.productline AS category,
DATE_FORMAT(orderdate, '%Y-%m') AS date_month_year,
SUM(orderdetails.quantityordered) AS nb_ordered_products
	FROM products
    INNER JOIN orderdetails ON products.productcode=orderdetails.productcode
    INNER JOIN productlines ON products.productline=productlines.productline
    INNER JOIN orders ON orderdetails.ordernumber=orders.ordernumber
    GROUP BY category, DATE_FORMAT(orderdate, '%Y-%m')
    ORDER BY category ASC, date_month_year DESC;