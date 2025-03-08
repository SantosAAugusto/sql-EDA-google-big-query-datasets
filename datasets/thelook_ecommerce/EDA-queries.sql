/* Utilize o dataset público “thelook_ecommerce”, que está presente no 
projeto “bigquery-public-data” para trazer o identificador único dos usuários, o primeiro nome, 
email e idade, ordernados pela data de criação do cadastro. */
SELECT 
id, 
first_name, 
email, 
age 
FROM `bigquery-public-data.thelook_ecommerce.users` 
ORDER BY created_at; 


/* No mesmo dataset do exercício anterior, extraia os pedidos que 
tenham status “Shipped” ou “Processing”. */ 
SELECT 
order_id, 
status 
FROM `bigquery-public-data.thelook_ecommerce.orders` 
WHERE status = "Shipped" OR status = "Processing"; 
/*OU*/
SELECT 
order_id, 
status 
FROM `bigquery-public-data.thelook_ecommerce.orders` 
WHERE status IN ("Shipped", "Processing"); 


/* Considerando o mesmo exercício anterior, traga os pedidos que foram 
criados no dia “2022-04-05” e, ao mesmo tempo, tenham status “Cancelled”. */ 
SELECT 
order_id, 
status, 
created_at, 
date(created_at) AS dia 
FROM `bigquery-public-data.thelook_ecommerce.orders` 
WHERE status = "Cancelled" AND date(created_at) = "2022-04-05"; 


/* O time de marketing deseja fazer uma campanha em um país específico, com o mesmo dataset dos itens anteriores.  
Para isso, eles te pedem os e-mails de todos os clientes que moram no Brasil. */ 
SELECT 
email 
FROM `bigquery-public-data.thelook_ecommerce.users` 
WHERE email IS NOT NULL AND country = "Brasil"; 


/* No mesmo dataset anterior, traga o nome dos usuários e o id de seus pedidos. */ 
SELECT 
order_id, 
first_name 
FROM `bigquery-public-data.thelook_ecommerce.users` u  
JOIN `bigquery-public-data.thelook_ecommerce.orders` o ON u.id = 
o.user_id;


/* Calcule o tempo em dias da 
data de cadastro até a última compra de cada usuário. */ 
SELECT 
u.id, 
max(timestamp_diff(o.created_at, u.created_at, day)) AS 
dias_ate_ultima_compra 
FROM bigquery-public-data.thelook_ecommerce.orders o 
JOIN bigquery-public-data.thelook_ecommerce.users u ON u.id = o.user_id 
GROUP BY 1 
ORDER BY 2 DESC; 


/* Na mesma tabela, calcule o tempo em dias entre a primeira e a última 
compra de cada usuário. */ 
SELECT 
user_id, 
timestamp_diff(max(created_at), min(created_at), day) AS 
dias_entre_prim_ult 
FROM bigquery-public-data.thelook_ecommerce.orders 
GROUP BY 1 
ORDER BY 2 DESC; 


/* No mesmo dataset, e tabela de eventos, traga a quantidade de 
registros para cada usuário entre 06 de maio de 2023 - 73 dias e 09 de 
maio de 2023 nos eventos de carrinho e compra. Ordene por usuário e tipo 
do evento. */ 
SELECT 
user_id, 
event_type, 
COUNT(distinct id) AS eventos 
FROM bigquery-public-data.thelook_ecommerce.events 
WHERE event_type IN ('cart', 'purchase') AND date(created_at) BETWEEN 
date_sub('2023-05-06', interval 73 day) AND '2023-05-09' 
AND user_id IS NOT NULL 
GROUP BY 1,2 
ORDER BY user_id, event_type;


/* Traga os usuários que não tem compra em dezembro de 2022. */ 
SELECT DISTINCT
u.id 
FROM bigquery-public-data.thelook_ecommerce.users u 
LEFT JOIN bigquery-public-data.thelook_ecommerce.orders o ON u.id = 
o.user_id AND date(o.created_at) BETWEEN "2022-12-01" AND "2022-12-31" 
WHERE o.user_id IS NULL; 


/* Traga informações resumidas sobre os usuários (de todos, tendo ou não compras). Id do usuário,
quantidade de compras realizadas, quantidade de itens comprados, ticket médio, quantidade de produtos distintos comprados,
centro de distribuições dos quais o usuário recebeu produtos, quantidade de criações de carrinho. */ 
SELECT 
u.id, 
tm, 
compras_realizadas, 
itens_comprados, 
produtos_distintos, 
centros_distribuicao, 
COUNT(DISTINCT e.id) AS eventos_carrinho 
FROM bigquery-public-data.thelook_ecommerce.users u 
LEFT JOIN bigquery-public-data.thelook_ecommerce.events e ON e.user_id = 
u.id AND event_type = 'cart' 
LEFT JOIN ( 
SELECT 
o.user_id, 
sum(sale_price)/COUNT(DISTINCT o.order_id) AS tm, 
COUNT(DISTINCT o.order_id) AS compras_realizadas, 
COUNT(DISTINCT oi.id) AS itens_comprados, 
COUNT(DISTINCT p.id) AS produtos_distintos, 
COUNT(DISTINCT d.id) AS centros_distribuicao 
FROM bigquery-public-data.thelook_ecommerce.orders o 
LEFT JOIN bigquery-public-data.thelook_ecommerce.order_items oi ON 
o.order_id = oi.order_id 
LEFT JOIN bigquery-public-data.thelook_ecommerce.products p ON p.id = 
oi.product_id 
LEFT JOIN bigquery-public-data.thelook_ecommerce.distribution_centers d 
ON d.id = p.distribution_center_id 
GROUP BY 1 
) T ON T.user_id = u.id 
GROUP BY 1, 2, 3, 4, 5;
