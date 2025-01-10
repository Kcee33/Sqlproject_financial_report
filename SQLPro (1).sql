
--Create a table into the database
create table financial_report(
      customer_id Int primary key,
      location varchar(50),
      amount_spent numeric,
      customer_name text,
      purchase_date date,
      payment_mode text);

-- Insert 50 rows of random data into the table(via AI)
INSERT INTO financial_report(customer_id, location, amount_spent, customer_name, purchase_date, payment_mode)
VALUES
(1, 'Lagos', 1500.75, 'John Doe', '2025-01-01', 'Credit Card'),
(2, 'Abuja', 2450.00, 'Jane Smith', '2025-01-02', 'Cash'),
(3, 'Port Harcourt', 3200.50, 'Michael Johnson', '2025-01-03', 'Mobile Payment'),
(4, 'Ibadan', 1800.25, 'Emily Davis', '2025-01-04', 'Credit Card'),
(5, 'Kano', 2700.40, 'Chris Brown', '2025-01-05', 'Cash'),
(6, 'Kaduna', 1350.60, 'Sarah Wilson', '2025-01-06', 'Mobile Payment'),
(7, 'Lagos', 2900.75, 'David Clark', '2025-01-07', 'Credit Card'),
(8, 'Abuja', 1620.40, 'Sophia Lopez', '2025-01-08', 'Cash'),
(9, 'Port Harcourt', 3100.90, 'James White', '2025-01-09', 'Credit Card'),
(10, 'Ibadan', 1285.50, 'Olivia Harris', '2025-01-10', 'Mobile Payment'),
(11, 'Kano', 2545.80, 'Liam Martinez', '2025-01-11', 'Cash'),
(12, 'Kaduna', 1745.70, 'Emma Robinson', '2025-01-12', 'Credit Card'),
(13, 'Lagos', 2890.90, 'Noah Lewis', '2025-01-13', 'Mobile Payment'),
(14, 'Abuja', 1450.20, 'Isabella Walker', '2025-01-14', 'Cash'),
(15, 'Port Harcourt', 3500.80, 'Mason Hall', '2025-01-15', 'Credit Card'),
(16, 'Ibadan', 1395.30, 'Mia Young', '2025-01-16', 'Cash'),
(17, 'Kano', 2675.25, 'Ethan Allen', '2025-01-17', 'Mobile Payment'),
(18, 'Kaduna', 1510.90, 'Harper King', '2025-01-18', 'Credit Card'),
(19, 'Lagos', 3010.70, 'William Wright', '2025-01-19', 'Cash'),
(20, 'Abuja', 1580.10, 'Evelyn Scott', '2025-01-20', 'Mobile Payment'),
(21, 'Port Harcourt', 3355.90, 'Lucas Adams', '2025-01-21', 'Credit Card'),
(22, 'Ibadan', 1255.60, 'Charlotte Baker', '2025-01-22', 'Cash'),
(23, 'Kano', 2490.70, 'Aiden Gonzalez', '2025-01-23', 'Mobile Payment'),
(24, 'Kaduna', 1600.40, 'Aria Nelson', '2025-01-24', 'Credit Card'),
(25, 'Lagos', 2780.20, 'Benjamin Carter', '2025-01-25', 'Cash'),
(26, 'Abuja', 1705.50, 'Ella Mitchell', '2025-01-26', 'Mobile Payment'),
(27, 'Port Harcourt', 3600.40, 'Henry Perez', '2025-01-27', 'Credit Card'),
(28, 'Ibadan', 1320.80, 'Avery Roberts', '2025-01-28', 'Cash'),
(29, 'Kano', 2645.75, 'Jack Turner', '2025-01-29', 'Mobile Payment'),
(30, 'Kaduna', 1500.25, 'Amelia Phillips', '2025-01-30', 'Credit Card'),
(31, 'Lagos', 3100.90, 'Alexander Campbell', '2025-01-31', 'Cash'),
(32, 'Abuja', 1595.40, 'Lily Parker', '2025-02-01', 'Mobile Payment'),
(33, 'Port Harcourt', 3450.20, 'Sebastian Evans', '2025-02-02', 'Credit Card'),
(34, 'Ibadan', 1275.50, 'Grace Edwards', '2025-02-03', 'Cash'),
(35, 'Kano', 2600.60, 'Oliver Collins', '2025-02-04', 'Mobile Payment'),
(36, 'Kaduna', 1750.70, 'Zoey Stewart', '2025-02-05', 'Credit Card'),
(37, 'Lagos', 2915.40, 'Daniel Flores', '2025-02-06', 'Cash'),
(38, 'Abuja', 1650.90, 'Chloe Morris', '2025-02-07', 'Mobile Payment'),
(39, 'Port Harcourt', 3280.60, 'Elijah Rogers', '2025-02-08', 'Credit Card'),
(40, 'Ibadan', 1405.50, 'Sofia Reed', '2025-02-09', 'Cash'),
(41, 'Kano', 2655.75, 'Matthew Jenkins', '2025-02-10', 'Mobile Payment'),
(42, 'Kaduna', 1580.30, 'Hannah Perry', '2025-02-11', 'Credit Card'),
(43, 'Lagos', 3050.25, 'Samuel Russell', '2025-02-12', 'Cash'),
(44, 'Abuja', 1615.40, 'Layla Simmons', '2025-02-13', 'Mobile Payment'),
(45, 'Port Harcourt', 3485.80, 'Levi Foster', '2025-02-14', 'Credit Card'),
(46, 'Ibadan', 1350.70, 'Riley Brooks', '2025-02-15', 'Cash'),
(47, 'Kano', 2520.40, 'Wyatt Ross', '2025-02-16', 'Mobile Payment'),
(48, 'Kaduna', 1660.80, 'Aubrey Bryant', '2025-02-17', 'Credit Card'),
(49, 'Lagos', 2995.20, 'Julian Alexander', '2025-02-18', 'Cash'),
(50, 'Abuja', 1735.50, 'Lillian Peterson', '2025-02-19', 'Mobile Payment');

--Determine the revenue by each location
SELECT 
     location,
    round( AVG (amount_spent),0) as revenue
from financial_report
group by location
order by revenue desc

-- RFM analysis by location segmentation
WITH City AS (
    SELECT 
        location,
        COUNT(*) AS purchase_count,
        ('2025-03-01'::date - MAX(purchase_date)) AS recency,
        ROUND(SUM(amount_spent)) AS total_amount
    FROM financial_report
    GROUP BY location
),
location_segment as (
select 
      location,
      purchase_count,
       recency,
      total_amount,
       
case
   when total_amount >= 25000 and recency <= 11 and purchase_count > 8 then 'High revenue'
when total_amount > 15000 or total_amount < 25000 and recency > 11 or recency < 14 and purchase_count < 9 then 'medium revenue'
 else 'low revenue'
 end as grade
from City
order by grade
)
select *
from location_segment


-- Most used payment method
select
   location,
   payment_mode,
   ROUND(Avg(amount_spent),0) as total_revenue
FROM financial_report
GROUP BY location,payment_mode
order BY total_revenue desc





