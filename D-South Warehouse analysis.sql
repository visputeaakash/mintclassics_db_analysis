#'d', 'South', '79380'


SELECT 
    p.productCode, 
    p.productName, 
    p.warehouseCode as south,
    p.productLine as line,
    p.quantityInStock as South_warehouse_stock, 
    COALESCE(SUM(od.quantityOrdered), 0) AS total_Ordered,
    cast((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 as decimal (10,2)) AS sale_Percentage
FROM 
    products p
LEFT JOIN 
    orderdetails od ON p.productCode = od.productCode
where p.warehouseCode = 'd'
GROUP BY 
    p.productCode, 
    p.productName, 
    p.quantityInStock,
    p.warehouseCode
order by sale_percentage asc;

# overstocked items in south warehouse

# lowstocked items in south warehouse

# understocked items in south warehouse


WITH south_warehouse_inventory_status AS (
    SELECT 
        p.productCode, 
        p.productName, 
        p.warehouseCode ,
        p.productLine ,
        p.quantityInStock , 
        COALESCE(SUM(od.quantityOrdered), 0) AS total_Ordered,
        CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2)) AS sale_Percentage,
        CASE 
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) < 30 THEN 'Overstock'
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) >= 70 AND (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) < 100 THEN 'Lowstock'
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) >= 100 THEN 'Understock'
            ELSE 'Well-Stocked'
        END AS statuses
    FROM 
        products AS p
    LEFT JOIN 
        orderdetails AS od ON p.productCode = od.productCode
    WHERE 
        p.warehouseCode = 'd'
    GROUP BY 
        p.productCode, 
        p.productName, 
        p.quantityInStock,
        p.warehouseCode
    order by sale_percentage asc    
)
SELECT 
    productCode, 
    productName, 
    warehouseCode,
    productLine,
    quantityInStock,
    total_Ordered,
    sale_Percentage
FROM 
    south_warehouse_inventory_status
WHERE 
    statuses = 'Overstock';
# although this product overstock in these warehouse appears to be much higher than the demand, there in a need to reduce their quantity.
/*
1950's Chicago Surface Lines Streetcar
1964 Mercedes Tour Bus
Collectable Wooden Train
The USS Constitution Ship
1957 Chevy Pickup
The Queen Mary
1980’s GM Manhattan Express
1999 Yamaha Speed Boat
HMS Bounty
*/

WITH south_warehouse_inventory_status AS (
    SELECT 
        p.productCode, 
        p.productName, 
        p.warehouseCode ,
        p.productLine ,
        p.quantityInStock , 
        COALESCE(SUM(od.quantityOrdered), 0) AS total_Ordered,
        CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2)) AS sale_Percentage,
        CASE 
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) < 30 THEN 'Overstock'
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) >= 70 AND (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) < 100 THEN 'Lowstock'
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) >= 100 THEN 'Understock'
            ELSE 'Well-Stock'
        END AS statuses
    FROM 
        products AS p
    LEFT JOIN 
        orderdetails AS od ON p.productCode = od.productCode
    WHERE 
        p.warehouseCode = 'd'
    GROUP BY 
        p.productCode, 
        p.productName, 
        p.quantityInStock,
        p.warehouseCode
)
SELECT 
    productCode, 
    productName, 
    warehouseCode,
    productLine,
    quantityInStock,
    total_Ordered,
    sale_Percentage
FROM 
    south_warehouse_inventory_status
WHERE 
    statuses = 'lowstock';
 # due to the increasing demamd of this product, the stock of this product in showing signs of depleting soon,
 # but the stock of this product needs to be restocked as soon as possible.
/*
Diamond T620 Semi-Skirted Tanker 
 */
 
 
WITH south_warehouse_inventory_status AS (
    SELECT 
        p.productCode, 
        p.productName, 
        p.warehouseCode ,
        p.productLine ,
        p.quantityInStock , 
        COALESCE(SUM(od.quantityOrdered), 0) AS total_Ordered,
        CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2)) AS sale_Percentage,
        CASE 
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) < 30 THEN 'Overstock'
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) >= 70 AND (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) < 100 THEN 'Lowstock'
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) >= 100 THEN 'Understock'
            ELSE 'Well-Stock'
        END AS statuses
    FROM 
        products AS p
    LEFT JOIN 
        orderdetails AS od ON p.productCode = od.productCode
    WHERE 
        p.warehouseCode = 'd'
    GROUP BY 
        p.productCode, 
        p.productName, 
        p.quantityInStock,
        p.warehouseCode
)
SELECT 
    productCode, 
    productName, 
    warehouseCode,
    productLine,
    quantityInStock,
    total_Ordered,
    sale_Percentage
FROM 
    south_warehouse_inventory_status
WHERE 
    statuses = 'Understock';
# these tree products in this warehouse seem to be in constant demand but their
# understocked value indicates that they are not meeting the demand and need to be urgent restocked.
/*
1996 Peterbilt 379 Stake Bed with Outrigger
The Mayflower
Pont Yacht
*/

    
WITH south_warehouse_inventory_status AS (
    SELECT 
        p.productCode, 
        p.productName, 
        p.warehouseCode ,
        p.productLine ,
        p.quantityInStock , 
        COALESCE(SUM(od.quantityOrdered), 0) AS total_Ordered,
        CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2)) AS sale_Percentage,
        CASE 
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) < 30 THEN 'Overstock'
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) >= 70 AND (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) < 100 THEN 'Lowstock'
            WHEN (CAST((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 AS DECIMAL(10,2))) >= 100 THEN 'Understock'
            ELSE 'Well-Stock'
        END AS statuses
    FROM 
        products AS p
    LEFT JOIN 
        orderdetails AS od ON p.productCode = od.productCode
    WHERE 
        p.warehouseCode = 'd'
    GROUP BY 
        p.productCode, 
        p.productName, 
        p.quantityInStock,
        p.warehouseCode
)
SELECT 
    productCode, 
    productName, 
    warehouseCode,
    productLine,
    quantityInStock,
    total_Ordered,
    sale_Percentage
FROM 
    south_warehouse_inventory_status
WHERE 
    statuses = 'well-stock';
    