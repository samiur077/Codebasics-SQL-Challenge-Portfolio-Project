# creating customers with discount for 2021 year in descending order
drop view if exists customer_disct_21;
CREATE VIEW customer_disct_21 AS
    SELECT 
        customer_code, pre_invoice_discount_pct
    FROM
        gdb023.fact_pre_invoice_deductions
    WHERE
        fiscal_year = '2021'
    ORDER BY pre_invoice_discount_pct DESC;

# merging with dim_customer table 

SELECT 
    cd.customer_code,
    dc.customer,
    cd.pre_invoice_discount_pct AS average_discount_percentage
FROM
    customer_disct_21 cd
        JOIN
    dim_customer dc ON cd.customer_code = dc.customer_code
WHERE
    dc.market = 'India'
ORDER BY average_discount_percentage DESC
LIMIT 5;