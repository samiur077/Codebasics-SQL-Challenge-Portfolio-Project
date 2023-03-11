drop view if exists qutr_sold_qtn;
CREATE VIEW qutr_sold_qtn AS
    SELECT 
        QUARTER(date) AS 'Quarter', sold_quantity
    FROM
        fact_sales_monthly
    WHERE
        YEAR(date) = '2020';

SELECT 
    Quarter, SUM(sold_quantity) AS Total_sold_quantity
FROM
    qutr_sold_qtn
GROUP BY Quarter
ORDER BY Total_sold_quantity DESC;