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