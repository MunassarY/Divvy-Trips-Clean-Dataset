WITH top_station AS (
    SELECT
        start_station_name AS station_name,
        EXTRACT(MONTH FROM started_at) AS months,
        'Start' AS traffic_type,
        COUNT(*) AS total_trips,
        ROUND(AVG(ride_length::NUMERIC), 2) AS average_duration_minutes,
        sum(case when rideable_type = 'classic_bike' then 1 else 0 end ) as classic_trips,
        sum(case when rideable_type = 'electric_bike' then 1 else 0 end) as electric_trips,
        SUM(CASE WHEN rideable_type = 'classic_bike'  AND member_casual = 'member' THEN 1 ELSE 0 END) AS classic_members,  
        SUM(CASE WHEN rideable_type = 'electric_bike' AND member_casual = 'member' THEN 1 ELSE 0 END) AS electric_members,
        SUM(CASE WHEN rideable_type = 'classic_bike'  AND member_casual = 'casual' THEN 1 ELSE 0 END) AS classic_casuals,
        SUM(CASE WHEN rideable_type = 'electric_bike' AND member_casual = 'casual' THEN 1 ELSE 0 END) AS electric_casuals
    FROM divvy_trips
    WHERE start_station_name IS NOT NULL AND ride_length IS NOT NULL -- Safe from NULL station names
    GROUP BY months, start_station_name

    UNION ALL

    SELECT
        end_station_name AS station_name,
        EXTRACT(MONTH FROM ended_at) AS months,
        'End' AS traffic_type,
        COUNT(*) AS total_trips,
        ROUND(AVG(ride_length::NUMERIC), 2) AS average_duration_minutes,
        sum(case when rideable_type = 'classic_bike' then 1 else 0 end ) as classic_trips,
        sum(case when rideable_type = 'electric_bike' then 1 else 0 end) as electric_trips,
        SUM(CASE WHEN rideable_type = 'classic_bike'  AND member_casual = 'member' THEN 1 ELSE 0 END) AS classic_members,  
        SUM(CASE WHEN rideable_type = 'electric_bike' AND member_casual = 'member' THEN 1 ELSE 0 END) AS electric_members,
        SUM(CASE WHEN rideable_type = 'classic_bike'  AND member_casual = 'casual' THEN 1 ELSE 0 END) AS classic_casuals,
        SUM(CASE WHEN rideable_type = 'electric_bike' AND member_casual = 'casual' THEN 1 ELSE 0 END) AS electric_casuals
    FROM divvy_trips
    WHERE end_station_name IS NOT NULL AND ride_length IS NOT NULL -- Safe from NULL station names
    GROUP BY months, end_station_name
), 

ranking AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY months, traffic_type ORDER BY total_trips DESC) AS rank
    FROM top_station
)

SELECT 
    months,
    traffic_type, 
    station_name,
    total_trips,
    average_duration_minutes,
    
    classic_trips,
    electric_trips,
    classic_members,
    electric_members,
    classic_casuals,
    electric_casuals 
FROM ranking
WHERE rank = 1
ORDER BY total_trips DESC;