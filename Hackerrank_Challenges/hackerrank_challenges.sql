## 1. Asian Population

/*
Given the CITY and COUNTRY tables, query the sum of the populations of all 
cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/


SELECT SUM(ci.POPULATION) total_pop
FROM COUNTRY co
JOIN CITY ci
ON ci.COUNTRYCODE = co.CODE
WHERE co.CONTINENT = 'Asia';


## 2. African Cities

/*
Given the CITY and COUNTRY tables, query the names of all cities where the 
CONTINENT is 'Africa'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/


SELECT ci.NAME
FROM COUNTRY co
JOIN CITY ci
ON ci.COUNTRYCODE = co.CODE
WHERE co.CONTINENT = 'Africa';
