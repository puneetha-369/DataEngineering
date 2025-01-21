# Module 1 Homework : Docker and SQL
# Question 1. Understanding docker first run
    docker build -t hw1 .
    docker run -it hw1
    pip --version

# Question 2. Understanding Docker networking and docker-compose

# Question 3. Trip Segmentation Count
# Up to 1 mile
        SELECT COUNT(*) 
        FROM green_taxitrip
        WHERE trip_distance <=1
            AND CAST(lpep_pickup_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'
            AND CAST(lpep_dropoff_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'

# In between 1 (exclusive) and 3 miles (inclusive)
        SELECT COUNT(*) 
        FROM green_taxitrip
        WHERE trip_distance > 1 AND trip_distance <=3
            AND CAST(lpep_pickup_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'
            AND CAST(lpep_dropoff_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'

# In between 3 (exclusive) and 7 miles (inclusive),
        SELECT COUNT(*) 
        FROM green_taxitrip
        WHERE trip_distance > 3 AND trip_distance <=7
            AND CAST(lpep_pickup_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'
            AND CAST(lpep_dropoff_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'

# In between 7 (exclusive) and 10 miles (inclusive),
        SELECT COUNT(*) 
        FROM green_taxitrip
        WHERE trip_distance > 7 AND trip_distance <=10
            AND CAST(lpep_pickup_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'
            AND CAST(lpep_dropoff_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'

# Over 10 miles
        SELECT COUNT(*) 
        FROM green_taxitrip
        WHERE trip_distance > 10
            AND CAST(lpep_pickup_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'
            AND CAST(lpep_dropoff_datetime as DATE) BETWEEN '2019-10-01' AND '2019-10-31'

# Question 4. Longest trip for each day
    SELECT CAST(lpep_pickup_datetime as DATE), MAX(trip_distance) 
    FROM green_taxitrip
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 5

# Question 5. Three biggest pickup zones
    SELECT z."Zone", SUM(total_amount) as totalamt
    FROM green_taxitrip t, zones z
    WHERE CAST(t.lpep_pickup_datetime AS DATE) = '2019-10-18'
        AND t."PULocationID" = z."LocationID"
    GROUP BY 1 
    HAVING SUM(total_amount) > 13000


# Question 6. Largest tip
    WITH CTE AS (SELECT t."DOLocationID", MAX(tip_amount)
    FROM green_taxitrip t, zones z
    WHERE t."PULocationID" = z."LocationID"
        AND z."Zone" = 'East Harlem North' 
        AND CAST(t.lpep_pickup_datetime AS DATE) BETWEEN'2019-10-01' AND '2019-10-31'
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1)

    SELECT z."Zone", c."max"
    FROM zones z, CTE c
    WHERE c."DOLocationID" = z."LocationID"