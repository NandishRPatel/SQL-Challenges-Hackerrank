### LIMIT

/*
1. Try using LIMIT yourself below by writing a query that displays all the data 
in the occurred_at, account_id, and channel columns of the web_events 
table, and limits the output to only the first 15 rows.
*/

SELECT occurred_at, account_id, channel 
FROM web_events
LIMIT(15);


### ORDER BY

/*
1. Write a query to return the 10 earliest orders in the orders table. Include 
the id, occurred_at, and total_amt_usd.
*/

SELECT id, occurred_at, total_amt_usd 
FROM orders
ORDER BY occurred_at
LIMIT(10);


SELECT id, occurred_at, total_amt_usd 
FROM orders
ORDER BY 2
LIMIT(10);


/*
2. Write a query to return the top 5 orders in terms of largest total_amt_usd. 
Include the id, account_id, and total_amt_usd.
*/


SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT(5);


SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY 3 DESC
LIMIT(5);


/*
3. Write a query to return the lowest 20 orders in terms of smallest 
total_amt_usd. Include the id, account_id, and total_amt_usd.
*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT(20);


SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY 3
LIMIT(20);


### ORDER BY RETURNS

/*
1. Write a query that displays the order ID, account ID, and total dollar amount 
for all the orders, sorted first by the account ID (in ascending order), and 
then by the total dollar amount (in descending order).
*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;


SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY 2, 3 DESC;


/*
2. Now write a query that again displays order ID, account ID, and total dollar 
amount for each order, but this time sorted first by total dollar amount (in 
descending order), and then by account ID (in ascending order).
*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;


SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY 3 DESC, 2;


/*
3. Compare the results of these two queries above. How are the results different 
when you switch the column you sort on first?
*/

/*
In query #1, all of the orders for each account ID are grouped together, and 
then within each of those groupings, the orders appear from the greatest order 
mount to the least. In query #2, since you sorted by the total dollar amount 
first, the orders appear from greatest to least regardless of which account ID 
hey were from. Then they are sorted by account ID next. (The secondary sorting
by account ID is difficult to see here, since only if there were two orders 
with equal total dollar amounts would there need to be any sorting by account 
ID.)
*/


### WHERE


/*
1. Pulls the first 5 rows and all columns from the orders table that have a 
dollar amount of gloss_amt_usd greater than or equal to 1000.
*/

SELECT * 
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT(5);



/*
2. Pulls the first 10 rows and all columns from the orders table that have a 
total_amt_usd less than 500.
*/


SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT(10);


### Practice Question Using WHERE with Non-Numeric Data


/*
1. Filter the accounts table to include the company name, website, and the 
primary point of contact (primary_poc) just for the Exxon Mobil company in 
the accounts table.
*/

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';


SELECT name, website, primary_poc
FROM accounts
WHERE name IN('Exxon Mobil');



### Questions using Arithmetic Operations

/*
1. Create a column that divides the standard_amt_usd by the standard_qty to 
find the unit price for standard paper for each order. Limit the results to 
the first 10 orders, and include the id and account_id fields.
*/

SELECT id, account_id, standard_amt_usd/standard_qty 
AS unit_price
FROM orders
LIMIT(10);


SELECT id, account_id, 
round(standard_amt_usd/standard_qty, 2) AS unit_price
FROM orders
LIMIT(10);


/*
2. Write a query that finds the percentage of revenue that comes from poster 
paper for each order. You will need to use only the columns that end with 
_usd. (Try to do this without using the total column.) Display the id and 
account_id fields also. NOTE - you will receive an error with the correct 
solution to this question. This occurs because at least one of the values in 
the data creates a division by zero in your formula. You will learn later in 
the course how to fully handle this issue. For now, you can just limit your 
calculations to the first 10 orders, as we did in question #1, and you'll avoid
 that set of data that causes the problem.
*/

SELECT id, account_id, (poster_amt_usd * 100)/(poster_amt_usd + standard_amt_usd + 
	gloss_amt_usd) AS percentage_revenue_poster
FROM orders;


SELECT id, account_id, round((poster_amt_usd * 100)/(poster_amt_usd + standard_amt_usd + 
	gloss_amt_usd + 0.0000001), 2) AS percentage_revenue_poster
FROM orders;


### Questions using the LIKE operator

