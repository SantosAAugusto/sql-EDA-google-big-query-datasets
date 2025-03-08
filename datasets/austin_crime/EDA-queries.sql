/* Pegue 10 incidentes aleatórios com latitude e longitude não nulas. Crie os pontos geográficos.
Vá até o Google Maps e selecione uma coordenada qualquer na cidade de Austin, EUA (pesquise como fazer) e
calcule a distância (em km) entre cada ponto desses incidentes à coordenada escolhida.  Crie também as rotas de cada incidente à coordenada. */ 
SELECT 
  unique_key, 
  # infos dos incidentes 
  latitude, 
  longitude, 
  ST_GEOGPOINT(longitude, latitude) AS ponto_geografico_incidente, 
  # infos do mcdonalds 30.2723734,-97.6981411 
  ST_GEOGPOINT(-97.6981411, 30.2723734) AS ponto_geografico_mcdonalds, 
  # distancia 
  round(ST_DISTANCE(ST_GEOGPOINT(longitude, latitude), ST_GEOGPOINT(
97.6981411, 30.2723734))/1000, 2) AS distancia, 
  # criando linhas de rota 
  ST_MAKELINE(ST_GEOGPOINT(longitude, latitude), ST_GEOGPOINT(
97.6981411, 30.2723734)) AS rota 
FROM bigquery-public-data.austin_crime.crime 
WHERE latitude IS NOT NULL  
  AND longitude IS NOT NULL 
ORDER BY rand() 
LIMIT 10; 


/* Calcule a mínima e a máxima distância do resultado da query acima. */ 
WITH dist AS ( 
  SELECT 
    unique_key, 
    # infos dos incidentes 
    latitude, 
    longitude, 
    ST_GEOGPOINT(longitude, latitude) AS ponto_geografico_incidente, 
    # infos do mcdonalds 30.2723734,-97.6981411 
    ST_GEOGPOINT(-97.6981411, 30.2723734) AS ponto_geografico_mcdonalds, 
    # distancia 
    round(ST_DISTANCE(ST_GEOGPOINT(longitude, latitude), ST_GEOGPOINT(
97.6981411, 30.2723734))/1000, 2) AS distancia, 
    # criando linhas de rota 
    ST_MAKELINE(ST_GEOGPOINT(longitude, latitude), ST_GEOGPOINT(
97.6981411, 30.2723734)) AS rota 
  FROM bigquery-public-data.austin_crime.crime 
  WHERE latitude IS NOT NULL  
    AND longitude IS NOT NULL 
  ORDER BY rand() 
  LIMIT 10) 
 
SELECT 
  min(distancia) AS minimo, 
  max(distancia) AS maximo 
FROM dist;
