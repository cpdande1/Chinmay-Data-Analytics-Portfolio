#Average Rider Length
SELECT
rider_length,
  (SELECT
    AVG(rider_length)
    FROM
    `bamboo-weft-412703.Cyclist_data.June 2020`) AS avg_rider_length
 FROM
`bamboo-weft-412703.Cyclist_data.June 2020`

#Minium Rider Length
SELECT
rider_length,
  (SELECT
    MIN(rider_length)
    FROM
    `bamboo-weft-412703.Cyclist_data.June 2020`) AS min_rider_length
FROM
`bamboo-weft-412703.Cyclist_data.June 2020`

#Max Rider Length
SELECT
rider_length,
  (
    SELECT
    Max(rider_length)
    FROM
    `bamboo-weft-412703.Cyclist_data.June 2020`) AS max_rider_length
 FROM
`bamboo-weft-412703.Cyclist_data.June 2020`

# Number of Average Rides based on customer type
SELECT
rider_length,
COUNT(member_casual) AS number_of_rides,
day_of_week,
  (
    SELECT
    AVG(day_of_week)
    FROM
    `bamboo-weft-412703.Cyclist_data.June 2020`) AS max_rider_length
FROM
`bamboo-weft-412703.Cyclist_data.June 2020`
GROUP BY
rider_length,
day_of_week

# Number of Average Rides based on Casual members
SELECT
rider_length,
day_of_week,
  (
    SELECT
    COUNT(member_casual) AS avg_rides_casual
    FROM
    `bamboo-weft-412703.Cyclist_data.June 2020`
    WHERE
    member_casual = 'casual') AS casual_member
  FROM
`bamboo-weft-412703.Cyclist_data.June 2020`
GROUP BY
rider_length,
day_of_week,
member_casual
ORDER BY
member_casual

# Number of Average Rides based on annual members
SELECT
rider_length,
day_of_week,
  (
    SELECT
    COUNT(member_casual) AS avg_rides_casual
    FROM
    `bamboo-weft-412703.Cyclist_data.June 2020`
    WHERE
    member_casual = 'member') AS annual_member
  FROM
`bamboo-weft-412703.Cyclist_data.June 2020`
GROUP BY
rider_length,
day_of_week,
member_casual
ORDER BY
member_casual

#Average usage of annual members based of day of week
SELECT
AVG(rider_length) AS average_rider_length,
AVG(day_of_week) AS average_usage_per_day_of_week,
  (
    SELECT
    COUNT(member_casual) AS avg_rides_casual
    FROM
    `bamboo-weft-412703.Cyclist_data.June 2020`
    WHERE
    member_casual = 'member') AS annual_member
  FROM
`bamboo-weft-412703.Cyclist_data.June 2020`
GROUP BY
rider_length,
day_of_week,
member_casual
ORDER BY
average_usage_per_day_of_week DESC,
member_casual
LIMIT 10

#Number of rides based on time of day for casual members
SELECT DISTINCT
start_time,
member_casual,
  CASE
  When start_time  >= "6:00" Then 'Morning'
  When start_time  >= '12:00'Then 'Afternoon'
  When start_time  >= '17:00' Then 'Evening'
  Else 'Night'
End as time_of_day
 FROM
`bamboo-weft-412703.Cyclist_data.June 2020`
WHERE
member_casual = "casual"
GROUP BY
start_time,
member_casual
ORDER BY
time_of_day

#Average day of week where bikes are used for casual and annual members
SELECT DISTINCT
AVG(day_of_week) as day_casual,
member_casual,
FROM
`bamboo-weft-412703.Cyclist_data.April 2020`
GROUP BY
member_casual
ORDER BY
member_casual,
day_casual