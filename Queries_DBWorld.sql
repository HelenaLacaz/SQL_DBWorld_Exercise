-- Calcule a população de cada continente

SELECT continent, sum(population) FROM country WHERE population > 0 GROUP BY continent;

-- Mostre os códigos dos países com pelo menos 3 idiomas oficiais

SELECT country_code, count(language) AS Linguas_Oficiais FROM country_language 
WHERE is_official = 'T' 
GROUP BY country_code HAVING Linguas_Oficiais >= 3 ORDER BY Linguas_Oficiais DESC;

-- Lista o nome das cidades ao lado do nome do seu pais

ALTER TABLE city RENAME COLUMN name TO cities;

##ALTER TABLE country RENAME COLUMN name TO countries;

SELECT DISTINCT cities, name FROM city JOIN (SELECT DISTINCT name FROM country) ON city.country_code = country.code;

SELECT DISTINCT city.cities as Cidade, country.name AS Pais FROM city JOIN country ON city.country_code = country.code;

-- Liste o nome das cidades ao lado dos nomes dos paises, cujo nome começa com o nome da cidade. Guarde o resultado em uma tabela temporária.

CREATE TABLE if not EXISTS origens (
	nome_cidade varchar(150),
	nome_pais varchar(150));
	

INSERT INTO origens
SELECT DISTINCT cities as nome_cidade, name as nome_pais FROM city JOIN country ON city.country_code = country.code WHERE nome_pais like cities || '%';
SELECT * FROM origens;

-- Insira informações (linhas) das cidades de São Paulo e Rio de Janeiro, pertecentes a Brasil

INSERT INTO origens
SELECT DISTINCT cities as nome_cidade, name as nome_pais FROM city JOIN country ON city.country_code = country.code 
	WHERE nome_cidade like '%São Paulo%' or nome_cidade like '%Rio de Janeiro%';
SELECT * FROM origens;

SELECT * FROM city WHERE cities like '%Guaratinguetá%';

DELETE FROM city WHERE cities = 'Sao Paolo';

-- Insira informações (cidade e país) que possuam countr_code = 'ALB'

SELECT city.*, country.name FROM city JOIN country ON city.country_code = country.code WHERE country_code like '%ALB%';

INSERT INTO city VALUES ('', 'Berat', 'ALB', 'Berat', 1000); 

INSERT INTO origens
SELECT city.cities, country.name FROM city JOIN country ON city.country_code = country.code WHERE country_code like '%ALB%';

SELECT * FROM origens;

-- Atualize um dos campo da tabela que acabou de criar

UPDATE origens
SET nome_cidade='Macaao'
WHERE nome_pais='Macao';

SELECT * FROM origens;

DROP TABLE origens;

-- Brincando

-- Cidades da Ucrânia

SELECT city.cities as Cidade, country.name AS Pais FROM city JOIN country ON city.country_code = country.code WHERE Pais like '%Ukraine';


-- Cidades da Russia

SELECT DISTINCT name FROM country ORDER BY name;

SELECT city.cities as Cidade, country.name AS Pais FROM city JOIN country ON city.country_code = country.code WHERE Pais like 'Russia%';

SELECT DISTINCT name as Pais, sum(population) as Total_Population FROM country WHERE name like '%Ukraine' or name like 'Russia%' GROUP BY name;

