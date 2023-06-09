-- Queries that provide answers to the questions from all projects.

-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name like '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weight more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

--Find all animals that are neutered.
SELECT name FROM animals where neutered = true;

-- Find all animals not named Gabumon.
SELECT name FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT name FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified
UPDATE animals 
SET species = 'unspecified';

-- roll back the change and verify that the species columns went back to the state before the transaction
SELECT name, species 
FROM animals;
ROLLBACK;

--Inside a transaction Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals 
SET species = 'digimon' 
WHERE name LIKE '%mon';

--Inside a transaction Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals 
SET species = 'pokemon'
WHERE species = 'unspecified';

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
DELETE 
FROM animals;
ROLLBACK;

-- Inside a transaction Delete all animals born after Jan 1st, 2022.
begin;
delete from animals where date_of_birth > '01-01-2022';

-- Create a savepoint for the transaction.
SAVEPOINT sp1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
rollback to SP1

-- Commit transaction
commit

-- Write queriesd to answer the following questions:
-- How many animals are there?
select count(*) as number_of_animals from animals;

-- How many animals have never tried to escape?
select count(*) as animals_never_escaped from animals
where escape_attempts = 0; 

-- What is the average weight of animals?
select avg(weight_kg) as average_weight from animals;

-- Who escapes the most, neutered or not neutered animals?
select count(escape_attempts)as escape_attempts, neutered from animals
group by (neutered);

-- What is the minimum and maximum weight of each type of animal?
select min(weight_kg) as minimal_weight, max(weight_kg) as max_weight, species from animals
group by(species);

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
select avg(escape_attempts) as average_attempts, species from animals
where date_of_birth between '01-01-1990' and '31-12-2000'
group by(species)

-- Write queries (using JOIN) to answer the following questions:

-- What animals belong to Melody Pond?
select name as Melody_pond_animals from animals
join owners on owners.full_name = 'Melody Pond' and animals.owner_id = owners.owners_id;

-- List of all animals that are pokemon (their type is Pokemon).
select * from animals
join species on species.name = 'Pokemon' and species.id = animals.species_id;

-- List all owners and their animals, remember to include those that don't own any animal.
select owners.full_name as owner_name, animals.name as animal_name from owners
join animals on owners.owners_id = animals.owner_id;

-- How many animals are there per species?
select count(*) as nuber_of_animals, species.name as species from animals
join species on animals.species_id = species.id group by species.id;

-- List all Digimon owned by Jennifer Orwell.
select animals.name, animals.id, owners.full_name from animals
join owners on animals.owner_id = owners.owners_id
and owners.full_name = 'Jennifer Orwell' and animals.species_id=(select id from species where name='Digimon');

-- List all animals owned by Dean Winchester that haven't tried to escape.
select animals.name, owners.full_name, animals.escape_attempts from animals
join owners on animals.owner_id = owners.owners_id
and owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;

-- Who owns the most animals?
select count(*) as number_of_animals, owners.full_name from animals
join owners on animals.owner_id = owners.owners_id
group by owners.full_name order by count(*) desc;

-- Who was the last animal seen by William Tatcher?
select animals.name, vets.name , date_of_visit from visists
inner join animals on visists.id = animals.id
inner join vets on vets.id = (select id from vets where name ='William Tatcher')
and visists.vets_id = vets.id
order by date_of_visit desc

-- How many different animals did Stephanie Mendez see?
select animals.name , vets.name from visists
inner join vets on vets.id = visists.vets_id
inner join animals on vets.id = (select id from vets where name ='Stephanie Mendez') 
and animals.id = visists.id;

-- List all vets and their specialties, including vets with no specialties.
select vets.name as vets_name, species.name as species from specializations 
join vets on vets.id = specializations.vets_id
join species on species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
select animals.name as animal_nam , vets.name as vets_name from visists 
inner join vets on vets.id = visists.vets_id 
and date_of_visit  >= 'Apr1,2020' and date_of_visit <= 'Aug30,2020'
inner join animals on animals.id = visists.id 
and vets.id = (select id from vets where vets.name = 'Stephanie Mendez');

-- What animal has the most visists to vets?
select animals.name as animals_name , count(animals.id) as number_of_visit from visists 
inner join vets on vets.id = visists.vets_id 
inner join animals on animals.id = visists.id 
group by animals.name
order by count(animals.id) desc;

-- Who was Maisy Smith's first visit?
select animals.name as animal_name , date_of_visit as date_of_visit from visists 
inner join vets on vets.id = visists.vets_id 
inner join animals on animals.id = visists.id and vets.name ='Maisy Smith'
order by date_of_visit;

-- Details for most recent visit: animal information, vet information, and date of visit.
select * from visists 
full join vets on vets.id = visists.vets_id 
full join animals on animals.id = visists.id 
order by  date_of_visit desc;

-- How many visists were with a vet that did not specialize in that animal's species?
select count(*) as number_of_visits from vets
join visists on visists.vets_id = vets.id
join animals on visists.id = animals.id
join specializations on vets.id = specializations.vets_id
where specializations.species_id != animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
select species.name as species from animals
join species on species.id = animals.species_id
join visists on visists.id = animals.id
join vets on vets.id = visists.vets_id and vets.name = 'Maisy Smith'
group by species.name
order by count(species.id) desc
