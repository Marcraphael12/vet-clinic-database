/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	name varchar(100) NOT NULL,
	date_of_birth date NOT NULL,
	escape_attempts INT NOT NULL,
	neutered boolean NOT NULL,
	weight_kg decimal NOT NULL,
	species varchar(50) NOT NULL,
	PRIMARY KEY (id)
);

create table owners (
	owners_id INT primary key generated always as identity,
	full_name varchar(100) ,
	age INT
);

create table species (
	id INT primary key generated always as identity,
	name varchar(100)
);

-- Remove column species
alter table animals drop column species;

-- Add column species_id which is a foreign key referencing species table
alter table animals add species_id int references species(id);

-- Add column owner_id which is a foreign key referencing the owners table
alter table animals add owner_id int references owners(owners_id);

create table vets (
	id int primary key generated always as identity,
	name varchar(100) ,
	age int,
	date_of_graduation date
);

-- There is a many-to-many relationship between the tables species and vets:
-- Create a "join table" called specializations to handle this relationship
create table specializations (
	vets_id int references vets(id) on delete cascade on update cascade,
	species_id int references species(id) on delete cascade on update cascade 
);

-- There is a many-to-many relationship between the tables animals and vets
-- Create a "join table" called visits to handle this relationship
create table visists (
	vets_id int references vets(id) on delete cascade on update cascade,
	id int references animals(id) on delete cascade on update cascade,
	date_of_visit date
);

-- Add an email column to your owners table
alter table owners add column email varchar(120);

create index vet_index on visists(vets_id);
create index visits_index on visists(id);
create index owner_index on owners(email asc);
