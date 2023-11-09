/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id integer PRIMARY KEY NOT NULL,
    name text NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts integer NOT NULL,
    neutered boolean NOT NULL,
    weight_kg numeric NOT NULL,
);

ALTER TABLE animals ADD species TEXT;

CREATE TABLE owners(
    id SERIAL NOT NULL,
    full_name text NOT NULL,
    age integer NOT NULL
);

CREATE TABLE species(
    id SERIAL NOT NULL,
    name TEXT,
);

ALTER TABLE owners
    ADD PRIMARY KEY(id);

ALTER TABLE species
    ADD PRIMARY KEY(id);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id integer;

ALTER TABLE animals
ADD COLUMN owner_id integer;

ALTER TABLE animals
ADD FOREIGN KEY(species_id) REFERENCES species;

ALTER TABLE animals
ADD FOREIGN KEY(owner_id) REFERENCES owners;

/* Join Table for Visits */

/* add vets table */

CREATE TABLE vets(
    id SERIAL PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL
);

/* add specializations table */

CREATE TABLE specializations(
    vet_id INT,
    species_id INT,
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    FOREIGN KEY(species_id) REFERENCES species(id);
);

-- ALTER TABLE specializations
-- ADD FOREIGN KEY(vet_id) REFERENCES vets;

-- ALTER TABLE specializations
-- ADD FOREIGN KEY(species_id) REFERENCES species;

/* visits table */

CREATE TABLE visits(
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    FOREIGN KEY(animal_id) REFERENCES animals,
    FOREIGN KEY(vet_id) REFERENCES vets
);

-- ALTER TABLE visits
-- ADD FOREIGN KEY(animal_id) REFERENCES animals;

-- ALTER TABLE visits
-- ADD FOREIGN KEY(vet_id) REFERENCES vets;