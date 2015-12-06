-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema UFO
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `UFO` ;

-- -----------------------------------------------------
-- Schema UFO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `UFO` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `UFO` ;

-- -----------------------------------------------------
-- Table `UFO`.`USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`USER` ;

CREATE TABLE IF NOT EXISTS `UFO`.`USER` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `firstname` VARCHAR(100) NOT NULL COMMENT '',
  `lastname` VARCHAR(100) NOT NULL COMMENT '',
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `username` VARCHAR(100) NOT NULL COMMENT '',
  `password` VARCHAR(1024) NOT NULL COMMENT '',
  `email` VARCHAR(100) NOT NULL COMMENT '',
  `user_type` INT NOT NULL COMMENT '',
  `modification_user_id` INT NULL COMMENT '',
  `creation_user_id` INT NULL COMMENT '',
  `version` INT NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `IDX_UNIQUE_USER_ID` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `IDX_UNIQUE_USER_USERNAME` (`username` ASC)  COMMENT '',
  UNIQUE INDEX `IDX_UNIQUE_USER_EMAIL` (`email` ASC)  COMMENT '',
  INDEX `IDX_FK_USER_CREATION_USER_ID` (`creation_user_id` ASC)  COMMENT '',
  INDEX `IDX_FK_USER_MODIFICATION_USER_ID` (`modification_user_id` ASC)  COMMENT '',
  CONSTRAINT `FK_USER_CREATION_USER_ID`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_USER_MODIFICATION_USER_ID`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `UFO`.`ARTIST_CATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`ARTIST_CATEGORY` ;

CREATE TABLE IF NOT EXISTS `UFO`.`ARTIST_CATEGORY` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `name` VARCHAR(100) NOT NULL COMMENT '',
  `description` VARCHAR(255) NULL COMMENT '',
  `creation_user_id` INT NOT NULL COMMENT '',
  `modification_user_id` INT NOT NULL COMMENT '',
  `version` INT NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`, `modification_user_id`)  COMMENT '',
  INDEX `IDX_FK_ART_CATEGORY_CREATION_USER_ID` (`creation_user_id` ASC)  COMMENT '',
  INDEX `IDX_FK_ART_CATEGORY_MODIFICATION_USER_ID` (`modification_user_id` ASC)  COMMENT '',
  UNIQUE INDEX `IDX_UNIQUE_ARTIST_CATEGORY_ID` (`id` ASC)  COMMENT '',
  CONSTRAINT `FK_ART_CATEGORY_CREATION_USER_ID`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ART_CATEGORY_MODIFICATION_USER_ID`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `UFO`.`ARTIST_GROUP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`ARTIST_GROUP` ;

