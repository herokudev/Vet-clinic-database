/* Populate database with sample data. */

insert into animals values (default, 'Agumon', '20200203', 0, true, 10.23, CURRENT_USER, now() ); 
insert into animals values (default, 'Gabumon', '20181115', 2, true, 8.00, CURRENT_USER, now() );
insert into animals values (default, 'Pikachu', '20210107', 1, false, 15.04, CURRENT_USER, now() );
insert into animals values (default, 'Devimon', '20170512', 5, true, 8.00, CURRENT_USER, now() );

