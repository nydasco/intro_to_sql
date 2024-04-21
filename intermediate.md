## Eliminating Duplicates
We're getting a bit more advanced now. There are times when you might have a table, and you want to see what unique values exist in a column. There might be millions of records, but only a handful of unique values. For this, you can use the `DISTINCT` clause. This comes right at the top of the query before the column (or columns) that you want to look at.
```sql
SELECT DISTINCT
    region
FROM
    sale
```
The above will list out the regions that sales have occurred in. If there are only 4regions there will only be 4 results, even if there are millions of sales records.

![](https://github.com/nydasco/intro_to_sql/blob/main/images/distinct.png?raw=true)

## Combining Results
We've looked at joining tables together in a way that allows you to add columns from multiple tables to produce a wider dataset. But what if the tables have the same columns and you want to 'stack them' one on top of another to create a dataset that contains the combined data represented as more rows? For this, you can use the `UNION` statement.

## UNION and UNION ALL
Combining results from multiple queries is streamlined with UNION, which merges and removes duplicates, or UNION ALL, which includes all duplicates:
```sql
SELECT
    first_name,
    last_name
FROM
    employee
UNION
SELECT
    first_name,
    last_name
FROM
    client
```
The above will create a dataset that contains all first and last names for all employees and clients together.

![](https://github.com/nydasco/intro_to_sql/blob/main/images/union.png?raw=true)

By default, a `UNION` produces a distinct set of data. For clarity, you can also write this as `UNION DISTINCT`. If you have an employee that is also a client, their name will only be listed once. If you want to see it listed twice (once from each table), you can use the UNION ALL query.

## CTEs and Subqueries
As your queries become more complex, you will want to improve their structure for readability. Common Table Expressions (CTEs) and subqueries are powerful tools in SQL that can simplify complex queries, improve readability, and make your SQL scripts more maintainable. Below we can look into these in more depth.
### Common Table Expressions (CTEs)
CTEs, or Common Table Expressions, provide a way to define a temporary result set that you can reference within another SQL statement. They are often used to simplify complex joins, aggregations, or to isolate specific operations in SQL queries.
**Advantages of CTEs**
- **Readability:** CTEs make queries easier to read by breaking them into manageable, named blocks.
- **Maintainability:** Changes can be made easily in one place without needing to alter multiple areas of the query.
- **Recursive Queries:** CTEs support recursive queries, which are useful for dealing with hierarchical or tree-structured data, like organisational charts or category trees.

**Example Usage**
```sql
WITH RegionalSales AS (
    SELECT 
        region, 
        SUM(sale) AS total_sales
    FROM 
        sale
    GROUP BY 
        region
)

SELECT 
    region, 
    total_sales
FROM 
    RegionalSales
WHERE 
    total_sales > 20000
```
In this example, the CTE `RegionalSales` is used to calculate total sales by region, which is then referenced in the main query to filter regions greater than 20,000 in sales. This is a very simple example, which is an alternative to the above `HAVING` clause. But you can have multiple CTEs in a single query, and then bring them all together at the end with a number of joins in your final `SELECT` statement.

![](https://github.com/nydasco/intro_to_sql/blob/main/images/cte.png?raw=true)

### Subqueries
Subqueries are queries nested inside another query. They can be used in various parts of a main SQL statement, including SELECT, FROM, and WHERE clauses.
**Advantages of Subqueries**
- **Flexibility:** Subqueries can be used almost anywhere in SQL statements, allowing for dynamic construction of complex conditions and calculations.
- **Isolation:** Subqueries can isolate calculations and conditions within a query, making parts of the SQL statement independent from others.

**Example Usage**
```sql
SELECT 
    first_name,
    last_name,
    (
        SELECT 
            COUNT(*) 
        FROM 
            sale 
        WHERE 
            sale.employee_id = employee.id
    ) AS num_sales
FROM 
    employee
```
This example uses a subquery to count the number of sales for each employee directly in the SELECT clause.

![](https://github.com/nydasco/intro_to_sql/blob/main/images/subquery.png?raw=true)

## CTEs vs. Subqueries
**When to Use Which?**
- **Complexity and Performance:** CTEs can sometimes offer better performance for complex queries, especially when the same subquery would have to be executed multiple times in different parts of a query.
- **Recursion Needs:** If you need to perform a recursive operation, CTEs are the way to go.
- **Single Use Computations:** For conditions or calculations that are used only once, a subquery might be simpler and more direct.

Both CTEs and subqueries enhance the power and readability of SQL queries. The choice between using a CTE or a subquery often depends on the specific requirements of the query, such as the need for recursion, reuse of results, and the overall impact on readability and performance. The one piece of advice I would give however is that if you could write your query with either a CTE or a subquery, I would opt for the CTE every time. They are far easier to read and understand. It will make 'future you' happy when something goes wrong and you need to go back and debug your code.
