https://www.macs.hw.ac.uk/~pb56/f21dfexamdata2020/spatial/ 

psql -h -localhost -U hw -d hw -W
abc123

psql -h localhost -U hw -d hw -W -q -f route1.sql

select ST_LENGTH(geom) as route1_length
from route1


psql -h localhost -U hw -d hw -W -q -f roads.sql


select sum(ST_LENGTH(geom)) as all_road_length
from roads 


psql -h localhost -U hw -d hw -W -q -f poi.sql

select * from route1.geom 

select count(distinct poi.id) as letter_box_number
from poi 
join route1
on ST_INTERSECTS(poi.geom, ST_BUFFER(route1.geom,200 ))
where poi.pointxclass = '06340457'



drop table if exists cash_matchine;
create table cash_matchine as 
select * from poi 
where poi.pointxclass = '02090141';

drop table if exists bus_stop;
create table bus_stop as 
select * from poi 
where poi.pointxclass = '10590732';

drop table if exists cash_matchine_bus_stop_dist;
create table cash_matchine_bus_stop_dist as 
SELECT ST_DISTANCE(cash_matchine.geom, bus_stop.geom) as dst 
FROM cash_matchine 
CROSS JOIN bus_stop;

select min(dst) as closest_distance,
max(dst) as furthest_distance
from cash_matchine_bus_stop_dist;

436*153
66708



psql -h localhost -U hw -d hw -W -q -f zones.sql

select * 
from zones
limit 100


select zones.zoneid, count(distinct poi.id) as point_density 
from poi 
join zones 
on st_within(poi.geom, zones.geom)
group by zones.zoneid
order by count(distinct poi.id) desc
limit 1;

select  ST_ASTEXT(geom)
from roads

select 
zones.zoneid,
sum(ST_LENGTH(roads.geom)) as total_road_length
from roads
join zones
on st_within(roads.geom, zones.geom)
group by zones.zoneid;