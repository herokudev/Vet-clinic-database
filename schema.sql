/* Database schema to keep the structure of entire database. */

create table animals (
id serial,
name varchar(45),
date_of_birth date,
escape_attemts integer,
neutered boolean,
weight_kg decimal(10,4),
user_name varchar (45),
timestamp timestamp,
primary key (id)
);

----- PART 2
ALTER TABLE
animals 
ADD COLUMN IF NOT EXISTS species VARCHAR(100);

----- PART 3
CREATE TABLE owners
(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species
(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE
animals
ADD COLUMN IF NOT EXISTS species_id INT REFERENCES species(id);

ALTER TABLE
animals
ADD COLUMN IF NOT EXISTS owner_id INT REFERENCES owners(id);
