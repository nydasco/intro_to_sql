# Introduction to SQL: A Beginner's Guide
My introduction to the world of databases began at university with Microsoft SQL Server 2000. Since those early days, the landscape of database technology has evolved dramatically. Beyond the traditional tabular databases, today's options range from Column Store databases like ClickHouse and Snowflake to Graph Databases like Neo4J and ArangoDB, and even Vector Store databases such as ChromaDB and Pinecone. Despite this diversity, the foundational skills in SQL remain crucial.

This article aims to provide a straightforward introduction to SQL. Designed for simplicity, it's perfect for those just starting out. SQL is indispensable in roles such as Data Analysts and Data Engineers, offering a way to query data, configure database structures, and more. We will explore basic SQL functionalities including selecting fields, filtering records, aggregating data, understanding different types of joins, and implementing effective coding approaches like Common Table Expressions (CTEs) and subqueries. Let's dive into the basics and build a solid foundation in SQL.

## Our Simple Database
First things first, let's take a look at what our database looks like, and get a copy set up to play with. It's only four tables:
- employee;
- customer;
- department; and
- sale.

These four tables are related to one another (hence the term 'relational database'). Below is the Entity Relationship Diagram (ERD) for the database:

![](https://github.com/nydasco/intro_to_sql/blob/main/images/erd.png?raw=true)

Each box represents a table, and within it there are a list of the fields in that table, and the data types of those fields. If you've come from the world of spreadsheets, think of each of these as a tab within the spreadsheet, where the tabs are related to one another. An employee will have a `department_id` that identifies the department they are in. That `department_id` will correspond to the `id` in the `department` table, and that table then also contains the name of the department. That saves us needing to store the full department name against every employee, instead just storing a number. This allows us to save storage space in the database.

## Setting Up Your Database
I'm going to use a website called [SQLiteOnline](https://sqliteonline.com/). It's free, and it allows you to set up a basic database and have a play with it. You don't need to set up an account, but make sure you've selected PostgreSQL from the left hand side:

![](https://github.com/nydasco/intro_to_sql/blob/main/images/screenshot_1.png?raw=true)

You'll find copies of the four files that create and populate the four tables in this Github repository. You need to copy/paste the contents of each file in the create_table/ folder into the website, and hit the 'run' button:

![](https://github.com/nydasco/intro_to_sql/blob/main/images/create_table.png?raw=true)

You'll end up with the four tables listed, as shown in my first screenshot.

## Selecting Data
What good is storing data in a database if you can't access it? So lets start out with a basic SQL query that returns all records in a table:
```sql
SELECT
    *
FROM
    employee
```
The * is a wildcard. It means 'all columns'. This will return all four columns in the employee table, with all of the details in the records in that table. Say you had 1,000 employees. This query would return a table that was 4 columns wide by 1,000 rows long. Generally using this wildcard is frowned upon. But I know plenty of people that use it daily.

![](https://github.com/nydasco/intro_to_sql/blob/main/images/select_star.png?raw=true)

Let's trim this. We can trim both the width and the length. To trim the width, we need to replace our wildcard with the specific columns we're interesting in returning:
```sql
SELECT
    first_name,
    last_name
FROM
    employee
```
We've only asked for two columns, so the other two - `id` and `department_id` won't be included in the returned results.

![](https://github.com/nydasco/intro_to_sql/blob/main/images/select.png?raw=true)

But what if we only want to include those employees who had a `department_id` of '1'? We need to trim the length. That's where the WHERE clause comes in.
```sql
SELECT
    first_name,
    last_name
FROM
    employee
WHERE
    department_id = 1
```
Now we've limited both the width and the length of the returned dataset. Nice!

![](https://github.com/nydasco/intro_to_sql/blob/main/images/select_where.png?raw=true)

## Grouping and Aggregating
Let's step it up. We want to take a look at our sales data. There might be hundreds or thousands of sales on any given day. We want to see the total value of sales on each day. This is where we introduce a new clause. The `GROUP BY` clause. Things become a bit more advanced now, as we need to specify both what we want to group by (date), but also how we want to handle the thing that we're grouping (sale). In our case, we want to sum all of the sales on each date. I've also included an `ORDER BY` clause so that the data returns in date order:
```sql
SELECT
    date,
    SUM(sale) AS daily_sales
FROM
    sale
GROUP BY
    date
ORDER BY
    date
```

![](https://github.com/nydasco/intro_to_sql/blob/main/images/group_by.png?raw=true)

Rather than showing the hundreds or thousands of sales records for each day, it will now return a single row for each date with the sum of all sale amounts for that date next to it. We also introduced something else in the above query: the alias. We gave our sum a name. We called it `daily_sales`. When the dataset is returned, it will use our alias as the field name. So we'll have two fields - `date` and `daily_sales`.
It's great that we've got this information now, but there may still be a lot of data returned. We only want to see the dates where the total sales were about $10,000. Initially you might think 'we can use the `WHERE` clause', but unfortunately not. The `WHERE` clause will only work on the base data in the table. To filter based on the result of grouping, we need to use the HAVING clause. Let's take a look:
```sql
SELECT
    date,
    SUM(sale) AS daily_sales
FROM
    sale
GROUP BY
    date
HAVING
    SUM(sale) >= 10000
ORDER BY
    date
```

![](https://github.com/nydasco/intro_to_sql/blob/main/images/having.png?raw=true)

This does what we want. You'll see how we can get around using the HAVING clause a little later when looking at CTEs, but this is good knowledge to have.

## Joining Tables
So far we've only been working with single tables. Let's look at joining some tables together and looking at the dataset that can be returned from both of them. For this example, we can go back to the `employee` table. Remember that the `employee` table had the employee details as well as their department. But to save space in the database, it's the id of the department that's listed against the employee rather than the name of the department. That's held in the `department` table. If we want to see each employee and the name of their department, we'll need to join the two tables together. Let's do that now:
```sql
SELECT
    employee.first_name,
    employee.last_name,
    department.department
FROM
    employee
    INNER JOIN department
      ON employee.department_id = department.id
```
The first thing you'll notice is that now we're using more than one table, we start to fully qualify the names of the fields. Rather than just using the field name, we use the table.field. While in some circumstances this isn't needed, it is a good habit to get into. It makes it easy to see where your fields came from when you need to go back and debug your code.

Secondly, we've got more information going on in our `FROM` statement. We've now got the table that we start with (the left table), but we've also joined it to a second table (the right table), and then defined what fields in both tables are related to one another. The `department_id` in the `employee` table should match to the `id` in the `department` table.

![](https://github.com/nydasco/intro_to_sql/blob/main/images/join.png?raw=true)

### Join Types
In the above example, we've used an INNER JOIN. There are a number of different types of join, and they all work a little differently to each other. I've given a quick overview of each below:
**INNER JOIN**
- **Purpose**: Returns rows when there is at least one match in both tables.
- **Result**: Only returns rows where the join condition is true.
- **Use Case**: Ideal for retrieving data that appears in both tables, focusing only on matching pairs.

**LEFT JOIN**
- **Purpose**: Retrieves all rows from the left table and the matched rows from the right table.
- **Result**: If there is no match, the result is NULL on the side of the right table.
- **Use Case**: Useful when you want to include all records from the left table regardless of whether there is a corresponding match in the right table.

**RIGHT JOIN**
- **Purpose**: Retrieves all rows from the right table and the matched rows from the left table.
- **Result**: If there is no match, the result is NULL on the side of the left table.
- **Use Case**: Useful when you want to include all records from the right table regardless of whether there is a corresponding match in the left table. In reality, you don't see this used very often.

**FULL OUTER JOIN**
- **Purpose**: Combines the results of both LEFT JOIN and RIGHT JOIN. It returns rows from either table when the conditions are met.
- **Result**: Returns all rows from both the left and the right tables. Where there is no match, the result is NULL on the side of the table without a match.
- **Use Case**: Useful for analysing complete data from both tables, especially when you need to see which data is exclusive to one table and which is shared between both. It provides a comprehensive view of all the data in the joined tables.

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

---

## Conclusion
This introduction to SQL is designed to provide newcomers with a solid foundation in database querying and manipulation, reflecting the evolution of database technologies from their simpler origins to the complex systems we see today. There are lots more things to learn related to SQL, but this should be enough to get you started on your journey. 

