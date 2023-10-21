
Тестовое задание: Расшифровать с помощью SQL-запросов секретное послание!




--1задание

1)Составьте запрос, который выведет имя вида с наименьшим id.

SELECT species_name
FROM species
ORDER BY species_id
LIMIT 1;

2)Составьте запрос, который выведет имя вида с количеством представителей более 1800.

SELECT species_name,  COUNT(*)
FROM species
WHERE species_amount > 1800
GROUP BY species_name;

3)Составьте запрос, который выведет имя вида, начинающегося на «п» и относящегося к типу с type_id = 5.

SELECT species_name
FROM species
WHERE species_name LIKE 'П%'
AND  type_id = 5;

4)Составьте запрос, который выведет имя вида, заканчивающегося на «са» или количество представителей которого равно 5

SELECT species_name
FROM species
WHERE species_name LIKE '%СА'
OR  species_amount = 5;


--2 задание

1)Составьте запрос, который выведет имя вида, появившегося на учете в 2023 году.

SELECT species_name
FROM species
WHERE  date_start > '2023-01-01';

2)Составьте запрос, который выведет названия отсутствующего (status = absent) вида, расположенного вместе с place_id = 3.

SELECT species.species_name
FROM species
JOIN species_in_places 
ON species.species_id=species_in_places.species_id
WHERE species.species_status = 'absent'
AND species_in_places.place_id = 3;

3)Составьте запрос, который выведет название вида, расположенного в доме и появившегося в мае, а также и количество представителей вида.

SELECT species.species_name, species.species_amount 
FROM species
JOIN species_in_places ON species.species_id=species_in_places.species_id
JOIN places ON places.place_id = species_in_places.place_id
WHERE places.place_name = 'дом' 
AND  EXTRACT( MONTH FROM species.date_start  ) = 5;

4)Составьте запрос, который выведет название вида, состоящего из двух слов (содержит пробел).

SELECT species_name
FROM species
WHERE species_name LIKE '% %';


--3 задание

1)Составьте запрос, который выведет имя вида, появившегося с малышом в один день.


SELECT species_name
FROM species
WHERE  date_start = (SELECT date_start FROM species WHERE  species_name = 'малыш' );

2)Составьте запрос, который выведет название вида, расположенного в здании с наибольшей площадью.


SELECT species.species_name, places.place_size, places.place_name
FROM species
JOIN species_in_places ON species.species_id=species_in_places.species_id
JOIN places ON places.place_id = species_in_places.place_id
WHERE places.place_name = 'дом' OR places.place_name = 'сарай'
ORDER BY places.place_size DESC
LIMIT 1;

3)Составьте запрос/запросы, которые найдут название вида, относящегося к 5-й по численности группе проживающего дома.



SELECT species.species_name, species.type_id , COUNT(*)
FROM species
LEFT JOIN species_type ON species.type_id = species_type.type_id
GROUP BY species.type_id ,species.species_name ;

SELECT species.species_name 
FROM species
LEFT JOIN species_type ON species.type_id = species_type.type_id
LEFT JOIN species_in_places ON species_in_places.species_id = species.species_id
LEFT JOIN places ON species_in_places.place_id = places.place_id
WHERE places.place_name ='дом'AND species_type.type_id = 3;

4)Составьте запрос, который выведет сказочный вид (статус fairy), не расположенный ни в одном месте.


SELECT species.species_name
FROM species
LEFT JOIN species_in_places ON species.species_id=species_in_places.species_id 
LEFT JOIN places ON places.place_id = species_in_places.place_id
WHERE species.species_status = 'fairy' OR places.place_name IS NULL;


