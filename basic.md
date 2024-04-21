# Introduction to SQL: A Beginner's Guide
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
- **Use Case**: Ideal for retrieving data that appears in both tables, focusing only on matching pairs. For example, show all clients that have had a sale.

**LEFT JOIN**
- **Purpose**: Retrieves all rows from the left table and the matched rows from the right table.
- **Result**: If there is no match, the result is NULL on the side of the right table.
- **Use Case**: Useful when you want to include all records from the left table regardless of whether there is a corresponding match in the right table. For example, if the `client` table is on the left and the `sale` table is on the right, we could see all clients, even if they had never had a sale, and could see the sales of those that did have a sale too.

**RIGHT JOIN**
- **Purpose**: Retrieves all rows from the right table and the matched rows from the left table.
- **Result**: If there is no match, the result is NULL on the side of the left table.
- **Use Case**: Useful when you want to include all records from the right table regardless of whether there is a corresponding match in the left table. In reality, you don't see this used very often.

**FULL OUTER JOIN**
- **Purpose**: Combines the results of both LEFT JOIN and RIGHT JOIN. It returns rows from either table when the conditions are met.
- **Result**: Returns all rows from both the left and the right tables. Where there is no match, the result is NULL on the side of the table without a match.
- **Use Case**: Useful for analysing complete data from both tables, especially when you need to see which data is exclusive to one table and which is shared between both. It provides a comprehensive view of all the data in the joined tables. For example, you might find that some employees weren't assigned to a department, and perhaps not all departments had employees in them. Using a FULL OUTER JOIN would allow you to see all employees and all departments.

---
## Conclusion
This introduction to SQL is designed to provide newcomers with a solid foundation in database querying and manipulation. There are lots more things to learn related to SQL, but this should be enough to get you started on your journey.
