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

----- PART 4
CREATE TABLE vets (
    id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    "name" varchar(100) NULL,
    age int NULL,
    date_of_graduation date NULL,
    CONSTRAINT vets_pk PRIMARY KEY (id)
);

CREATE TABLE specializations (
    vet_id int NOT NULL,
    species_id int NOT NULL,
    CONSTRAINT specializations_pk PRIMARY KEY (vet_id,species_id),
    CONSTRAINT specializations_fk FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT specializations_fk_1 FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE visits (
    "date" date NULL,
    vet_id int NULL,
    animal_id int NULL,
    CONSTRAINT visits_fk_1 FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT visits_fk FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE ON UPDATE CASCADE
); 

ALTER TABLE owners ADD COLUMN email VARCHAR(120);
