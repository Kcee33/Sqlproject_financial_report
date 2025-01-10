 # **Financial Report Analysis**
  
This project contains SQL scripts designed to manage and analyze financial data from a set of customers, including revenue tracking, segmentation, and payment method analysis.

# Background

Driven by a quest to use my analytical skills to resolve real word business problems and draw out insights to profer business intelligence solutions.

**The key questions i wanted to analyse through my query were;**

-Revenue by location

-RFM (Recency, Frequency, Monetary) analysis by location

-Payment method analysis


# SQL Scripts

**Creating the Table**

The first SQL command creates a table financial_report with the following columns:

```customer_id (Primary Key)```

```location```

```amount_spent```

```customer_name```

```purchase_date```

```payment_mode```


```sql
create table financial_report(
      customer_id Int primary key,
      location varchar(50),
      amount_spent numeric,
      customer_name text,
      purchase_date date,
      payment_mode text);
```

**Inserting Data**
Using AI i randomly generated values to table customer purchases, including location, amount spent, and payment method.

```sql
INSERT INTO financial_report(customer_id, location, amount_spent, customer_name, purchase_date, payment_mode)
VALUES
(1, 'Lagos', 1500.75, 'John Doe', '2025-01-01', 'Credit Card'),
...
(50, 'Abuja', 1735.50, 'Lillian Peterson', '2025-02-19', 'Mobile Payment');
```

**Revenue Calculation**

This query calculates the average revenue by location and sorts the results by net revenue

```sql
SELECT 
     location,
    round( AVG (amount_spent),0) as revenue
FROM financial_report
GROUP BY location
ORDER BY revenue DESC;
```
 
![image](https://github.com/user-attachments/assets/b2199fdc-0afb-419d-86f6-f0c25f66a035)




**Top revenue by locations**![image](https://github.com/user-attachments/assets/36b4fec7-d7b8-45d2-9f7f-be5d07265fef)


**RFM Analysis**

The query computes RFM metrics (Recency, Frequency, Monetary) for each location. It segments locations based on:

```Total Amount```: Sum of money spent.

```Recency```: Days since the last purchase.

```Purchase Count```: Number of purchases.

A custom segmentation is then applied to categorize locations as either 'High revenue', 'Medium revenue', or 'Low revenue'.

```sql
WITH City AS (
    SELECT 
        location,
        COUNT(*) AS purchase_count,
        ('2025-03-01'::date - MAX(purchase_date)) AS recency,
        ROUND(SUM(amount_spent)) AS total_amount
    FROM financial_report
    GROUP BY location
),
location_segment AS (
    SELECT 
        location,
        purchase_count,
        recency,
        total_amount,
        CASE
            WHEN total_amount >= 25000 AND recency <= 11 AND purchase_count > 8 THEN 'High revenue'
            WHEN total_amount > 15000 OR total_amount < 25000 AND recency > 11 OR recency < 14 AND purchase_count < 9 THEN 'Medium revenue'
            ELSE 'Low revenue'
        END AS grade
    FROM City
    ORDER BY grade
)
SELECT *
FROM location_segment;
```

![image](https://github.com/user-attachments/assets/94a8f456-d814-4283-939f-59b00d4cb063)

**Most Used Payment Method**

This query calculates the average revenue by location and payment method, sorting the results by total revenue in descending order.

```sql
SELECT
   location,
   payment_mode,
   ROUND(Avg(amount_spent),0) as total_revenue
FROM financial_report
GROUP BY location, payment_mode
ORDER BY total_revenue DESC;
```

![image](https://github.com/user-attachments/assets/35f99853-572c-4658-ad16-965e0846c2b8)

# Technologies Used
**SQL** for data manipulation and analysis.

**PostgreSQL** or any relational database management system (RDBMS) to run the SQL queries.

**AI(Chatgpt)** for generating random values and also for debugging some queries and also for generating visualisation

# What I Learned
**Through this project, I gained valuable experience in:**

**SQL Table Creation and Management:** I practiced creating tables and defining relationships between columns (e.g., using PRIMARY KEY) to ensure data integrity.

**Data Insertion:** I learned how to generate and insert random data into a database to simulate real-world scenarios.

**Revenue and Financial Analysis:** I enhanced my skills in calculating revenue by location and understanding how to segment and group data for deeper insights.

**RFM (Recency, Frequency, Monetary) Analysis:** I learned how to apply RFM analysis for customer segmentation, using metrics like recency, purchase frequency, and total spend to categorize locations based on revenue potential.

**Payment Method Analysis:** I explored how to analyze the usage of different payment methods and their correlation with revenue generation.

These skills have strengthened my data analysis capabilities, particularly in the context of business intelligence and customer insights.

# Conclusion
This project provided a great opportunity to dive deeper into SQL, hone my data analysis skills, and apply concepts like revenue tracking, location segmentation, and payment method analysis. The insights derived from these analyses would be useful for businesses aiming to understand customer behavior, optimize revenue streams, and make informed decisions based on location and payment preferences.

As a result, this project showcases the practical application of data analysis in business, with a focus on financial performance across different locations and payment methods.





