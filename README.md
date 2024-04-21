# Introduction to SQL: A Beginner's Guide
My introduction to the world of databases began at university with Microsoft SQL Server 2000. Since those early days, the landscape of database technology has evolved dramatically. Beyond the traditional tabular databases, today's options range from Column Store databases like ClickHouse and Snowflake to Graph Databases like Neo4J and ArangoDB, and even Vector Store databases such as ChromaDB and Pinecone. Despite this diversity, the foundational skills in SQL remain crucial.

This repo aims to provide a straightforward introduction to SQL. Designed for simplicity, it's perfect for those just starting out. SQL is indispensable in roles such as Data Analyst and Data Engineer, offering a way to query data, configure database structures, and more. We will explore basic SQL functionalities including selecting fields, filtering records, aggregating data, understanding different types of joins, and implementing effective coding approaches like Common Table Expressions (CTEs) and subqueries.

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

From here, follow the links below:
- [Basics] (https://github.com/nydasco/intro_to_sql/basic.md)
- Intermediate (WIP)
- Advanced (Not Yet Started)
