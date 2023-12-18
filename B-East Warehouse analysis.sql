# 'b', 'East', '219183'

SELECT 
    p.productCode, 
    p.productName, 
    p.warehouseCode as East,
    p.productLine as line,
    p.quantityInStock as East_warehouse_stock, 
    COALESCE(SUM(od.quantityOrdered), 0) AS total_Ordered,
    cast((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 as decimal (10,2)) AS sale_Percentage
FROM 
    products p
LEFT JOIN 
    orderdetails od ON p.productCode = od.productCode
where p.warehouseCode = 'b'
GROUP BY 
    p.productCode, 
    p.productName, 
    p.quantityInStock,
    p.warehouseCode
order by sale_percentage asc;

# overstocked items in east warehouse

# lowstocked items in east warehouse

# understocked items in east warehouse


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
        p.warehouseCode = 'b'
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
# it is observed that this warehouse has more number of overstock products as compared to other warehouses, there in a need to reduce their quantity immediately.
/*
1985 Toyota Supra
1995 Honda Civic
2002 Chevy Corvette
1976 Ford Gran Torino
1965 Aston Martin DB5
1968 Dodge Charger
1999 Indy 500 Monte Carlo SS
1948 Porsche Type 356 Roadster
1948 Porsche 356-A Roadster
1966 Shelby Cobra 427 S/C
1982 Lamborghini Diablo
1961 Chevrolet Impala
1971 Alpine Renault 1600s
1952 Alpine Renault 1300
1992 Porsche Cayenne Turbo Silver
1969 Dodge Charger
1962 LanciaA Delta 16V
1969 Corvair Monza
1982 Camaro Z28
1970 Plymouth Hemi Cuda
1956 Porsche 356A Coupe
1970 Triumph Spitfire
1969 Chevrolet Camaro Z28
1998 Chrysler Plymouth Prowler
1992 Ferrari 360 Spider red
1993 Mazda RX-7
1957 Ford Thunderbird
1970 Dodge Coronet
2001 Ferrari Enzo
*/
SELECT p.productCode, p.productName, p.quantityInStock,p.warehouseCode, SUM(od.quantityOrdered) AS totalOrdered
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
HAVING totalOrdered IS NULL OR totalOrdered = 0;
-- This query uses to identify products with no orders or zero orders,
-- indicating items that are not moving. Review these items to consider whether they should be removed from the product line.
/*
1985 Toyota Supra
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
        p.warehouseCode = 'b'
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
 1969 Ford Falcon
 1957 Corvette Convertible
 1970 Chevy Chevelle SS 454
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
        p.warehouseCode = 'b'
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
# these one product in this warehouse seem to be in constant demand but their understocked value
# indicates that they are not meeting the demand and need to be restocked immediately.
-- 1968 Ford Mustang
    
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
        p.warehouseCode = 'b'
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