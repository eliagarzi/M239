#Datenbanken erstellen
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE DATABASE roundcube !40101 CHARACTER SET utf8 COLLATE utf8_general_ci;

#Entsprechenden User erstellen 
CREATE USER 'wpadmin'@'%' IDENTIFIED BY 'Abc123#';
CREATE USER 'roundcube'@'%' IDENTIFIED BY 'Abc123#';

#Rechte verteilen
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpadmin'@'%';
GRANT ALL PRIVILEGES ON roundcube TO 'roundcube'@'%';

FLUSH PRIVILEGES;