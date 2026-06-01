SELECT 
    start_station_name,
    sum(case when start_station_id=end_station_id then 1 else 0 end) as total_round_trips,
    sum(case when start_station_id=end_station_id and member_casual='casual' and rideable_type='classic_bike' then 1 else 0 end) as casual_classic_round_trips,
    sum(case when start_station_id=end_station_id and member_casual='casual' and rideable_type='electric_bike' then 1 else 0 end) as casual_electric_round_trips,
    sum(case when start_station_id=end_station_id and member_casual='member' and rideable_type='classic_bike' then 1 else 0 end) as member_classic_round_trips,
    sum(case when start_station_id=end_station_id and member_casual='member' and rideable_type='electric_bike' then 1 else 0 end) as member_electric_round_trips
from 
    divvy_trips
WHERE 
    start_station_name IS NOT NULL
group by
     start_station_name
order by 
    total_round_trips desc
limit 10