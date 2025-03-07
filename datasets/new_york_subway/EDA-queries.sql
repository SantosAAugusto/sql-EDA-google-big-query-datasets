/* Ache a tabela “stations” do dataset “new_york_subway” e substitua no campo “station_name”,
a palavra “St” por “Street” nos casos em que o final do nome da estação termine em “St” e “Av” por “Avenue” nos casos em que
o final do nome da estação termine em “Av”. Traga como resultado somente o campo “station_name” de forma distinta e restringindo 
apenas as linhas que tenham “St” ou “Av” no nome. */ 
SELECT DISTINCT
CASE 
WHEN station_name LIKE "%St" THEN replace(station_name, "St", 
"Street") 
WHEN station_name LIKE "%Av" THEN replace(station_name, "Av", 
"Avenue") 
END AS station_name 
FROM bigquery-public-data.new_york_subway.stations 
WHERE station_name LIKE "%St" OR station_name LIKE '%Av'; 


/* No mesmo dataset do item anterior e tabela “stop_times”, extraia somente o nome
do dia da semana do campo “trip_id”,considerando somente sábado e domingo como resposta 
(utilize como restrição no where, usando lower e upper também). Traga também o “trip_id” no select. */ 
SELECT DISTINCT 
trip_id, 
CASE  
WHEN split(trip_id, "-")[ordinal(3)] = 'SI017' THEN split(trip_id, "
")[ordinal(4)] 
ELSE split(trip_id, "-")[ordinal(3)]  
END AS dia 
FROM bigquery-public-data.new_york_subway.stop_times 
WHERE lower(trip_id) LIKE '%sunday%' OR UPPER(trip_id) LIKE '%SATURDAY%';
