/* Populate database with sample data. */

insert into animals values (default, 'Agumon', '20200203', 0, true, 10.23, CURRENT_USER, now() ); 
insert into animals values (default, 'Gabumon', '20181115', 2, true, 8.00, CURRENT_USER, now() );
insert into animals values (default, 'Pikachu', '20210107', 1, false, 15.04, CURRENT_USER, now() );
insert into animals values (default, 'Devimon', '20170512', 5, true, 8.00, CURRENT_USER, now() );

----- PART 2
INSERT INTO public.animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Charmander', 'FEB-08-2020', 0, FALSE, -11);

INSERT INTO public.animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Plantmon', 'NOV-15-2022', 2, TRUE, -5.7);

INSERT INTO public.animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Squirtle', 'APR-02-1993', 3, FALSE, -12.13);

INSERT INTO public.animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Angemon', 'JUN-12-2005', 1, TRUE, -45);

INSERT INTO public.animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Boarmon', 'JUN-07-2005', 7, TRUE, 20.04);

INSERT INTO public.animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Blossom', 'OCT-13-1998', 3, TRUE, 17);
