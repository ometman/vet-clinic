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

/* visits table */

CREATE TABLE visits(
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    FOREIGN KEY(animal_id) REFERENCES animals,
    FOREIGN KEY(vet_id) REFERENCES vets
);

/* Performance audit exercise */

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create Index idx_animal_id on visits
CREATE INDEX idx_animal_id ON visits(animal_id);

-- Create Index idx_vet_id on visits
CREATE INDEX idx_vet_id ON visits(vet_id)

-- Create Index idx_email on owners
CREATE INDEX idx_email ON owners(email)

/* partitioning */

CREATE TABLE visits_partitioned (
	animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE
) PARTITION BY RANGE (animal_id);

CREATE TABLE visits_part_0 PARTITION OF visits_partitioned FOR VALUES FROM (MINVALUE) TO (1000);
CREATE TABLE visits_part_1 PARTITION OF visits_partitioned FOR VALUES FROM (1000) TO (2000);
CREATE TABLE visits_part_2 PARTITION OF visits_partitioned FOR VALUES FROM (2000) TO (3000);

CREATE INDEX idx_v_part_animal_id ON visits_partitioned (animal_id);
