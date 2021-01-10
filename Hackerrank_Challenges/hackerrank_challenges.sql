/*
1. Given the CITY and COUNTRY tables, query the sum of the populations of all 
cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/


SELECT SUM(ci.POPULATION) total_pop
FROM COUNTRY co
JOIN CITY ci
ON ci.COUNTRYCODE = co.CODE
WHERE co.CONTINENT = 'Asia';

