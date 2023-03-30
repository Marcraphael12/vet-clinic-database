-- Inserting datas relative to each animals

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
-- Animal: Name, Date of birth, Escape attempts, neutered, weight_kg
	('Agumon', '2020-02-03', 0, true, 10.23),
	('Gabumon', '2018-11-15', 2, true, 8.0),
	('Pikachu', '2021-01-07', 1, false, 15.04),
	('Devimon', '2017-05-12', 5, true, 11.0),
	('Charmander', '2020-02-08', 0, false, -11.00),
	('Plantmon', '2021-11-15', 2, true, -5.7),
	('Squirtle', '1993-04-02', 3, false, -12.13),
	('Angemon', '2005-06-12', 1, true, -45.00),
	('Boarmon', '2005-06-07', 7, true, 20.4),
	('Blossom', '1998-10-13', 3, true, 17.0),
	('Ditto', '2022-05-14', 4, true, 22.0);

-- update the owners table
insert into owners (full_name, age) values
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

-- update the species table
insert into species (name) values
	('Pokemon'),
	('Digimon');

-- Modify the inserted animals so it includes the species_id value
-- If the name ends in "mon" it will be Digimon
update animals 
set species_id = (select id from species where name = 'Digimon')
where name like '%mon';

-- All other animals are Pokemon
update animals
set species_id = (select id from species where name = 'Pokemon')
where species_id is NULL;

-- Modify the inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
update animals
set owner_id = (select owners_id from owners where full_name = 'Sam Smith') where name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
update animals
set owner_id = (select owners_id from owners where full_name = 'Jennifer Orwell') where name = 'Gabumon' or name = 'Pikachu';

-- Bob owns Devimon and Plantmon.
update animals
set owner_id = (select owners_id from owners where full_name = 'Bob') where name = 'Devimon' or name = 'Plantmon';

-- Melody Pond owns Charmander, Squirtle, and Blossom.
update animals
set owner_id = (select owners_id from owners where full_name = 'Melody Pond') where name = 'Charmander' or name = 'Squirtle' or name = 'Blossom';

-- Dean Winchester owns Angemon and Boarmon.
update animals
set owner_id = (select owners_id from owners where full_name = 'Dean Winchester') where name = 'Angemon' or name = 'Boarmon';
