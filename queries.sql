SELECT full_name as "Owner", name as "Animal Name"
FROM animals
JOIN owners
ON animals.owner_id = owners.id;

SELECT species.name as "Species", animals.name as "Animal"
FROM animals
JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT full_name as "Owner", name as "Animal Name"
FROM owners
LEFT JOIN animals
ON owners.id = animals.owner_id;

SELECT species.name as "Species", COUNT(animals.name) as "Number of Animals"
FROM species
JOIN animals
ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name as "Animal Name", owners.full_name as "Owner"
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell';

SELECT animals.name as "Animal Name", owners.full_name as "Owner"
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0; 

SELECT owners.full_name as "Owners", COUNT(animals.name) as "Number of Animals"
FROM owners
JOIN animals
ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY "Number of Animals" DESC LIMIT 1;

-- New Queries

-- Who was the last animal seen by William Tatcher?
SELECT vets.name as "Veterinary", animals.name as "Animal",
visits.date_of_visit as "Last Visit"
FROM vets
JOIN visits
ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT animals.name as "Animals", vets.name as "Veterinary"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets 
ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY animals.name, vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name as "Veterinaries", species.name as "Specialty"
FROM vets
FULL JOIN specializations
ON vets.id = specializations.vet_id
FULL JOIN species
ON specializations.specie_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name as "Animals", vets.name as "Veterinary", visits.date_of_visit as "Visit Date"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets 
ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '20200401' AND '20200830'; 

-- What animal has the most visits to vets?

SELECT animals.name as "Animals", COUNT(visits.date_of_visit) as "Number of Visits"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY "Number of Visits" DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT vets.name as "Veterinary", animals.name as "Animal",
visits.date_of_visit as "First Visit"
FROM vets
JOIN visits
ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT 
  animals.id as "Animal Id",
  animals.name as "Animal",
  animals.date_of_birth as "Date of Birth",
  animals.escape_attempts as "Escape Attempts",
  animals.neutered as "Animal is Neutered?",
  animals.weigth_kg as "Animal Weight", 
  vets.id as "Vet Id",
  vets.name as "Veterinary",
  vets.age as "Vet Age",
  vets.date_of_graduation as "Vet Graduation Date", 
  visits.date_of_visit as "Date of Visit"
FROM vets
JOIN visits
ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.id
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(visits.date_of_visit) as "Visits were the vet was not specialized in the animal"
FROM animals
LEFT JOIN visits
ON animals.id = visits.animal_id
JOIN vets 
ON visits.vet_id = vets.id
FULL JOIN specializations 
ON vets.id = specializations.vet_id
FULL JOIN species 
ON specializations.specie_id = species.id
WHERE specializations.specie_id != animals.species_id and vets.name != 'Stephanie Mendez' or vets.name = 'Maisy Smith';


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT count(sp.name) AS "How many calls?",
		sp.name as "Specialty Suggestion:",
		ve.name as "Vet Looking for specialty"
FROM animals an
JOIN owners AS ow ON (an.owner_id = ow.id)
JOIN species AS sp ON (sp.id = an.species_id)
JOIN visits AS vi ON (vi.animal_id = an.id)
JOIN vets AS ve ON (ve.id = vi.vet_id)
left join specializations as spec on (spec.vet_id = ve.id)
WHERE spec.vet_id is null
group by sp.name, ve.name
limit 1;

-- EXPLAIN ANALYZE BEFORE OPTIMIZATION;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

-- OPTIMIZATION
CREATE INDEX animal_idx ON visits (animal_id);
CREATE INDEX vet_id_idx ON visits (vet_id);
CREATE INDEX email_idx ON owners (email);


-- EXPLAIN ANALYZE AFTER OPTIMIZATION;
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT vet_id, animal_id, date_of_visit FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

