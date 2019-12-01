CREATE DATABASE db01; -- To create 'db01' database

USE db01; -- To set as default database of 'db01' database

SHOW DATABASES; -- To show all database in schemas

SHOW CHAR SET; -- To show all character set (字元集)

SHOW COLLATION LIKE '%big5%'; -- To show all character set in big 5 (big 5之字元集)

ALTER DATABASE db02
CHARACTER SET big5
COLLATE big5_bin; -- To modify character set and collation of 'db02' database 

SELECT @@character_set_database, @@collation_database; -- To show caracter set of database which in using

DROP DATABASE db02; -- To delete 'db02' database in schemas

