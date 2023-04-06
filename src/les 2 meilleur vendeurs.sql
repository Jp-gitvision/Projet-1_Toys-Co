/* REQUETE 2 MEILLEURS VENDEURS AVEC SOUS REQUETE 

Select TOUT de (
	Sous requete (sorte de table temporaire juste pour cette requete) à partir des données sélectionnées dans le code précédent
    Ajout du rang avec "ROW_NUMBER() OVER (PARTITION BY : partage les données par DATE (mois, année), ORDER BY : ordonné par chiffre d'affaire DESC) AS "ranking" 
    Sans la sous requete, on a tous les vendeurs et leur CA groupés par mois, mais pas les 2 meilleurs seulement. 
    
    On ajoute les jointures comme dans le code précédent, le group by)
    
	AS (nom de la sous requete ou table temporaire) : topranking (on utilisera le nom de sous requete comme une table ensuite)

OÙ le ranking calculé dans la sous requete topranking (topranking.ranking) est inférieur ou égal à 2 

ORDER BY date (du + récent au + vieux) ET turnover (du meilleur au moins bon) 
*/

SELECT * FROM (
	SELECT 
	ROW_NUMBER() OVER(PARTITION BY DATE_FORMAT(orderdate, '%Y-%m') ORDER BY SUM(orderdetails.quantityOrdered * orderdetails.priceEach) DESC) AS ranking, 
	customers.salesRepEmployeeNumber AS ID_employee, employees.lastName, employees.firstName, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS Turnover, 
	DATE_FORMAT(orderdate, '%Y-%m') AS mois
	FROM customers
	INNER JOIN payments ON payments.customerNumber = customers.customerNumber
	INNER JOIN orders ON orders.customerNumber = customers.customerNumber
	INNER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
	INNER JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
	GROUP BY mois, ID_employee, employees.lastName, employees.firstName, DATE_FORMAT(orderdate, '%Y-%m')
) AS topranking
WHERE topranking.ranking <= 2
ORDER BY mois DESC, Turnover DESC;