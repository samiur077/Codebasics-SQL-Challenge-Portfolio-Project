# creating table for the required customers
drop view if exists customer_atliq_excl;
CREATE VIEW customer_atliq_excl AS
    SELECT 
        customer_code
    FROM
        dim_customer
    WHERE
        dim_customer.customer = 'Atliq Exclusive';

# merging that table with sales_monthly table
drop view if exists fact_sales_monthly_atliq_excl;
CREATE VIEW fact_sales_monthly_atliq_excl AS
    SELECT 
        fs.*
    FROM
        fact_sales_monthly fs
            JOIN
        customer_atliq_excl cae ON fs.customer_code = cae.customer_code;
    
# creating the final view 
drop view if exists final_table_gross_sales;
CREATE VIEW final_table_gross_sales AS
    SELECT 
        MONTH(fsa.date) AS 'Month',
        YEAR(fsa.date) AS 'Year',
        (fsa.sold_quantity * fg.gross_price) AS 'Gross Sales Amount'
    FROM
        fact_sales_monthly_atliq_excl fsa
            INNER JOIN
        fact_gross_price fg ON fsa.product_code = fg.product_code
    WHERE
        fsa.fiscal_year = fg.fiscal_year;


SELECT 
    Month,
    Year,
    SUM(`Gross Sales Amount`) AS 'Gross Sales Amount'
FROM
    final_table_gross_sales
GROUP BY Month , Year;
