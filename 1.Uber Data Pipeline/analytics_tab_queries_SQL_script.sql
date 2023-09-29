CREATE OR REPLACE TABLE `uber-data-eng-19sep2023.uber_de_dataset.analytics_table` AS (
  SELECT 
    f.trip_id,
    f.VendorID,
    dt.tpep_pickup_datetime,
    dt.tpep_dropoff_datetime,
    pc.passenger_count,
    t.trip_distance,
    r.rate_code_name,
    p.pickup_latitude,
    p.pickup_longitude,
    d.dropoff_latitude,
    d.dropoff_longitude,
    pay.payment_type_name,
    f.fare_amount,
    f.extra,
    f.tip_amount,
    f.tolls_amount,
    f.total_amount
  FROM `uber-data-eng-19sep2023.uber_de_dataset.fact_table` f
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.datetime_dim` dt  
    ON f.datetime_id = dt.datetime_id
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.passenger_count_dim` pc  
    ON pc.passenger_count_id = f.passenger_count_id  
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.trip_distance_dim` t  
    ON t.trip_distance_id = f.trip_distance_id  
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.rate_code_dim` r 
    ON r.rate_code_id = f.rate_code_id  
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.pickup_location_dim` p 
    ON p.pickup_location_id = f.pickup_location_id
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.dropoff_location_dim` d 
    ON d.dropoff_location_id = f.dropoff_location_id
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.payment_type_dim` pay 
    ON pay.payment_type_id = f.payment_type_id
    )
  ;
  
  
  
  /*dashboard queries*/
  
  
  /*Which is the total amount of trips by passenger count?*/

SELECT 
      pc.passenger_count,
      COUNT(f.trip_id)  
                     AS trip_count
FROM `uber-data-eng-19sep2023.uber_de_dataset.fact_table` f
LEFT JOIN `uber-data-eng-19sep2023.uber_de_dataset.passenger_count_dim`  pc 
      ON f.passenger_count_id = pc.passenger_count_id
WHERE pc.passenger_count != 0
GROUP BY pc.passenger_count
ORDER BY trip_count DESC;




/* Which is the average tip amount by hour of the day*/

SELECT 
      dt.dropoff_hour,
      ROUND (AVG(f.tip_amount),
             2)
FROM `uber-data-eng-19sep2023.uber_de_dataset.fact_table` f
LEFT JOIN `uber-data-eng-19sep2023.uber_de_dataset.datetime_dim` dt
      ON f.datetime_id = dt.datetime_id
GROUP BY dt.dropoff_hour
ORDER BY dt.dropoff_hour;


SELECT 
      dt.dropoff_hour,
      ROUND (AVG(f.tip_amount),
             2)
FROM `uber-data-eng-19sep2023.uber_de_dataset.analytics_table` f
LEFT JOIN `uber-data-eng-19sep2023.uber_de_dataset.datetime_dim` dt
      ON f.datetime_id = dt.datetime_id
GROUP BY dt.dropoff_hour
ORDER BY dt.dropoff_hour;


/* Which are the top 5 locations */

SELECT 
       pickup_latitude, 
       pickup_longitude,
       COUNT(*) 
               AS pickup_loc_count
FROM `uber-data-eng-19sep2023.uber_de_dataset.analytics_table`
WHERE pickup_latitude != 0
      AND pickup_latitude != 0
GROUP BY pickup_latitude, 
         pickup_longitude
ORDER BY pickup_loc_count DESC
LIMIT 5;
  
  