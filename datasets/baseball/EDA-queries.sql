/* Vá ao dataset público “baseball” e na tabela “schedules” traga os identificadores únicos
, o nome do time da casa e o nome do time de fora de casa dos jogos em que a duração foi 
maior ou igual a 250 minutos e menos de 25 mil espectadores. */ 
SELECT
gameId, 
homeTeamName, 
awayTeamName, 
duration_minutes, 
attendance 
FROM `bigquery-public-data.baseball.schedules` 
WHERE duration_minutes >= 250 AND attendance < 25000; 


/* No mesmo dataset e tabela, retorne os jogos que começaram entre maio e junho de 2016. */ 
SELECT 
* 
FROM `bigquery-public-data.baseball.schedules` 
WHERE date(startTime) BETWEEN "2016-05-01" AND "2016-06-30"; 
SELECT 
* 
FROM `bigquery-public-data.baseball.schedules` 
WHERE startTime BETWEEN "2016-05-01 00:00:00" AND "2016-06-30 23:59:59"; 


/* No mesmo dataset anterior, descubra o nome dos times que 
tenham somente 6 caracteres, usando o like. Retorne de forma única. */ 
SELECT DISTINCT 
homeTeamName 
FROM `bigquery-public-data.baseball.schedules` 
WHERE homeTeamName LIKE '______';


/* Retorne em uma só consulta os valores de média, máximo, mínimo, contagem e soma do campo “attendance” da tabela 
“schedules”, dataset “baseball”, mesmo que a contagem e a soma de torcedores 
nos estádios não tenham significado para análise de negócio. */ 
SELECT
avg(attendance) media, 
max(attendance) maximo, 
min(attendance) minimo, 
COUNT(attendance) contagem, 
sum(attendance) soma 
FROM `bigquery-public-data.baseball.schedules` 
WHERE status = "closed"; 


/* No mesmo dataset e tabela do exercício anterior, retornar a quantidade de jogos disputados por 
cada time em casa por anoe também a soma de minutos jogados em casa por ano. Ordenar de forma decrescente 
pelo ano e depois crescente pelo nome do time. */ 
SELECT 
COUNT(gameId) AS jogos, 
sum(duration_minutes) AS soma_minutos, 
homeTeamName, 
year 
FROM `bigquery-public-data.baseball.schedules` 
WHERE status = "closed" 
GROUP BY 3,4 
ORDER BY YEAR DESC, homeTeamName ASC;
