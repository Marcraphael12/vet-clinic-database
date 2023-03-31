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

-- insert the following data for vets:

insert into vets (name,age,date_of_graduation)
values
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
('William Tatcher',45,'2000-04-23'),

-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
('Maisy Smith',26,'2019-01-17'),

-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
('Stephanie Mendez',64,'1981-05-04'),

-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
('Jack Harkness',38,'2008-06-08');

select * from vets;

-- insert the following data for specialties:

insert into specializations (vets_id,species_id) values
-- Vet William Tatcher is specialized in Pokemon.
((select id from vets where name = 'William Tatcher'),(select id from species where name='Pokemon')),

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
((select id from vets where name = 'Stephanie Mendez'),(select id from species where name='Pokemon')),
((select id from vets where name = 'Stephanie Mendez'),(select id from species where name ='Digimon')),

-- Vet Jack Harkness is specialized in Digimon.
((select id from vets where name = 'Jack Harkness'),(select id from species where name='Digimon'));

select * from specializations;

-- insert the following data for visits:

insert into visists values
-- Agumon visited William Tatcher on May 24th, 2020.
  ((select id from vets where name = 'William Tatcher'), (select id from animals where name = 'Agumon'), 'May 24, 2020'),

-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
  ((select id from vets where name = 'Stephanie Mendez'), (select id from animals where name = 'Agumon'), 'Jul 22, 2020'),

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
  ((select id from vets where name = 'Jack Harkness'), (select id from animals where name = 'Gabumon'), 'Feb 2, 2021'),

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Pikachu'), 'Jan 5, 2020'),

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Pikachu'), 'Mar 8, 2020'),

-- Pikachu visited Maisy Smith on May 14th, 2020.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Pikachu'), 'May 14, 2020'),

-- Devimon visited Stephanie Mendez on May 4th, 2021.
  ((select id from vets where name = 'Stephanie Mendez'), (select id from animals where name = 'Devimon'), 'May 4, 2021'),

-- Charmander visited Jack Harkness on Feb 24th, 2021.
  ((select id from vets where name = 'Jack Harkness'), (select id from animals where name = 'Charmander'), 'Feb 24, 2021'),

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Plantmon'), 'Dec 21, 2019'),

-- Plantmon visited William Tatcher on Aug 10th, 2020.
  ((select id from vets where name = 'William Tatcher'), (select id from animals where name = 'Plantmon'), 'Aug 10, 2020'),

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Plantmon'), 'Apr 7, 2021'),

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
  ((select id from vets where name = 'Stephanie Mendez'), (select id from animals where name = 'Squirtle'), 'Sep 29, 2019'),

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
  ((select id from vets where name = 'Jack Harkness'), (select id from animals where name = 'Angemon'), 'Oct 3, 2020'),

-- Angemon visited Jack Harkness on Nov 4th, 2020.
  ((select id from vets where name = 'Jack Harkness'), (select id from animals where name = 'Angemon'), 'Nov 4, 2020'),

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Boarmon'), 'Jan 24, 2019'),

-- Boarmon visited Maisy Smith on May 15th, 2019.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Boarmon'), 'May 15, 2019'),

-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Boarmon'), 'Feb 27, 2020'),

-- Boarmon visited Maisy Smith on Feb 27th, 2020.
  ((select id from vets where name = 'Maisy Smith'), (select id from animals where name = 'Boarmon'), 'Aug 3, 2020'),

-- Blossom visited Stephanie Mendez on May 24th, 2020.
  ((select id from vets where name = 'Stephanie Mendez'), (select id from animals where name = 'Blossom'), 'May 24, 2020'),

-- Blossom visited William Tatcher on Jan 11th, 2021.
  ((select id from vets where name = 'William Tatcher'), (select id from animals where name = 'Blossom'), 'Jan 11, 2021');

select * from visists;
