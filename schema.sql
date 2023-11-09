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