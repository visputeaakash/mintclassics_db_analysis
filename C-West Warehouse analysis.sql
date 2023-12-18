# C- WEST Warehouse 

SELECT 
    p.productCode, 
    p.productName, 
    p.warehouseCode as west,
    p.productLine as line,
    p.quantityInStock as west_warehouse_stock, 
    COALESCE(SUM(od.quantityOrdered), 0) AS total_Ordered,
    cast((COALESCE(SUM(od.quantityOrdered), 0) / NULLIF(p.quantityInStock, 0)) * 100 as decimal (10,2)) AS sale_Percentage
FROM 
    products p
LEFT JOIN 
    orderdetails od ON p.productCode = od.productCode
where p.warehouseCode = 'c'
GROUP BY 
    p.productCode, 
    p.productName, 
    p.quantityInStock,
    p.warehouseCode

order by sale_percentage asc;

# overstocked items in west warehouse

# lowstocked items in west warehouse

# understocked items in west warehouse


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
        p.warehouseCode = 'c'
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
1940 Ford Delivery Sedan
1939 Chevrolet Deluxe Coupe
1939 Cadillac Limousine
1937 Lincoln Berline
1936 Mercedes-Benz 500K Special Roadster
1936 Chrysler Airflow
1934 Ford V8 Coupe
1932 Model A Ford J-Coupe
1932 Alfa Romeo 8C2300 Spider Sport
1930 Buick Marquette Phaeton
1917 Maxwell Touring Car
1913 Ford Model T Speedster
1912 Ford Model T Delivery Wagon
1904 Buick Runabout
1903 Ford Model A
18th Century Vintage Horse Carriage
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
        p.warehouseCode = 'c'
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
#there is no lowest stocked product in this warehouse

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
        p.warehouseCode = 'c'
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
# these tree products in this warehouse seem to be in constant demand but their understocked value indicates that
# they are not meeting the demand and need to be restocked.
/*
1911 Ford Town Car
1928 Mercedes-Benz SSK
1928 Ford Phaeton Deluxe
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
        p.warehouseCode = 'c'
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