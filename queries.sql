/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * from animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.40 AND weight_kg <= 17.30;

/*Transactions 1 */

BEGIN;
UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals

ROLLBACK;

SELECT * FROM animals

/*Transactions 2 */

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name = '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

/* Transactions 3 */

BEGIN;
TRUNCATE animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;


/* Transactions 4 */

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT animalsdel;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO animalsdel;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0; 

COMMIT ;

/* Queries for Questions */

SELECT COUNT(*) AS total_animals
FROM animals;

SELECT COUNT(*) AS no_escape
FROM animals
WHERE escape_attempts = 0;

SELECT ROUND(AVG(weight_kg), 2) AS average_weight
FROM animals;

SELECT MAX(escape_attempts) AS max_escapes
FROM animals;

SELECT MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals;

SELECT ROUND(AVG(escape_attempts), 2) AS average_escape
FROM animals
WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-31';
