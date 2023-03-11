drop view if exists divsion_prod_sold_qtn;
CREATE VIEW divsion_prod_sold_qtn AS
    SELECT 
        dp.division, fs.product_code, dp.product, fs.sold_quantity
    FROM
        fact_sales_monthly fs
            JOIN
        dim_product dp ON fs.product_code = dp.product_code
    WHERE
        fiscal_year = '2021'
    ORDER BY sold_quantity DESC;


drop view if exists total_sold_qtn_by_div;
CREATE VIEW total_sold_qtn_by_div AS
    SELECT 
        division,
        product_code,
        product,
        SUM(sold_quantity) AS Total_sold_quantity
    FROM
        divsion_prod_sold_qtn
    GROUP BY division , product_code , product
    ORDER BY Total_sold_quantity DESC;
    
## final touch

select * from (select *,
row_number() over(partition by division order by Total_sold_quantity DESC) as rank_order
from total_sold_qtn_by_div) ranks
where rank_order <=3;