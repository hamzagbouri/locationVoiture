CREATE DATABASE location_voiture;
use location_voiture;

-- Create table Personne
CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) ,
    fullName VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(50)
);
-- Create table Category
CREATE TABLE Category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255)
);

-- Create table Car
CREATE TABLE Car (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marque VARCHAR(255),
    modele VARCHAR(255),
    annee INT,
    prix FLOAT,
    disponibilite BOOLEAN,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(id)
);


CREATE TABLE Reservation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_debut DATE,
    date_fin DATE,
    lieu VARCHAR(255),
    client_id INT,
    car_id INT,
    FOREIGN KEY (client_id) REFERENCES User(id),
    FOREIGN KEY (car_id) REFERENCES Car(id)
);
-- Create table Avis
CREATE TABLE Avis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    avis TEXT,
    reservation_id int,
    FOREIGN KEY (reservation_id) REFERENCES Reservation(id)
);
ALTER TABLE Avis ADD COLUMN stars TINYINT CHECK (stars BETWEEN 1 AND 5);
ALTER TABLE Avis ADD COLUMN archive BOOLEAN DEFAULT FALSE;
ALTER TABLE Car ADD COLUMN image_path VARCHAR(255);

CREATE VIEW CarsView AS
SELECT c.id as car_id, c.image_path, c.modele,c.marque,c.annee,c.prix,cat.nom 
FROM Car c
JOIN category cat ON c.category_id = cat.id;
DELIMITER //

CREATE PROCEDURE AjouterReservation(
    IN p_date_debut DATE,
    IN p_date_fin DATE,
    IN p_lieu VARCHAR(255),
    IN p_client_id INT,
    IN p_car_id INT
)
BEGIN
    INSERT INTO Reservation (date_debut, date_fin, lieu, client_id, car_id)
    VALUES (p_date_debut, p_date_fin, p_lieu, p_client_id, p_car_id);
END //

DELIMITER ;