# 'a', 'North', '131688'

SELECT 
    p.productCode, 
    p.productName, 
    p.warehouseCode as north,
    p.productLine as line,
    p.quantityInStock as north_warehouse_stock, 
    COALESCE(SUM(od.quantityOrdered), 0) AS total_Ordered,
    cast((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 as decimal (10,2)) AS sale_Percentage
FROM 
    products p
LEFT JOIN 
    orderdetails od ON p.productCode = od.productCode
where p.warehouseCode = 'a'
GROUP BY 
    p.productCode, 
    p.productName, 
    p.quantityInStock,
    p.warehouseCode

order by sale_percentage asc;

# overstocked items in north warehouse

# lowstocked items in north warehouse

# understocked items in north warehouse


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
        p.warehouseCode = 'a'
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
1982 Ducati 996 R
America West Airlines B757-200
2002 Suzuki XREO
American Airlines: MD-11S
1957 Vespa GS150
1969 Harley Davidson Ultimate Chopper
ATA: B757-300
1982 Ducati 900 Monster
1997 BMW R 1100 S
1996 Moto Guzzi 1100i
American Airlines: B767-300
Corsair F4U ( Bird Cage)
1900s Vintage Bi-Plane
2003 Harley-Davidson Eagle Drag Bike
1980s Black Hawk Helicopter
Boeing X-32A JSF
1936 Harley Davidson El Knucklehead
1928 British Royal Navy Airplane
1974 Ducati 350 Mk3 Desmo
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
        p.warehouseCode = 'a'
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
 P-51-D Mustang
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
        p.warehouseCode = 'a'
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
# these four product in this warehouse seem to be in constant demand but their understocked value
# indicates that they are not meeting the demand and need to be restocked immediately.
/*
1960 BSA Gold Star DBD34
1997 BMW F650 ST
2002 Yamaha YZR M1
F/A 18 Hornet 1/72
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
        p.warehouseCode = 'a'
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