CREATE TABLE IF NOT EXISTS `UFO`.`ARTIST_GROUP` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `name` VARCHAR(50) NOT NULL COMMENT '',
  `description` VARCHAR(255) NULL COMMENT '',
  `creation_user_id` INT NOT NULL COMMENT '',
  `modification_user_id` INT NOT NULL COMMENT '',
  `version` INT NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `IDX_FK_ARTIST_GROUP_CREATION_USER_ID` (`creation_user_id` ASC)  COMMENT '',
  INDEX `IDX_FK_ARTIST_GROUP_MODIFICATION_USER_ID` (`modification_user_id` ASC)  COMMENT '',
  CONSTRAINT `FK_ARTIST_GROUP_CREATION_USER_ID`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ARTIST_GROUP_MODIFICATION_USER_ID`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `UFO`.`ARTIST`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`ARTIST` ;

CREATE TABLE IF NOT EXISTS `UFO`.`ARTIST` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `firstname` VARCHAR(100) NOT NULL COMMENT '',
  `lastname` VARCHAR(100) NOT NULL COMMENT '',
  `email` VARCHAR(100) NOT NULL COMMENT '',
  `country_code` VARCHAR(10) NOT NULL COMMENT '',
  `image` VARCHAR(10240) NULL COMMENT '',
  `image_file_type` VARCHAR(10) NULL COMMENT '',
  `url` VARCHAR(500) NULL COMMENT '',
  `creation_user_id` INT NOT NULL COMMENT '',
  `modification_user_id` INT NOT NULL COMMENT '',
  `artist_category_id` INT NOT NULL COMMENT '',
  `artist_group_id` INT NOT NULL COMMENT '',
  `deleted_flag` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '',
  `version` INT NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `IDX_FK_ARTIST_ART_CATEGORY_ID` (`artist_category_id` ASC)  COMMENT '',
  INDEX `IDX_FK_ARTIST_ARTIST_CATEGORY_ID` (`artist_group_id` ASC)  COMMENT '',
  INDEX `IDX_FK_ARTIST_CREATION_USER_ID` (`creation_user_id` ASC)  COMMENT '',
  INDEX `IDX_FK_ARTIST_MODIFICATION_USER_ID` (`modification_user_id` ASC)  COMMENT '',
  CONSTRAINT `FK_ARTIST_ART_CATEGORY_ID`
    FOREIGN KEY (`artist_category_id`)
    REFERENCES `UFO`.`ARTIST_CATEGORY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ARTIST_ARTIST_CATEGORY_ID`
    FOREIGN KEY (`artist_group_id`)
    REFERENCES `UFO`.`ARTIST_GROUP` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ARTIST_CREATION_USER_ID`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ARTIST_MODIFICATION_USER_ID`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UFO`.`VENUE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`VENUE` ;

CREATE TABLE IF NOT EXISTS `UFO`.`VENUE` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `name` VARCHAR(100) NOT NULL COMMENT '',
  `description` VARCHAR(255) NULL COMMENT '',
  `street` VARCHAR(100) NOT NULL COMMENT '',
  `zip` VARCHAR(100) NOT NULL COMMENT '',
  `city` VARCHAR(100) NOT NULL COMMENT '',
  `country_code` VARCHAR(10) NOT NULL COMMENT '',
  `gps_coordinate` VARCHAR(255) NULL COMMENT '',
  `creation_user_id` INT NOT NULL COMMENT '',
  `modification_user_id` INT NOT NULL COMMENT '',
  `version` INT NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `IDX_FK_VENUE_CREATION_USER_ID` (`creation_user_id` ASC)  COMMENT '',
  INDEX `IDX_FK_VENUE_MODIFICATION_USER_ID` (`modification_user_id` ASC)  COMMENT '',
  CONSTRAINT `FK_VENUE_CREATION_USER_ID`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_VENUE_MODIFICATION_USER_ID`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `UFO`.`PERFORMANCE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`PERFORMANCE` ;

CREATE TABLE IF NOT EXISTS `UFO`.`PERFORMANCE` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '',
  `start_date` DATETIME NOT NULL COMMENT '',
  `end_date` DATETIME NOT NULL COMMENT '',
  `creation_user_id` INT NOT NULL COMMENT '',
  `modification_user_id` INT NOT NULL COMMENT '',
  `artist_id` INT NOT NULL COMMENT '',
  `venue_id` INT NOT NULL COMMENT '',
  `version` INT NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `IDX_FK_PERFORMANCE_ARTIST_ID` (`artist_id` ASC)  COMMENT '',
  INDEX `IDX_FK_PERFORMANCE_VENUE_ID` (`venue_id` ASC)  COMMENT '',
  INDEX `IDX_FK_PERFORMANCE_CREATION_USER_ID` (`creation_user_id` ASC)  COMMENT '',
  INDEX `IDX_FK_PERFORMANCE_MODIFICATION_USER_ID` (`modification_user_id` ASC)  COMMENT '',
  UNIQUE INDEX `IDX_UNIQUE_PERFORMANCE_ID` (`id` ASC)  COMMENT '',
  CONSTRAINT `FK_PERFORMANCE_ARTIST_ID`
    FOREIGN KEY (`artist_id`)
    REFERENCES `UFO`.`ARTIST` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PERFORMANCE_VENUE_ID`
    FOREIGN KEY (`venue_id`)
    REFERENCES `UFO`.`VENUE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PERFORMANCE_CREATION_USER_ID`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PERFORMANCE_MODIFICATION_USER_ID`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
ROW_FORMAT = DEFAULT;

USE `UFO`;

DELIMITER $$

USE `UFO`$$
DROP TRIGGER IF EXISTS `UFO`.`USER_BEFORE_UPDATE` $$
USE `UFO`$$
CREATE DEFINER = CURRENT_USER TRIGGER `UFO`.`USER_BEFORE_UPDATE` BEFORE UPDATE ON `USER` FOR EACH ROW
BEGIN
	SET NEW.version = NEW.version + 1, NEW.modification_date = CURRENT_TIMESTAMP;
END
$$


USE `UFO`$$
DROP TRIGGER IF EXISTS `UFO`.`ARTIST_CATEGORY_BEFORE_UPDATE` $$
USE `UFO`$$
CREATE DEFINER = CURRENT_USER TRIGGER `UFO`.`ARTIST_CATEGORY_BEFORE_UPDATE` BEFORE UPDATE ON `ARTIST_CATEGORY` FOR EACH ROW
BEGIN
	SET NEW.version = NEW.version + 1, NEW.modification_date = CURRENT_TIMESTAMP;
END
$$


USE `UFO`$$
DROP TRIGGER IF EXISTS `UFO`.`ARTIST_GROUP_BEFORE_UPDATE` $$
USE `UFO`$$
CREATE DEFINER = CURRENT_USER TRIGGER `UFO`.`ARTIST_GROUP_BEFORE_UPDATE` BEFORE UPDATE ON `ARTIST_GROUP` FOR EACH ROW
BEGIN
	SET NEW.version = NEW.version + 1, NEW.modification_date = CURRENT_TIMESTAMP;
END
$$


USE `UFO`$$
DROP TRIGGER IF EXISTS `UFO`.`ARTIST_BEFORE_UPDATE` $$
USE `UFO`$$
CREATE DEFINER = CURRENT_USER TRIGGER `UFO`.`ARTIST_BEFORE_UPDATE` BEFORE UPDATE ON `ARTIST` FOR EACH ROW
BEGIN
	SET NEW.version = NEW.version + 1, NEW.modification_date = CURRENT_TIMESTAMP;
END
$$


USE `UFO`$$
DROP TRIGGER IF EXISTS `UFO`.`VENUE_BEFORE_UPDATE` $$
USE `UFO`$$
CREATE DEFINER = CURRENT_USER TRIGGER `UFO`.`VENUE_BEFORE_UPDATE` BEFORE UPDATE ON `VENUE` FOR EACH ROW
BEGIN
	SET NEW.version = NEW.version + 1, NEW.modification_date = CURRENT_TIMESTAMP;
END
$$


USE `UFO`$$
DROP TRIGGER IF EXISTS `UFO`.`PERFORMANCE_BEFORE_UPDATE` $$
USE `UFO`$$
CREATE DEFINER = CURRENT_USER TRIGGER `UFO`.`PERFORMANCE_BEFORE_UPDATE` BEFORE UPDATE ON `PERFORMANCE` FOR EACH ROW
BEGIN
	SET NEW.version = NEW.version + 1, NEW.modification_date = CURRENT_TIMESTAMP;
END
$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;