# Advanced-SQL-Querying-with-Sean-Lahman-Baseball-Database
# ⚾ Advanced SQL Analysis – Lahman Baseball Database

This project showcases advanced SQL querying and data analysis using the **Sean Lahman Baseball Database**. The goal was to uncover insights into player performance, team finances, and historical trends using a variety of modern SQL techniques.

## 🧠 Key Concepts Used
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Pivoting & Rolling Calculations
- NULL Handling
- Multi-table JOINs

## 🔍 Analysis Highlights
- Identified patterns in **player efficiency** and **salary allocations**.
- Used **rolling averages** and **rank functions** to highlight top performers by decade.
- Explored **financial disparities** between teams and suggested **roster strategy improvements**.

## 📂 Files Included
- `queries/`: All major SQL scripts used
- `outputs/`: (Optional) CSVs or visual results of queries
- `lahman-database-schema.png`: (Optional) DB schema for reference

## 📊 Database Used
- **Sean Lahman Baseball Database**: [lahman.me](https://www.seanlahman.com/baseball-archive/statistics/)

## 📈 Example Query (Window Function)

```sql
SELECT playerID, yearID, salary,
       RANK() OVER (PARTITION BY teamID ORDER BY salary DESC) AS team_salary_rank
FROM Salaries;
