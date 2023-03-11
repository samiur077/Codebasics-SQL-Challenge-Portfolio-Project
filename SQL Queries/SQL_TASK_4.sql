# here we are creating a view for 2020 product counts
drop view if exists seg_prod_2020;
CREATE VIEW seg_prod_2020 AS
    SELECT 
        pd.segment, COUNT(DISTINCT gp.product_code) AS product_count
    FROM
        gdb023.dim_product pd
            JOIN
        fact_gross_price gp ON pd.product_code = gp.product_code
    WHERE
        gp.fiscal_year = '2020'
    GROUP BY pd.segment
    ORDER BY product_count DESC;

# here we are creating a view for 2021 product counts
drop view if exists seg_prod_2021;
CREATE VIEW seg_prod_2021 AS
    SELECT 
        pd.segment, COUNT(DISTINCT gp.product_code) AS product_count
    FROM
        gdb023.dim_product pd
            JOIN
        fact_gross_price gp ON pd.product_code = gp.product_code
    WHERE
        gp.fiscal_year = '2021'
    GROUP BY pd.segment
    ORDER BY product_count DESC;

# creating a view for 20 and 21 product counts
drop view if exists prod_count_21_20;
CREATE VIEW prod_count_21_20 AS
    SELECT 
        s20.segment,
        s20.product_count AS product_count_2020,
        s21.product_count AS product_count_2021
    FROM
        seg_prod_2020 s20
            JOIN
        seg_prod_2021 s21 ON s20.segment = s21.segment;
        
SELECT 
    *, (product_count_2021 - product_count_2020) AS difference
FROM
    prod_count_21_20
HAVING difference = (SELECT 
        MAX(product_count_2021 - product_count_2020)
    FROM
        prod_count_21_20);