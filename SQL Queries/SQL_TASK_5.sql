drop view if exists prod_max_min_cost;
CREATE VIEW prod_max_min_cost AS
    SELECT DISTINCT
        product_code,
        CASE
            WHEN
                manufacturing_cost = (SELECT 
                        MAX(manufacturing_cost)
                    FROM
                        gdb023.fact_manufacturing_cost)
            THEN
                manufacturing_cost
            WHEN
                manufacturing_cost = (SELECT 
                        MIN(manufacturing_cost)
                    FROM
                        gdb023.fact_manufacturing_cost)
            THEN
                manufacturing_cost
        END AS manufacturing_cost
    FROM
        gdb023.fact_manufacturing_cost
    HAVING manufacturing_cost IS NOT NULL;

SELECT 
    mn.product_code, pd.product, mn.manufacturing_cost
FROM
    prod_max_min_cost mn
        JOIN
    dim_product pd ON mn.product_code = pd.product_code
ORDER BY mn.manufacturing_cost DESC;