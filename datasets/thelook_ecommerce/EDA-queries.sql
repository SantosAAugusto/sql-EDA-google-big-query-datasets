/* 1) Utilize o dataset público “thelook_ecommerce”, que está presente no 
projeto “bigquery-public-data” para trazer o identificador único dos usuários, o primeiro nome, 
email e idade, ordernados pela data de criação do cadastro. */
select 
id, 
first_name, 
email, 
age 
from `bigquery-public-data.thelook_ecommerce.users` 
order by created_at; 


/* 2) No mesmo dataset do exercício anterior, extraia os pedidos que 
tenham status “Shipped” ou “Processing”. */ 
select 
order_id, 
status 
from `bigquery-public-data.thelook_ecommerce.orders` 
where status = "Shipped" or status = "Processing"; 
select 
order_id, 
status 
from `bigquery-public-data.thelook_ecommerce.orders` 
where status in ("Shipped", "Processing"); 


/* 3) Considerando o mesmo exercício anterior, traga os pedidos que foram 
criados no dia “2022-04-05” e, ao mesmo tempo, tenham status “Cancelled”. */ 
select 
order_id, 
status, 
created_at, 
date(created_at) as dia 
from `bigquery-public-data.thelook_ecommerce.orders` 
where status = "Cancelled" and date(created_at) = "2022-04-05"; 


/* 4) O time de marketing deseja fazer uma campanha em um país específico, com o mesmo dataset dos itens anteriores.  
Para isso, eles te pedem os e-mails de todos os clientes que moram no Brasil. */ 
select 
email 
from `bigquery-public-data.thelook_ecommerce.users` 
where email is not null and country = "Brasil"; 


/* 5) No mesmo dataset anterior, traga o nome dos usuários e o id de seus pedidos. */ 
select 
order_id, 
first_name 
from `bigquery-public-data.thelook_ecommerce.users` u  
join `bigquery-public-data.thelook_ecommerce.orders` o on u.id = 
o.user_id;
