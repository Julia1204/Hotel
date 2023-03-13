-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hotel-BD1-projekt
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotel-BD1-projekt
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotel-BD1-projekt` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema hotel-bd1-projekt
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotel-bd1-projekt
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotel-bd1-projekt` ;
USE `hotel-BD1-projekt` ;

-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Cennik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Cennik` (
  `id_oferty` INT NOT NULL,
  `klasa_pokoju` INT NOT NULL,
  `posilek` VARCHAR(20) NOT NULL,
  `cena` FLOAT NOT NULL,
  PRIMARY KEY (`id_oferty`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 20;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Personel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Personel` (
  `id_personelu` INT NOT NULL,
  `imie` VARCHAR(20) NOT NULL,
  `nazwisko` VARCHAR(20) NOT NULL,
  `stanowisko` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_personelu`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 50;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Frekwencja_personelu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Frekwencja_personelu` (
  `id_frekwencja_personelu` INT NOT NULL,
  `id_personelu` INT NOT NULL,
  `data` DATE NOT NULL,
  `obecnosc` CHAR(1) NOT NULL,
  PRIMARY KEY (`id_frekwencja_personelu`),
  INDEX `id_personelu_idx` (`id_personelu` ASC) VISIBLE,
  CONSTRAINT `id_personelu`
    FOREIGN KEY (`id_personelu`)
    REFERENCES `hotel-BD1-projekt`.`Personel` (`id_personelu`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 18250;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Gosc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Gosc` (
  `id_goscia` INT NOT NULL,
  `imie` VARCHAR(20) NOT NULL,
  `nazwisko` VARCHAR(20) NOT NULL,
  `pesel` VARCHAR(11) NOT NULL,
  `nr_telefonu` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_goscia`),
  UNIQUE INDEX `id_goscia_UNIQUE` (`id_goscia` ASC) VISIBLE,
  UNIQUE INDEX `pesel_UNIQUE` (`pesel` ASC) VISIBLE,
  UNIQUE INDEX `nr_telefonu_UNIQUE` (`nr_telefonu` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 5000;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Kalendarz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Kalendarz` (
  `id_kalendarz` INT NOT NULL AUTO_INCREMENT,
  `id_goscia` INT NOT NULL,
  `termin_zameldowania` DATE NULL DEFAULT NULL,
  `termin_wymeldowania` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_kalendarz`),
  INDEX `id_goscia_idx` (`id_goscia` ASC) VISIBLE,
  CONSTRAINT `id_goscia`
    FOREIGN KEY (`id_goscia`)
    REFERENCES `hotel-BD1-projekt`.`Gosc` (`id_goscia`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 5000;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Ksiegowosc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Ksiegowosc` (
  `id_goscia` INT NOT NULL,
  `przychody` FLOAT NOT NULL,
  `termin_wplaty` DATE NOT NULL,
  PRIMARY KEY (`id_goscia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 5000;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Lista_gosci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Lista_gosci` (
  `id_lista_gosci` INT NOT NULL AUTO_INCREMENT,
  `id_goscia` INT NOT NULL,
  `id_oferty` INT NOT NULL,
  `id_pakietu` INT NOT NULL,
  `nr_pokoju` INT NOT NULL,
  PRIMARY KEY (`id_lista_gosci`),
  INDEX `id_goscia_idx` (`id_goscia` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 200;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Opinie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Opinie` (
  `id_opinia` INT NOT NULL,
  `id_goscia` INT NULL DEFAULT NULL,
  `opinia` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_opinia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 2000;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Pakiety`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Pakiety` (
  `id_pakietu` INT NOT NULL,
  `oferta_pakietu` VARCHAR(30) NOT NULL,
  `cena_pakietu` FLOAT NOT NULL,
  PRIMARY KEY (`id_pakietu`),
  UNIQUE INDEX `id_pakietu_UNIQUE` (`id_pakietu` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 20;


-- -----------------------------------------------------
-- Table `hotel-BD1-projekt`.`Pokoje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-BD1-projekt`.`Pokoje` (
  `nr_pokoju` INT NOT NULL,
  `klasa_pokoju` INT NOT NULL,
  `ilosc_osob` INT NOT NULL,
  `dostepnosc` CHAR(3) NOT NULL,
  PRIMARY KEY (`nr_pokoju`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
MAX_ROWS = 200;

USE `hotel-bd1-projekt` ;
USE `hotel-BD1-projekt` ;

-- -----------------------------------------------------
-- function function_zlicz_cena
-- -----------------------------------------------------

DELIMITER $$
USE `hotel-BD1-projekt`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `function_zlicz_cena`(id INT, data_zameldowania DATE, data_wymeldowania DATE) RETURNS float
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE ilosc_dni INT;
DECLARE  cena_dod, cena_podst FLOAT;

SET ilosc_dni = (SELECT DATEDIFF(data_wymeldowania,data_zameldowania));

SET cena_podst = (SELECT cena FROM CENNIK 
			WHERE id_oferty = (SELECT id_oferty
								FROM Lista_gosci 
								WHERE id_goscia = id))*ilosc_dni;
                                
SET cena_dod = (SELECT cena_pakietu FROM Pakiety
			WHERE id_pakietu = (SELECT id_pakietu
								FROM Lista_gosci 
								WHERE id_goscia = id))*ilosc_dni;
RETURN cena_podst+cena_dod;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function function_zlicz_gosci
-- -----------------------------------------------------

DELIMITER $$
USE `hotel-BD1-projekt`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `function_zlicz_gosci`(czy_wolny VARCHAR(3)) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE wynik INT;
SET wynik = (SELECT SUM(ilosc_osob) FROM Pokoje WHERE dostepnosc=czy_wolny);
RETURN wynik;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function function_zlicz_pokoje
-- -----------------------------------------------------

DELIMITER $$
USE `hotel-BD1-projekt`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `function_zlicz_pokoje`(czy_wolny VARCHAR(3)) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE wynik INT;
SET wynik = (SELECT COUNT(nr_pokoju) FROM Pokoje WHERE dostepnosc=czy_wolny);
RETURN wynik;
END$$

DELIMITER ;
USE `hotel-bd1-projekt` ;

-- -----------------------------------------------------
-- Placeholder table for view `hotel-bd1-projekt`.`view_dane_goscia?`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-bd1-projekt`.`view_dane_goscia?` (`id_goscia` INT, `id_oferty` INT, `id_pakietu` INT, `nr_pokoju` INT, `imie` INT, `nazwisko` INT, `pesel` INT, `nr_telefonu` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hotel-bd1-projekt`.`view_dostepne_pokoje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-bd1-projekt`.`view_dostepne_pokoje` (`nr_pokoju` INT, `klasa_pokoju` INT, `ilosc_osob` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hotel-bd1-projekt`.`view_lista_gosci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-bd1-projekt`.`view_lista_gosci` (`imie` INT, `nazwisko` INT, `nr_pokoju` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hotel-bd1-projekt`.`view_lista_obecnosci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel-bd1-projekt`.`view_lista_obecnosci` (`imie` INT, `nazwisko` INT, `stanowisko` INT, `data` INT, `obecnosc` INT);

-- -----------------------------------------------------
-- View `hotel-bd1-projekt`.`view_dane_goscia?`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel-bd1-projekt`.`view_dane_goscia?`;
USE `hotel-bd1-projekt`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hotel-bd1-projekt`.`view_dane_goscia?` AS select `hotel-bd1-projekt`.`lista_gosci`.`id_goscia` AS `id_goscia`,`hotel-bd1-projekt`.`lista_gosci`.`id_oferty` AS `id_oferty`,`hotel-bd1-projekt`.`lista_gosci`.`id_pakietu` AS `id_pakietu`,`hotel-bd1-projekt`.`lista_gosci`.`nr_pokoju` AS `nr_pokoju`,`hotel-bd1-projekt`.`gosc`.`imie` AS `imie`,`hotel-bd1-projekt`.`gosc`.`nazwisko` AS `nazwisko`,`hotel-bd1-projekt`.`gosc`.`pesel` AS `pesel`,`hotel-bd1-projekt`.`gosc`.`nr_telefonu` AS `nr_telefonu` from (`hotel-bd1-projekt`.`lista_gosci` join `hotel-bd1-projekt`.`gosc` on((`hotel-bd1-projekt`.`lista_gosci`.`id_goscia` = `hotel-bd1-projekt`.`gosc`.`id_goscia`))) where (`hotel-bd1-projekt`.`lista_gosci`.`id_goscia` = 1);

-- -----------------------------------------------------
-- View `hotel-bd1-projekt`.`view_dostepne_pokoje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel-bd1-projekt`.`view_dostepne_pokoje`;
USE `hotel-bd1-projekt`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hotel-bd1-projekt`.`view_dostepne_pokoje` AS select `hotel-bd1-projekt`.`pokoje`.`nr_pokoju` AS `nr_pokoju`,`hotel-bd1-projekt`.`pokoje`.`klasa_pokoju` AS `klasa_pokoju`,`hotel-bd1-projekt`.`pokoje`.`ilosc_osob` AS `ilosc_osob` from `hotel-bd1-projekt`.`pokoje` where (`hotel-bd1-projekt`.`pokoje`.`dostepnosc` = 'tak') order by `hotel-bd1-projekt`.`pokoje`.`klasa_pokoju`;

-- -----------------------------------------------------
-- View `hotel-bd1-projekt`.`view_lista_gosci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel-bd1-projekt`.`view_lista_gosci`;
USE `hotel-bd1-projekt`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hotel-bd1-projekt`.`view_lista_gosci` AS select `g`.`imie` AS `imie`,`g`.`nazwisko` AS `nazwisko`,`lg`.`nr_pokoju` AS `nr_pokoju` from (`hotel-bd1-projekt`.`gosc` `g` join `hotel-bd1-projekt`.`lista_gosci` `lg` on((`g`.`id_goscia` = `lg`.`id_goscia`)));

-- -----------------------------------------------------
-- View `hotel-bd1-projekt`.`view_lista_obecnosci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel-bd1-projekt`.`view_lista_obecnosci`;
USE `hotel-bd1-projekt`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hotel-bd1-projekt`.`view_lista_obecnosci` AS select `p`.`imie` AS `imie`,`p`.`nazwisko` AS `nazwisko`,`p`.`stanowisko` AS `stanowisko`,`f`.`data` AS `data`,`f`.`obecnosc` AS `obecnosc` from (`hotel-bd1-projekt`.`personel` `p` join `hotel-bd1-projekt`.`frekwencja_personelu` `f` on((`p`.`id_personelu` = `f`.`id_personelu`)));
USE `hotel-BD1-projekt`;

DELIMITER $$
USE `hotel-BD1-projekt`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `hotel-BD1-projekt`.`Dodanie_nowego_goscia_hotelowego`
AFTER INSERT ON `hotel-BD1-projekt`.`Lista_gosci`
FOR EACH ROW
BEGIN
UPDATE Pokoje SET dostepnosc='nie'
WHERE nr_pokoju=new.nr_pokoju;
INSERT INTO Kalendarz VALUES( DEFAULT, new.id_goscia, CURRENT_DATE(), DEFAULT);
END$$

USE `hotel-BD1-projekt`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `hotel-BD1-projekt`.`trigger_after_delete_wymeldowanie`
AFTER DELETE ON `hotel-BD1-projekt`.`Lista_gosci`
FOR EACH ROW
BEGIN
UPDATE Pokoje SET dostepnosc='tak'
WHERE nr_pokoju = old.nr_pokoju;
UPDATE Kalendarz SET termin_wymeldowania = CURRENT_DATE()
WHERE id_goscia = old.id_goscia AND Kalendarz.termin_wymeldowania IS null;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
