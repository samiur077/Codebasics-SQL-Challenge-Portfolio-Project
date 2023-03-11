drop view if exists unique_products;
CREATE VIEW unique_products AS
    SELECT 
        COUNT(DISTINCT product_code) AS unique_products_2020,
        (SELECT 
                COUNT(DISTINCT product_code)
            FROM
                gdb023.fact_gross_price
            WHERE
                fiscal_year = '2021') AS unique_products_2021
    FROM
        gdb023.fact_gross_price
    WHERE
        fiscal_year = '2020';

SELECT 
    *,
    (unique_products_2021 - unique_products_2020) / unique_products_2020 * 100 AS percentage_chg
FROM
    unique_products
