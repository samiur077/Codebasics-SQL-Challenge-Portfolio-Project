drop view if exists gross_sales_channel;
CREATE VIEW gross_sales_channel AS
    SELECT 
        dc.channel,
        (fs.sold_quantity * fg.gross_price) AS gross_sales,
        fs.fiscal_year
    FROM
        fact_sales_monthly fs
            JOIN
        fact_gross_price fg ON fs.product_code = fg.product_code
            JOIN
        dim_customer dc ON fs.customer_code = dc.customer_code
    WHERE
        fs.fiscal_year = '2021'
            AND fs.fiscal_year = fg.fiscal_year;

drop view if exists Total_sales_by_channel;
CREATE VIEW Total_sales_by_channel AS
    SELECT 
        channel, SUM(gross_sales) AS Total_sales
    FROM
        gross_sales_channel
    GROUP BY channel;
    
    
SELECT 
    channel,
    (Total_sales / 1000000) AS gross_sales_mln,
    Total_sales / (SELECT 
            SUM(Total_sales)
        FROM
            Total_sales_by_channel) * 100 AS percentage
FROM
    Total_sales_by_channel
GROUP BY channel
ORDER BY percentage DESC;