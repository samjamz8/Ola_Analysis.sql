
CREATE TABLE ola_bookings (
    booking_date DATE,
    booking_time TIME,
    booking_id VARCHAR(50),
    booking_status VARCHAR(50),
    customer_id VARCHAR(50),
    vehicle_type VARCHAR(50),
    pickup_location VARCHAR(100),
    drop_location VARCHAR(100),
    v_tat VARCHAR(50),
    c_tat VARCHAR(50),
    canceled_rides_by_customer VARCHAR(100),
    canceled_rides_by_driver VARCHAR(100),
    incomplete_rides VARCHAR(50),
    incomplete_rides_reason TEXT,
    booking_value NUMERIC(10,2),
    payment_method VARCHAR(50),
    ride_distance NUMERIC(10,2),
    driver_ratings NUMERIC(3,1),
    customer_rating NUMERIC(3,1),
    vehicle_images TEXT
);

SELECT *
FROM ola_bookings
LIMIT 5;

--1.Retrieve successful bookings:
Create view Successful_Bookings AS
select *
from ola_bookings
where booking_status = 'Success';

--2.Count of successful bookings
Create view Count_of_Successful_Bookings AS
select count(booking_status) AS Successful_bookings
from ola_bookings
where booking_status = 'Success';

--3.Avg ride distance for each vehicle
select vehicle_type, 
ROUND(avg(ride_distance),2)
from ola_bookings
group by vehicle_type;

SELECT
    vehicle_type,
    COUNT(*) AS total_bookings,
    COUNT(*) FILTER (WHERE ride_distance = 0) AS zero_distance_rides,
    ROUND(AVG(ride_distance), 2) AS avg_including_zero,
    ROUND(AVG(ride_distance) FILTER (WHERE ride_distance > 0), 2)
        AS avg_excluding_zero
FROM ola_bookings
GROUP BY vehicle_type
ORDER BY vehicle_type;

--3.Avg ride distance for each vehicle / alternate
Create view Avg_Ride_Dist AS
select vehicle_type,
ROUND(avg(ride_distance),2)
from ola_bookings
where booking_status = 'Success'
group by vehicle_type;

--4.Total number of canceled rides by customers
Create view No_Canceled_Rides_by_Cus AS
select count(*) AS canceled_by_cus
from ola_bookings
where booking_status = 'Canceled by Customer';

--5.Top 5 customers who booked highest number of rides
Create view Top_5_Customers AS
select customer_id, 
COUNT(*) AS total_rides
from ola_bookings
GROUP BY customer_id
ORDER BY total_rides DESC
LIMIT 5;

--6.Number of rides canceled by driver due to car related & personal issues
Create view No_Rides_Can_by_Driver AS
SELECT
    canceled_rides_by_driver,
    COUNT(*) AS total_cancellations
FROM ola_bookings
WHERE canceled_rides_by_driver IN (
    'Personal & Car related issue'
)
GROUP BY canceled_rides_by_driver;

--7.Min and max driver rating for prime sedan
Create view Min_Max_Driver_Ratings AS
SELECT 
    MIN(driver_ratings) AS min_rating,
    MAX(driver_ratings) AS max_rating
FROM ola_bookings
WHERE vehicle_type = 'Prime Sedan';

--8.All rides payments made using UPI
Create view Payments_UPI AS
select *
from ola_bookings
where payment_method = 'UPI';

--9.Number of rides payments made using UPI
Create view No_of_Payments_UPI AS
select COUNT(*)
from ola_bookings
where payment_method = 'UPI';

--10.Avg rating by customer per vehicle type
Create view Avg_Rating AS
select vehicle_type, ROUND(AVG(customer_rating),2) AS avg_cus_rt
from ola_bookings
GROUP BY vehicle_type;

--11.Calculate the total booking value of successfully completed rides
Create view Total_Suc_Bookings AS
select ROUND(SUM(booking_value),2) AS total_successful_value
from ola_bookings
where booking_status = 'Success';

--12.List all incomplete rides along with the reasons
Create view Incomplete_Rides AS
select booking_id,incomplete_rides_reason
from ola_bookings
where incomplete_rides ='Yes';

--13.Count of them
Create view Count_of_Incompleterides AS
select count(incomplete_rides_reason)
from ola_bookings
where incomplete_rides ='Yes';





--1.Retrieve successful bookings:
SELECT * FROM Successful_Bookings;

--2.Count of successful bookings
SELECT * FROM Count_of_Successful_Bookings;

--3.Avg ride distance for each vehicle
SELECT * FROM Avg_Ride_Dist;

--4.Total number of canceled rides by customers
SELECT * FROM No_Canceled_Rides_by_Cus;

--5.Top 5 customers who booked highest number of rides
SELECT * FROM Top_5_Customers;

--6.Number of rides canceled by driver due to car related & personal issues
SELECT * FROM No_Rides_Can_by_Driver;

--7.Min and max driver rating for prime sedan
SELECT * FROM Min_Max_Driver_Ratings;

--8.All rides payments made using UPI
SELECT * FROM Payments_UPI;

--9.Number of rides payments made using UPI
SELECT * FROM No_of_Payments_UPI;

--10.Avg rating by customer per vehicle type
SELECT * FROM Avg_Rating;

--11.Calculate the total booking value of successfully completed rides
SELECT * FROM Total_Suc_Bookings;

--12.List all incomplete rides along with the reasons
SELECT * FROM Incomplete_Rides;

--13.Count of them
SELECT * FROM Count_of_Incompleterides;