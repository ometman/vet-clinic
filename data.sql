/* Populate database with sample data. */

INSERT INTO animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8.00);
INSERT INTO animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Devimon', '2017-05-12', 5, TRUE, 11.00);
INSERT INTO animals(
	name, date_of_birth, weight_kg, neutered, escape_attempts)
	VALUES('Charmander', '2020-02-08', -11.00, false, 0);
INSERT INTO animals(
	name, date_of_birth, weight_kg, neutered, escape_attempts)
	VALUES('Plantmon', '2021-11-15', -5.70, true, 2);
INSERT INTO animals(
	name, date_of_birth, weight_kg, neutered, escape_attempts)
	VALUES('Squirtle', '1993-04-02', -12.13, false, 3);
INSERT INTO animals(
	name, date_of_birth, weight_kg, neutered, escape_attempts)
	VALUES('Angemon', '2005-06-12', -45.00, true, 1);
INSERT INTO animals(
	name, date_of_birth, weight_kg, neutered, escape_attempts)
	VALUES('Boarmon', '2005-06-07', 20.40, true, 7);
INSERT INTO animals(
	name, date_of_birth, weight_kg, neutered, escape_attempts)
	VALUES('Blossom', '1998-10-13', 17.00, true, 3);
INSERT INTO animals(
	name, date_of_birth, weight_kg, neutered, escape_attempts)
	VALUES('Ditto', '2022-05-14', 22.00, true, 4);

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