/*
1. All the companies whose names start with 'C'.
*/

SELECT *
FROM accounts
WHERE name LIKE 'C%';

/*
2. All companies whose names contain the string 'one' somewhere in the name.
*/

SELECT *
FROM accounts
WHERE name LIKE '%one%';

/*
3. All companies whose names end with 's'.
*/

SELECT *
FROM accounts
WHERE name LIKE '%s';


### Questions using IN operator

/*
1. Use the accounts table to find the account name, primary_poc, and 
sales_rep_id for Walmart, Target, and Nordstrom.
*/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/*
2. Use the web_events table to find all information regarding individuals who 
were contacted via the channel of organic or adwords.
*/

SELECT * 
FROM web_events
WHERE channel IN ('organic', 'adwords');


### Questions using the NOT operator

/*
1. Use the accounts table to find the account name, primary poc, and sales 
rep id for all stores except Walmart, Target, and Nordstrom.
*/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');


/*
2. Use the web_events table to find all information regarding individuals who 
were contacted via any method except using organic or adwords methods.
*/

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

/*
3. All the companies whose names do not start with 'C'.
*/

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';

/*
4. All companies whose names do not contain the string 'one' somewhere in the 
name.
*/

SELECT *
FROM accounts
WHERE name NOT LIKE '%one%';

/*
5. All companies whose names do not end with 's'.
*/

SELECT *
FROM accounts
WHERE name NOT LIKE '%s';


### Questions using AND and BETWEEN operators

/*
1. Write a query that returns all the orders where the standard_qty is over 
1000, the poster_qty is 0, and the gloss_qty is 0.
*/

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

/*
2. Using the accounts table, find all the companies whose names do not start 
with 'C' and end with 's'.
*/

SELECT *
FROM accounts
WHERE (name NOT LIKE 'C%') AND (name NOT LIKE '%s');

/*
3. When you use the BETWEEN operator in SQL, do the results include the values 
of your endpoints, or not? Figure out the answer to this important question by 
writing a query that displays the order date and gloss_qty data for all orders 
where gloss_qty is between 24 and 29. Then look at your output to see if the 
BETWEEN operator included the begin and end values or not.
*/


SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29
ORDER BY gloss_qty DESC;


SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29
ORDER BY 2 DESC;


/*
4. Use the web_events table to find all information regarding individuals who 
were contacted via the organic or adwords channels, and started their account 
at any point in 2016, sorted from newest to oldest.
*/


SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND 
occurred_at BETWEEN '01-01-2016' AND '01-01-2017';


### Questions using the OR operator

/*
1. Find list of orders ids where either gloss_qty or poster_qty is greater than
4000. Only include the id field in the resulting table.
*/

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

/*
2. Write a query that returns a list of orders where the standard_qty is zero
and either the gloss_qty or poster_qty is over 1000.
*/

SELECT *
FROM orders
WHERE (gloss_qty > 1000 OR poster_qty > 1000)
AND standard_qty = 0;


/*
3. Find all the company names that start with a 'C' or 'W', and the primary
contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
*/

SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND 
	(primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND
	(primary_poc NOT LIKE '%eana%');



### JOIN

/*
1. Try pulling all the data from the accounts table, and all the data from 
the orders table.
*/

SELECT *
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id;


/*
2. Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, 
and the website and the primary_poc from the accounts table.
*/

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, 
accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;



### JOIN and Alias


/*
1. Provide a table for all web_events associated with account name of Walmart.
There should be three columns. Be sure to include the primary_poc, time of 
the event, and the channel for each event. Additionally, you might choose to 
add a fourth column to assure only Walmart events were chosen.
*/

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.name = 'Walmart';


SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE a.name = 'Walmart';


/*
2. Provide a table that provides the region for each sales_rep along with their
associated accounts. Your final table should include three columns: the region
name, the sales rep name, and the account name. Sort the accounts 
alphabetically (A-Z) according to account name.
*/

SELECT r.name region_name, s.name sales_rep_name, 
a.name account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON s.id = a.sales_rep_id
ORDER BY account_name;



SELECT r.name AS region_name, s.name AS sales_rep_name, 
a.name AS account_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a 
ON s.id = a.sales_rep_id
ORDER BY account_name;


SELECT r.name region_name, s.name sales_rep_name, 
a.name account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON s.id = a.sales_rep_id
ORDER BY 3;


/*
3. Provide the name for each region for every order, as well as the account 
name and the unit price they paid (total_amt_usd/total) for the order. Your 
final table should have 3 columns: region name, account name, and unit price. 
A few accounts have 0 for total, so I divided by (total + 0.01) to assure not 
dividing by zero.
*/


SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON a.id = o.account_id;


### JOIN and Filtering


/* You can filter using on clause with AND(This happens before joining the 
tables) */


/*
1. Provide a table that provides the region for each sales_rep along with 
their associated accounts. This time only for the Midwest region. Your final 
table should include three columns: the region name, the sales rep name, and 
the account name. Sort the accounts alphabetically (A-Z) according to account
name.
*/

SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id  AND r.name = 'Midwest'
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name; /*ORDER BY account_name*/


SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id  AND r.name = 'Midwest'
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY 2; /*ORDER BY account_name*/


SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id 
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name; /*ORDER BY account_name*/


/*
2. Provide a table that provides the region for each sales_rep along with 
their associated accounts. This time only for accounts where the sales rep 
has a first name starting with S and in the Midwest region. Your final table 
should include three columns: the region name, the sales rep name, and the 
account name. Sort the accounts alphabetically (A-Z) according to account name.
*/

SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id  AND (s.name LIKE 'S%' AND r.name = 'Midwest')
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name; /*ORDER BY account_name*/


SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id  AND (s.name LIKE 'S%' AND r.name = 'Midwest')
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY 2; /*ORDER BY account_name*/


SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id 
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name; /*ORDER BY account_name*/


/*
3. Provide a table that provides the region for each sales_rep along with 
their associated accounts. This time only for accounts where the sales rep 
has a last name starting with K and in the Midwest region. Your final table 
should include three columns: the region name, the sales rep name, and the 
account name. Sort the accounts alphabetically (A-Z) according to account name.
*/

SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id  AND 
(s.name LIKE '% K%' AND r.name = 'Midwest')
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name; /*ORDER BY account_name*/


SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id  AND 
(s.name LIKE '% K%' AND r.name = 'Midwest')
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY 2; /*ORDER BY account_name*/


SELECT r.name region_name, a.name account_name, 
s.name sales_rep_name
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id 
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name; /*ORDER BY account_name*/


/*
4. Provide the name for each region for every order, as well as the account 
name and the unit price they paid (total_amt_usd/total) for the order. However,
you should only provide the results if the standard order quantity exceeds 100.
Your final table should have 3 columns: region name, account name, and unit 
price. In order to avoid a division by zero error, adding .01 to the 
denominator here is helpful total_amt_usd/(total+0.01).
*/

SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id AND o.standard_qty > 100
ORDER BY unit_price;


SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id AND o.standard_qty > 100
ORDER BY 3;


SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100
ORDER BY unit_price;

/*
5. Provide the name for each region for every order, as well as the account 
name and the unit price they paid (total_amt_usd/total) for the order. However,
you should only provide the results if the standard order quantity exceeds 100
and the poster order quantity exceeds 50. Your final table should have 3 
columns: region name, account name, and unit price. Sort for the smallest 
unit price first. In order to avoid a division by zero error, adding .01 to 
the denominator here is helpful (total_amt_usd/(total+0.01).
*/

SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id AND o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;


SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id AND o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY 3;


SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;



/*
6. Provide the name for each region for every order, as well as the account 
name and the unit price they paid (total_amt_usd/total) for the order. However,
you should only provide the results if the standard order quantity exceeds 100
and the poster order quantity exceeds 50. Your final table should have 3 
columns: region name, account name, and unit price. Sort for the largest unit
price first. In order to avoid a division by zero error, adding .01 to the 
denominator here is helpful (total_amt_usd/(total+0.01).
*/

SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id AND o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;


SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id AND o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY 3 DESC;


SELECT r.name region_name, a.name account_name, 
o.total_amt_usd/(o.total + 0.001) unit_price
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;


/*
7. What are the different channels used by account id 1001? Your final table 
should have only 2 columns: account name and the different channels. You can 
try SELECT DISTINCT to narrow down the results to only the unique values.
*/

SELECT w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND a.id = 1001;

/* BETTER */

SELECT DISTINCT w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND a.id = 1001;


SELECT DISTINCT w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.id = 1001;


/*
8. Find all the orders that occurred in 2015. Your final table should have 4 
columns: occurred_at, account name, order total, and order total_amt_usd.
*/


SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id AND o.occurred_at BETWEEN 
'01-01-2015' AND '01-01-2016';

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
WHERE o.occurred_at BETWEEN '01-01-2015' AND 
'01-01-2016';



### Aggregation Questions


/*
1. Find the total amount of poster_qty paper ordered in 
the orders table.
*/

SELECT SUM(poster_qty) total_poster_qty
FROM orders;

/*
2. Find the total amount of standard_qty paper ordered 
in the orders table.
*/

SELECT SUM(standard_qty) total_standard_qty
FROM orders;

/*
3. Find the total dollar amount of sales using the 
total_amt_usd in the orders table.
*/

SELECT SUM(total_amt_usd) total_amount_usd
FROM orders;

/*
4. Find the total amount spent on standard_amt_usd and 
gloss_amt_usd paper for each order in the orders table. 
This should give a dollar amount for each order in the 
table.
*/

SELECT SUM(standard_amt_usd) std_amount_usd, 
SUM(gloss_amt_usd) gloss_amount_usd
FROM orders;

/*
5. Find the standard_amt_usd per unit of standard_qty 
paper. Your solution should use both an aggregation and 
a mathematical operator.
*/

SELECT SUM(standard_amt_usd)/SUM(standard_qty) 
AS unit_price_standard
FROM orders;


### Questions: MIN, MAX, & AVERAGE

/*
1. When was the earliest order ever placed? You only 
need to return the date.
*/

SELECT MIN(occurred_at) 
FROM orders;

/*
2. Try performing the same query as in question 1 
without using an aggregation function.
*/

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;


SELECT occurred_at
FROM orders
ORDER BY 1
LIMIT 1;


/*
3. When did the most recent (latest) web_event occur?
*/

SELECT MAX(occurred_at)
FROM web_events;

/*
4. Try to perform the result of the previous query 
without using an aggregation function.
*/

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;


SELECT occurred_at
FROM web_events
ORDER BY 1 DESC
LIMIT 1;


/*
5. Find the mean (AVERAGE) amount spent per order on 
each paper type, as well as the mean amount of each 
paper type purchased per order. Your final answer 
should have 6 values - one for each paper type for the 
average number of sales, as well as the average amount.
*/

SELECT AVG(standard_qty) mean_standard, 
AVG(gloss_qty) mean_gloss, 
AVG(poster_qty) mean_poster, 
AVG(standard_amt_usd) mean_standard_usd, 
AVG(gloss_amt_usd) mean_gloss_usd, 
AVG(poster_amt_usd) mean_poster_usd
FROM orders;

/*
6. Via the video, you might be interested in how to 
calculate the MEDIAN. Though this is more advanced than 
what we have covered so far try finding - what is the 
MEDIAN total_usd spent on all orders?
*/

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;


### Questions: GROUP BY



/*
1. Which account (by name) placed the earliest order? 
Your solution should have the account name and the date 
of the order.
*/


SELECT a.name, o.occurred_at
FROM orders o
JOIN accounts a
ON o.account_id = a.id
ORDER BY o.occurred_at
LIMIT 1;


SELECT a.name, o.occurred_at
FROM orders o
JOIN accounts a
ON o.account_id = a.id
ORDER BY 2
LIMIT 1;


/*
2. Find the total sales in usd for each account. You 
should include two columns - the total sales for each 
company's orders in usd and the company name.
*/


SELECT a.name, SUM(o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_sales DESC;


SELECT a.name, SUM(o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;


/*
3. Via what channel did the most recent (latest) 
web_event occur, which account was associated with this 
web_event? Your query should return only three values - 
the date, channel, and account name.
*/


SELECT w.channel, a.name, w.occurred_at
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;


SELECT w.channel, a.name, w.occurred_at
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY 3 DESC
LIMIT 1;


/*
4. Find the total number of times each type of channel 
from the web_events was used. Your final table should 
have two columns - the channel and the number of times 
the channel was used.
*/


SELECT channel, COUNT(*) times_used
FROM web_events
GROUP BY channel
ORDER BY times_used DESC;


SELECT channel, COUNT(*) times_used
FROM web_events
GROUP BY 1
ORDER BY 2 DESC;


/*
5. Who was the primary contact associated with the 
earliest web_event?
*/


SELECT w.occurred_at, a.primary_poc
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1; 


SELECT w.occurred_at, a.primary_poc
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY 1
LIMIT 1; 


/*
6. What was the smallest order placed by each account 
in terms of total usd. Provide only two columns - the 
account name and the total usd. Order from smallest 
dollar amounts to largest.
*/


SELECT a.name, MIN(o.total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_usd;


SELECT a.name, MIN(o.total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2;


/*
7. Find the number of sales reps in each region. Your 
final table should have two columns - the region and 
the number of sales_reps. Order from fewest reps to 
most reps.
*/


SELECT r.name, COUNT(*) total_sales_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY total_sales_reps;


SELECT r.name, COUNT(*) total_sales_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY 1
ORDER BY 2;


### Questions: GROUP BY Part II


/*
1. For each account, determine the average amount of 
each type of paper they purchased across their orders. 
Your result should have four columns - one for the 
account name and one for the average quantity purchased 
for each of the paper types for each account.
*/


SELECT a.name, AVG(standard_qty) standard_avg, 
AVG(gloss_qty) gloss_avg, AVG(poster_qty) poster_avg
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name;


SELECT a.name, AVG(standard_qty) standard_avg, 
AVG(gloss_qty) gloss_avg, AVG(poster_qty) poster_avg
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 1;


/*
2. For each account, determine the average amount spent 
per order on each paper type. Your result should have 
four columns - one for the account name and one for the 
average amount spent on each paper type.
*/


SELECT a.name, AVG(standard_amt_usd) standard_amt, 
AVG(gloss_amt_usd) gloss_amt, 
AVG(poster_amt_usd) poster_amt
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name;


SELECT a.name, AVG(standard_amt_usd) standard_amt, 
AVG(gloss_amt_usd) gloss_amt, 
AVG(poster_amt_usd) poster_amt
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 1;


/*
3. Determine the number of times a particular channel 
was used in the web_events table for each sales rep. 
Your final table should have three columns - the name 
of the sales rep, the channel, and the number of 
occurrences. Order your table with the highest number 
of occurrences first.
*/


SELECT s.name, w.channel, COUNT(*) num_occ
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY num_occ DESC;


SELECT s.name, w.channel, COUNT(*) num_occ
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1, 2
ORDER BY 3 DESC;


/*
4. Determine the number of times a particular channel 
was used in the web_events table for each region. Your 
final table should have three columns - the region name, 
the channel, and the number of occurrences. Order your 
table with the highest number of occurrences first.
*/


SELECT r.name, w.channel, COUNT(*) num_occ
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY r.name, w.channel
ORDER BY num_occ DESC;


SELECT r.name, w.channel, COUNT(*) num_occ
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY 1, 2
ORDER BY 3 DESC;


### Questions: DISTINCT


/*
1. Use DISTINCT to test if there are any accounts 
associated with more than one region.
*/


SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;


SELECT DISTINCT id, name
FROM accounts;


/*
2. Have any sales reps worked on more than one account?
*/


SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;


SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY 1, 2
ORDER BY 3;


SELECT DISTINCT id, name
FROM sales_reps;



### Questions: HAVING

# NOTE
/*
HAVING is the “clean” way to filter a query that has 
been aggregated, but this is also commonly done using 
a subquery. Essentially, any time you want to perform 
a WHERE on an element of your query that was created 
by an aggregate, you need to use HAVING instead.
*/


/*
1. How many of the sales reps have more than 5 accounts 
that they manage?
*/

/*
2. How many accounts have more than 20 orders?
*/


/*
3. Which account has the most orders?
*/


/*
4. Which accounts spent more than 30,000 usd total 
across all orders?
*/


/*
5. Which accounts spent less than 1,000 usd total 
across all orders?
*/


/*
6. Which account has spent the most with us?
*/


/*
7. Which account has spent the least with us?
*/


/*
8. Which accounts used facebook as a channel to contact 
customers more than 6 times?
*/


/*
9. Which account used facebook most as a channel?
*/


/*
10. Which channel was most frequently used by most 
accounts?
*/

