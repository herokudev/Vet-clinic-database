/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';

SELECT * FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '12-31-2019';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

----- PART 2
BEGIN;

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';

UPDATE animals SET species = 'pokemon' WHERE species is NULL;

COMMIT;

SELECT * FROM animals;

DELETE FROM animals;

ROLLBACK;

BEGIN;

DELETE FROM animals WHERE date_of_birth > '01-01-2022';

SAVEPOINT first_savepoint;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SAVEPOINT first_savepoint;

UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN 'JAN-01-1990' AND 'DEC-31-2000' GROUP BY species;

----- PART 3
SELECT name
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

SELECT species.name, COUNT(animals)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT MAX(mycount.count),
       mycount.name
FROM
  (SELECT COUNT(animals),
          owners.full_name as name
   FROM animals
   JOIN owners ON animals.owner_id = owners.id
   GROUP BY owners.full_name) AS mycount
GROUP BY mycount.name
HAVING MAX(mycount.count) =
  (SELECT MAX(mycount.count)
   FROM
     (SELECT COUNT(animals),
             owners.full_name as name
      FROM animals
      JOIN owners ON animals.owner_id = owners.id
      GROUP BY owners.full_name) AS mycount);
      
----- PART 4
SELECT v.date, a.name as pokemon, v2."name" as vet 
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
where v2."name" = 'William Tatcher'
order by v."date" desc limit 1;

SELECT count(distinct v.animal_id), v2."name" as vet
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
where v2."name" = 'Stephanie Mendez'
group by v2."name";

SELECT v."name", s2."name" 
FROM vets v 
left JOIN specializations s on s.vet_id = v.id 
left join species s2 on s.species_id = s2.id ;

SELECT v.date, a.name as pokemon, v2."name" as vet 
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
where v2."name" = 'Stephanie Mendez' and v."date" between 'apr-01-2020' and 'aug-30-2020';

select max(mycount.count), mycount.name

from (
	select count(v."date"), a."name" 
	from visits v 
	join animals a on v.animal_id = a.id
	group by a."name"
) as mycount

group by mycount.name

having max(mycount.count) = (
	select max(mycount.count)
	from (
		select count(v."date"), a."name" 
		from visits v 
		join animals a on v.animal_id = a.id 
		group by a."name"
	) as mycount
);

SELECT v.date, a.name as pokemon, v2."name" as vet 
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
where v2."name" = 'Maisy Smith'
order by v."date" asc limit 1;

SELECT v.date, a.name as pokemon, v2."name" as vet
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
order by v."date" desc limit 1;

SELECT v.date, animals, vets
FROM visits v 
JOIN animals ON v.animal_id = animals.id 
JOIN vets ON v.vet_id = vets.id
order by v."date" desc limit 1;

select count(visits.animal_id), species."name" as specie
from visits
join animals on visits.animal_id = animals.id 
join species on animals.species_id = species.id
join vets on visits.vet_id = vets.id
where vets."name" = 'Maisy Smith'
group by  species."name"
order by count(visits.animal_id ) desc limit 1;


-- EXPLAIN ANALYZE

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4; 
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';