DROP TABLE IF EXISTS owners CASCADE;
DROP TABLE IF EXISTS species CASCADE;
DROP TABLE IF EXISTS vets CASCADE;
DROP TABLE IF EXISTS animals CASCADE;
DROP TABLE IF EXISTS specializations;
DROP TABLE IF EXISTS visits;

CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name varchar(80) NOT NULL,
  age INT NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY,
  name varchar(80) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY,
  name varchar(80) NOT NULL,
  age INT NOT NULL,
  date_of_graduation date NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(80) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts INT,
    neutered boolean NOT NULL,
    weigth_kg float NOT NULL,
    species_id INT,
    owner_id INT,
    PRIMARY KEY(id),
    CONSTRAINT fk_species
      FOREIGN KEY(species_id)
        REFERENCES species(id)
          ON DELETE CASCADE,
    CONSTRAINT fk_owners
      FOREIGN KEY(owner_id)
        REFERENCES owners(id)
          ON DELETE CASCADE
);

CREATE TABLE specializations(
  id INT GENERATED ALWAYS AS IDENTITY,
  specie_id INT NOT NULL,
  vet_id INT NOT NULL,
  CONSTRAINT fk_species
    FOREIGN KEY(specie_id)
      REFERENCES species(id)
        ON DELETE CASCADE,
  CONSTRAINT fk_vets
    FOREIGN KEY(vet_id)
      REFERENCES vets(id)
        ON DELETE CASCADE,
  PRIMARY KEY(id)
);

CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT NOT NULL,
  vet_id INT NOT NULL,
  date_of_visit date NOT NULL,
  CONSTRAINT fk_animals
    FOREIGN KEY(animal_id)
      REFERENCES animals(id)
        ON DELETE CASCADE,
  CONSTRAINT fk_vets
    FOREIGN KEY(vet_id)
      REFERENCES vets(id)
        ON DELETE CASCADE,
  PRIMARY KEY(id)
);
