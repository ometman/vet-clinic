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
WHERE name LIKE '%mon';

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

/* 7 Queries using join */

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name AS species, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

/* Query Questions */

-- Who was the last animal seen by William Tatcher?

SELECT a.name AS william_last
FROM visits v
LEFT JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT COUNT(DISTINCT v.animal_id) AS mendez_no
FROM visits v
LEFT JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT vt.name AS vet_name, s.name AS specialties
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT a.name AS animal_name
FROM visits v
LEFT JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'Stephanie Mendez'
  AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


-- What animal has the most visits to vets?

SELECT a.name AS animal_name, COUNT(v.animal_id) AS visit_count
FROM visits v
LEFT JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;


-- Who was Maisy Smith's first visit?

SELECT a.name AS first_visit_animal, MIN(v.date_of_visit) AS first_visit_date
FROM visits v
LEFT JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN animals a ON v.animal_id = a.id
WHERE vt.name = 'Maisy Smith'
GROUP BY a.name
ORDER BY first_visit_date
LIMIT 1;


-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT a.name AS animal_name, vt.name AS vet_name, v.date_of_visit AS last_visit_date
FROM visits v
LEFT JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN animals a ON v.animal_id = a.id
ORDER BY v.date_of_visit DESC
LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) AS non_specialized_visits
FROM visits v
LEFT JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations s ON vt.id = s.vet_id AND a.species_id = s.species_id
WHERE s.species_id IS NULL;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT s.name AS required_specialty, COUNT(*) AS visit_count
FROM visits v
LEFT JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visit_count DESC
LIMIT 1;

-- Explain analyze queries
EXPLAIN ANALYZE  SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE  SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE  SELECT * FROM owners where email = 'owner_18327@mail.com';