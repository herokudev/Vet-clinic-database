INSERT INTO owners(full_name, age) VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name) VALUES ('Pokemon'),
('Digimon');

INSERT INTO vets(name, age, date_of_graduation) 
VALUES ('William Tatcher', 45, '20000423'),
('Maisy Smith', 26, '20190117'),
('Stephanie Mendez', 64, '19810504'),
('Jack Harkness', 38, '20080608');


INSERT INTO 
  animals(name, date_of_birth, escape_attempts, neutered, weigth_kg) 
VALUES ('Agumon', '20200203', 0, true, 10.23 ),
('Gabumon', '20181115', 2, true, 8 ),
('Pikachu', '20210107', 1, false, 15.04 ),
('Devimon', '20170512', 5, true, 11 ),
('Charmander', '20200208', 0, false, 11 ),
('Plantmon', '20221115', 2, true, 5.7 ),
('Squirtle', '19930402', 3, false, 12.13 ),
('Angemon', '20050612', 1, true, 45 ),
('Boarmon', '20050607', 7, true, 20.4 ),
('Blossom', '19981013', 3, true, 17 );

BEGIN;
UPDATE animals
SET species_id = 2
WHERE animals.name LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals
SET species_id = 1
WHERE animals.name NOT LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon'  OR name = 'Boarmon';
COMMIT;

BEGIN;
INSERT INTO specializations(vet_id, specie_id) VALUES(
(SELECT vt.id from vets vt WHERE vt.name = 'William Tatcher'), 
(SELECT sp.id from species sp WHERE sp.name = 'Pokemon'));
COMMIT;

BEGIN;
INSERT INTO specializations(vet_id, specie_id) VALUES(
(SELECT vt.id from vets vt WHERE vt.name = 'Stephanie Mendez'), 
(SELECT id from species WHERE name = 'Digimon'));
COMMIT;

BEGIN;
INSERT INTO specializations(vet_id, specie_id) VALUES(
(SELECT vt.id from vets vt WHERE vt.name = 'Stephanie Mendez'), 
(SELECT id from species WHERE name = 'Pokemon'));
COMMIT;

BEGIN;
INSERT INTO specializations(vet_id, specie_id) VALUES(
(SELECT id from vets WHERE name = 'Jack Harkness'),
(SELECT id from species WHERE name = 'Digimon'));
COMMIT;

BEGIN;
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES
(
  (SELECT id from animals WHERE name = 'Agumon'),
  (SELECT id from vets WHERE name = 'William Tatcher'),
  '20200524'
),
(
  (SELECT id from animals WHERE name = 'Agumon'),
  (SELECT id from vets WHERE name = 'Stephanie Mendez'),
  '20200722'
),
(
  (SELECT id from animals WHERE name = 'Gabumon'),
  (SELECT id from vets WHERE name = 'Jack Harkness'),
  '20210202'
),
(
  (SELECT id from animals WHERE name = 'Pikachu'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20200105'
),
(
  (SELECT id from animals WHERE name = 'Pikachu'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20200308'
),
(
  (SELECT id from animals WHERE name = 'Pikachu'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20200514'
),
(
  (SELECT id from animals WHERE name = 'Devimon'),
  (SELECT id from vets WHERE name = 'Stephanie Mendez'),
  '20210504'
),
(
  (SELECT id from animals WHERE name = 'Charmander'),
  (SELECT id from vets WHERE name = 'Jack Harkness'),
  '20210224'
),
(
  (SELECT id from animals WHERE name = 'Plantmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20191221'
),
(
  (SELECT id from animals WHERE name = 'Plantmon'),
  (SELECT id from vets WHERE name = 'William Tatcher'),
  '20200810'
),
(
  (SELECT id from animals WHERE name = 'Plantmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20210407'
),
(
  (SELECT id from animals WHERE name = 'Squirtle'),
  (SELECT id from vets WHERE name = 'Stephanie Mendez'),
  '20190929'
),
(
  (SELECT id from animals WHERE name = 'Angemon'),
  (SELECT id from vets WHERE name = 'Jack Harkness'),
  '20201003'
),
(
  (SELECT id from animals WHERE name = 'Angemon'),
  (SELECT id from vets WHERE name = 'Jack Harkness'),
  '20201104'
),
(
  (SELECT id from animals WHERE name = 'Boarmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20190124'
),
(
  (SELECT id from animals WHERE name = 'Boarmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20190515'
),
(
  (SELECT id from animals WHERE name = 'Boarmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20200227'
),
(
  (SELECT id from animals WHERE name = 'Boarmon'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20200803'
),
(
  (SELECT id from animals WHERE name = 'Blossom'),
  (SELECT id from vets WHERE name = 'Stephanie Mendez'),
  '20200524'
),
(
  (SELECT id from animals WHERE name = 'Blossom'),
  (SELECT id from vets WHERE name = 'Maisy Smith'),
  '20210111'
);
COMMIT;

BEGIN;
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
COMMIT;

BEGIN;
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
COMMIT;

BEGIN;
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
COMMIT;