SELECT 
    market, customer, region
FROM
    gdb023.dim_customer
WHERE
    customer = 'Atliq Exclusive'
        AND region = 'APAC'