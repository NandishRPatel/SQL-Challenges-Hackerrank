## 1. Asian Population

/*
URL - https://www.hackerrank.com/challenges/asian-population/problem

Given the CITY and COUNTRY tables, query the sum of the 
populations of all cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key 
columns.
*/


SELECT SUM(ci.POPULATION) total_pop
FROM COUNTRY co
JOIN CITY ci
ON ci.COUNTRYCODE = co.CODE
WHERE co.CONTINENT = 'Asia';


## 2. African Cities

/*
URL - https://www.hackerrank.com/challenges/african-cities/problem

Given the CITY and COUNTRY tables, query the names of all 
cities where the CONTINENT is 'Africa'.

Note: CITY.CountryCode and COUNTRY.Code are matching key 
columns.
*/


SELECT ci.NAME
FROM COUNTRY co
JOIN CITY ci
ON ci.COUNTRYCODE = co.CODE
WHERE co.CONTINENT = 'Africa';


## 3. Average Population of Each Continent

/*
URL - https://www.hackerrank.com/challenges/average-population-of-each-continent/problem

Given the CITY and COUNTRY tables, query the names of all
the continents (COUNTRY.Continent) and their respective 
average city populations (CITY.Population) rounded down 
to the nearest integer.

Note: CITY.CountryCode and COUNTRY.Code are matching key 
columns.
*/


SELECT co.CONTINENT, floor(AVG(ci.POPULATION))
FROM COUNTRY co
JOIN CITY ci
ON ci.COUNTRYCODE = co.CODE
GROUP BY co.CONTINENT;


## 4. The Report

/*
URL - https://www.hackerrank.com/challenges/the-report/problem

You are given two tables: Students and Grades. Students 
contains three columns ID, Name and Marks.

Grade has : Grade, Min_Mark, Max_Mark

Ketty gives Eve a task to generate a report containing 
three columns: Name, Grade and Mark. Ketty doesn't want
the NAMES of those students who received a grade lower 
than 8. The report must be in descending order by grade 
-- i.e. higher grades are entered first. If there is 
more than one student with the same grade (8-10) assigned 
to them, order those particular students by their name 
alphabetically. Finally, if the grade is lower than 8, 
use "NULL" as their name and list them by their grades 
in descending order. If there is more than one student 
with the same grade (1-7) assigned to them, order those 
particular students by their marks in ascending order.
*/


SELECT IF(GRADE < 8, NULL, s.Name), g.Grade, s.Marks
FROM Students s
JOIN Grades g
WHERE s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY g.Grade DESC, s.Name;