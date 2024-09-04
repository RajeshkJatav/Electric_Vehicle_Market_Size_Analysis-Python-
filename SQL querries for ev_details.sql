**Basic Questions**

1. **List all distinct vehicle makes.**
 
   SELECT DISTINCT make FROM ev_detail;
 

2. **Count the number of electric vehicles in the dataset.**
 
   SELECT COUNT(*) FROM ev_detail;
  
 
3. **Retrieve all vehicles manufactured in 2020.**
  
   SELECT * FROM ev_detail WHERE model_year = 2020;
  
 
4. **Find all vehicles with an electric range greater than 250 miles.**
 
   SELECT * FROM ev_detail WHERE electric_range > 250;
 
 
5. **Display the VIN and model of vehicles located in Seattle.**
  
   SELECT vin, model FROM ev_detail WHERE city = 'Seattle';
   
 
**Intermediate Questions**

6. **Calculate the average base MSRP of vehicles by make.**
  
   SELECT make, AVG(base_msrp) AS avg_msrp FROM ev_detail GROUP BY make;
  
 
7. **Find the top 5 cities with the most electric vehicles.**
  
   SELECT city, COUNT(*) AS vehicle_count FROM ev_detail GROUP BY city ORDER BY vehicle_count DESC LIMIT 5;
  
   
8. **List all vehicles eligible for clean alternative fuel incentives.**
	
    SELECT * FROM ev_detail WHERE cafv_eligibility LIKE '%Eligible%';
    
 
9. **Count the number of vehicles for each electric vehicle type.**
    
   SELECT electric_vehicle_type, COUNT(*) AS count FROM ev_detail GROUP BY electric_vehicle_type;
    
 
10. **Find all vehicles that belong to the 36th legislative district.**
 
    SELECT * FROM ev_detail WHERE legislative_district = 36;
    

**Advanced Questions**

11. **Identify the most common electric vehicle model.**
 
    SELECT model, COUNT(*) AS count FROM ev_detail GROUP BY model ORDER BY count DESC LIMIT 1;
 
12. **Calculate the total number of vehicles and the average electric range in each county.**
  
    SELECT country, COUNT(*) AS total_vehicles, AVG(electric_range) AS avg_range FROM ev_detail GROUP BY country;
 

13. **Find vehicles with a base MSRP of zero and their respective models.**
    
    SELECT make, model FROM ev_detail WHERE base_msrp = 0;
    
14. **Retrieve the vehicle(s) with the maximum electric range.**
 
    SELECT * FROM ev_detail WHERE electric_range = (SELECT MAX(electric_range) FROM ev_detail);
    
15. **Find the total number of vehicles per year grouped by make and model.**
   
    SELECT make, model, model_year, COUNT(*) AS total FROM ev_detail GROUP BY make, model, model_year;






**Intermediate Questions (continued)**

16. **List all vehicles in King Country with an electric range between 200 and 300 miles.**

 SELECT * FROM ev_detail WHERE country = 'King' AND electric_range BETWEEN 200 AND 300;


17. **Retrieve the VIN, model, and base MSRP for vehicles with a postal code starting with '98'.**

select vin, model, base_msrp  from ev_detail
where postal_code like '98%'


18. **Count the number of vehicles grouped by make and state.**

select make ,state , count(dol_vehicle_id)from ev_detail
group by 1, 2

19. **Find all vehicles whose CAFV eligibility status is unknown.**

select * from ev_detail
where CAFV_eligibility like '%unknown%'


20. **Calculate the total number of vehicles per electric utility provider.**

SELECT electric_utility, COUNT(*) AS total_vehicles FROM ev_detail
GROUP BY electric_utility 
order by total_vehicles desc

21. **Identify the most recent model year for each make and model.**

SELECT make, model, MAX(model_year) AS latest_year FROM ev_detail 
GROUP BY make, model

22. **List the top 3 counties with the highest average electric range.**

SELECT country, AVG(electric_range) AS avg_range FROM ev_detail 
GROUP BY country 
ORDER BY avg_range 
DESC LIMIT 3;

23. **Retrieve vehicles with a VIN starting with '5YJ' and display their make, model, and city.**

SELECT vin, make, model, city FROM ev_detail WHERE vin LIKE '5YJ%';

24. **Count the number of unique models per make.**

select make ,count(distinct(model)) as unique_model from ev_detail
group by make 


25. **Find vehicles with an MSRP greater than $50,000 and an electric range greater than 200 miles.**

select * from ev_detail
where base_msrp > '50000' and electric_range >'200'


26. **Determine the total number of vehicles registered in the top 5 most populous legislative districts.**

SELECT legislative_district, COUNT(*) AS total_vehicles FROM ev_detail
GROUP BY legislative_district 
ORDER BY total_vehicles 
DESC LIMIT 5;

27. **Find the median electric range for vehicles in each state.**

SELECT state, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY electric_range) AS median_range FROM ev_detail GROUP BY state;

28. **Identify the make and model with the highest total MSRP.**

SELECT make, model, SUM(base_msrp) AS total_msrp FROM ev_detail 
GROUP BY make, model ORDER BY total_msrp DESC LIMIT 1;

30. **Calculate the percentage of vehicles eligible for clean alternative fuel incentives by county.**

