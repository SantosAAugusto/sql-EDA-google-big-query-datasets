/* No dataset “austin_bikeshare”, descubra qual a quantidade de viagens realizadas em 2017
com duração de 30 minutos ou mais, somente de estações (tanto de partida quanto de chegada) 
que estão atualmente ativas. */ 
SELECT 
COUNT(trip_id) AS viagens 
FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips` t 
JOIN `bigquery-public-data.austin_bikeshare.bikeshare_stations` si ON 
t.start_station_id = si.station_id 
JOIN `bigquery-public-data.austin_bikeshare.bikeshare_stations` sf ON 
t.end_station_id = CAST(sf.station_id AS string) 
WHERE extract(year from start_time) = 2017  
AND duration_minutes >= 30 
AND si.status = "active" 
AND sf.status = "active"; 


/* No mesmo dataset anterior, calcule a média de duração das viagens 
por tipo de cliente (“subscriber_type”) por ano. */ 
SELECT 
round(avg(duration_minutes), 1) AS media_duracao_viagens, 
subscriber_type, 
extract(year from start_time) AS YEAR 
FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips` t 
GROUP BY 2,3 
ORDER BY YEAR;
