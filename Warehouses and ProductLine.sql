/* quantity of stored items in warehouse by asc order
   they show lowest amount of stored warehouse
*/
select w.warehouseCode,w.warehouseName, sum(p.quantityInStock) as stock_quantity
from warehouses as w
join products as p
on w.warehouseCode = p.warehouseCode
group by w.warehouseCode
order by stock_quantity asc;

/* quantity of stored items or product in warehouse by productLine 
   by asc order they show lowest amount of stored warehouse by productLine
*/

select w.warehouseName, p.productLine, count(p.productCode) as products, sum(p.quantityInStock) as stock_quantity
from warehouses as w
join products as p
on w.warehouseCode = p.warehouseCode
group by w.warehouseCode, p.productLine
order by stock_quantity asc;
/* they are show south & north warehouse is lowest amount of stock quantity
  
*/

/* 2) How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?
     To examine the relationship between inventory numbers and sales figures:
      This query links the `products` table with `orderdetails` to calculate the total quantity of each product ordered. 
		Compare the `quantityInStock` with the total ordered quantity to assess whether the inventory counts seem appropriate for each item.
*/
SELECT 
    p.productCode, 
    p.productName, 
    p.warehouseCode,
    p.quantityInStock, 
    COALESCE(SUM(od.quantityOrdered), 0) AS totalOrdered,
    cast((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 as decimal (10,2)) AS sale_Percentage
FROM 
    products p
LEFT JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    p.productCode, 
    p.productName, 
    p.quantityInStock,
    p.warehouseCode;
-- This will give you the sales percentage in relation to the quantity in stock for each product in dataset. 
-- Identifying items with no or zero orders, potential candidates for removal from the product line
SELECT p.productCode, p.productName, p.quantityInStock, p.warehouseCode, SUM(od.quantityOrdered) AS totalOrdered
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
HAVING totalOrdered IS NULL OR totalOrdered = 0;