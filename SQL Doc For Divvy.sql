-- 1. Set up table schema.
ALTER TABLE "Projects"."Q1_Divvy"
ADD ride_id text,
ADD rideable_type text,
ADD started_at timestamp,
ADD ended_at timestamp,
ADD start_station text,
ADD start_station_id int,
ADD end_station text,
ADD end_station_id int,
ADD start_lat int,
ADD start_lng int,
ADD end_lat int,
ADD end_lng int,
ADD member_casual text

-- 2. This is where I imported the SQL Data using postgresql's built in function and then created new columns ride_length to figure out the length of the rides and day_of_week in order to further my analysis

ALTER TABLE "Projects"."Q1_Divvy"
ADD COLUMN ride_length interval 

UPDATE "Projects"."Q1_Divvy"
SET ride_length = ended_at-started_at

ALTER TABLE "Projects"."Q1_Divvy"
ADD COLUMN day_of_week text

ALTER TABLE "Projects"."Q1_Divvy"
ADD COLUMN day_of_week text

/* 3. Did some Descriptive Analysis, finding the amount of casual members compared to Paid Members, The average of the ride length 
in general, and sorted by Member, and day of the week, and the amount of rides grouped by casual and paid members as well as day of week*/

-- What's the number of paid members vs casual members?
SELECT initcap(member_casual),COUNT(member_casual) AS memcas 
FROM "Projects"."Q1_Divvy"
WHERE member_casual IN	('member','casual')
GROUP BY member_casual

-- What's the average ride duration of paid members vs casual members?
SELECT initcap(member_casual), AVG(ride_duration) AS Avg_Dur
FROM "Projects"."Q1_Divvy"
WHERE member_casual IN ('member','casual')
GROUP BY member_casual

-- How Many Trips are there Per day
SELECT day_of_week, count(*) AS n_trips
FROM "Projects"."Q1_Divvy"
WHERE member_casual IN('member','casual')
GROUP BY day_of_week

-- Average Ride Duration per day

SELECT day_of_week,AVG(ride_length) AS Avg_dur
FROM "Projects"."Q1_Divvy"
WHERE member_casual IN('member','casual')
GROUP BY day_of_week

-- Average Ride Duration Per day according to membership status

SELECT initcap(member_casual),day_of_week,avg(ride_length) AS Avg_Dur
FROM "Projects"."Q1_Divvy"
WHERE member_casual IN('member','casual')
GROUP BY member_casual,day_of_week

-- Amount of Rides by Day of Week ad Membership Status

SELECT initcap(member_casual),day_of_week,count(member_casual) AS memcas
FROM "Projects"."Q1_Divvy"
WHERE member_casual IN ('member','casual')
GROUP BY member_casual,day_of_week