SELECT  country,
           100.0 * SUM(CASE WHEN cafv_eligibility LIKE '%Eligible%' THEN 1 ELSE 0 END) / COUNT(*) AS percentage_eligible 


31. **Identify the most expensive vehicle by MSRP in each city.**

SELECT city, make, model, MAX(base_msrp) AS max_msrp FROM ev_detail 
GROUP BY city, make, model 
ORDER BY max_msrp DESC;


32. **Find vehicles registered in the same city but with different legislative districts.**

SELECT vin, city, legislative_district FROM ev_detail WHERE city IN (
        SELECT city FROM ev_detail GROUP BY city HAVING COUNT(DISTINCT legislative_district) > 1
    );

33. **Calculate the total number of vehicles and the average MSRP for each vehicle type.**

select electric_vehicle_type, count(*) as total_vehicle, avg(base_msrp) as avg_msrp from ev_detail
group by 1

34. **Find all vehicles where the make and model appear in more than one country.**
	
SELECT make, model, COUNT(DISTINCT country) AS country_count 
    FROM ev_detail 
    GROUP BY make, model 
    HAVING country_count > 1;

35. **Identify the top 3 makes with the most vehicle registrations in the state of Washington (WA).**

SELECT make, COUNT(*) AS vehicle_count FROM ev_detail
WHERE state = 'WA' 
GROUP BY make 
ORDER BY vehicle_count DESC 
LIMIT 3;

##36. **Find vehicles with the same make and model but different electric ranges.**

SELECT make, model, electric_range FROM ev_detail 
WHERE (make, model) IN (
        SELECT make, model FROM ev_detail GROUP BY make, model HAVING COUNT(DISTINCT electric_range) > 1
    );

37. **Calculate the average electric range for each vehicle type in each state.**

select state , electric_vehicle_type,avg(electric_range) as avg_electric_range from ev_detail
group by 1,2 

38. **Identify the top 5 most common vehicle models in cities with populations over 100,000.**

SELECT model, COUNT(*) AS total FROM ev_detail WHERE city IN (
        SELECT city FROM ev_detail GROUP BY city HAVING COUNT(*) > 100000
    ) GROUP BY model ORDER BY total DESC LIMIT 5;

39. **Find vehicles that have an electric range of zero and their corresponding electric utility.**
   
SELECT electric_utility, COUNT(*) AS total FROM ev_detail 
WHERE electric_range = 0 
GROUP BY electric_utility;


40. **Identify cities with the highest variance in electric vehicle range.**
   
    SELECT city, VARIANCE(electric_range) AS range_variance FROM ev_detail GROUP BY city ORDER BY range_variance DESC LIMIT 5;
  
41. **Determine the number of vehicles per census tract.**
    
    SELECT census_tract, COUNT(*) AS total_vehicles FROM ev_detail GROUP BY census_tract;
  
42. **Find vehicles whose postal codes are missing and list their corresponding cities and counties.**
 
    SELECT city, county FROM ev_detail WHERE postal_code IS NULL;
 
 
43. **Identify the makes with the highest number of ineligible vehicles for CAFV.**
   
    SELECT make, COUNT(*) AS ineligible_vehicles FROM ev_detail WHERE cafv_eligibility NOT LIKE '%Eligible%' GROUP BY make ORDER BY ineligible_vehicles DESC;
    
 vehicles ineligible for CAFV.

44. **Calculate the median MSRP for each combination of make and electric vehicle type.**
     
    SELECT make, electric_vehicle_type, 
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY base_msrp) AS median_msrp 
    FROM ev_detail GROUP BY make, electric_vehicle_type;
    
45. **Find vehicles with the same VIN registered in different cities.**
     
    SELECT vin, city FROM ev_detail WHERE vin IN (
        SELECT vin FROM ev_detail GROUP BY vin HAVING COUNT(DISTINCT city) > 1
    );
    
46. **Retrieve vehicles from the top 3 most populous counties and sort them by electric range.**
    
    SELECT * FROM ev_detail WHERE county IN (
        SELECT county FROM ev_detail GROUP BY county ORDER BY COUNT(*) DESC LIMIT 3
    ) ORDER BY electric_range DESC;
    
47. **Identify cities with no eligible vehicles for clean alternative fuel.**
     
    SELECT city FROM ev_detail GROUP BY city HAVING SUM(CASE WHEN cafv_eligibility LIKE '%Eligible%' THEN 1 ELSE 0 END) = 0;
    
48. **Find vehicles registered in more than one legislative district.**
     
    SELECT vin, COUNT(DISTINCT legislative_district) AS districts FROM ev_detail GROUP BY vin HAVING districts > 1;
     
49. **Calculate the sum of MSRPs for each legislative district.**
    
    SELECT legislative_district, SUM(base_msrp) AS total_msrp FROM ev_detail GROUP BY legislative_district;
  
50. **Identify the top 5 makes by the total number of vehicles across all states.**
   
    SELECT make, COUNT(*) AS total_vehicles FROM ev_detail GROUP BY make ORDER BY total_vehicles DESC LIMIT 5;
   




This completes the set of 50 SQL questions of varying difficulty based on the dataset.
These questions cover a wide range of topics including aggregation, filtering, grouping, and advanced analytic functions.










 
