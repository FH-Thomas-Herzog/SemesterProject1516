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
  `id` INT NOT NULL AUTO_INCREMENT,
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `firstname` VARCHAR(100) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `username` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `modification_user_id` INT NULL,
  `creation_user_id` INT NULL,
  `version` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ID_UNIQUE` (`id` ASC),
  UNIQUE INDEX `USERNAME_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_USER_USER1_idx` (`creation_user_id` ASC),
  INDEX `fk_USER_USER2_idx` (`modification_user_id` ASC),
  CONSTRAINT `fk_USER_USER1`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_USER2`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UFO`.`ARTIST_CATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`ARTIST_CATEGORY` ;

CREATE TABLE IF NOT EXISTS `UFO`.`ARTIST_CATEGORY` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL,
  `version` INT NOT NULL DEFAULT 1,
  `creation_user_id` INT NOT NULL,
  `modification_user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `modification_user_id`),
  INDEX `fk_ART_CATEGORY_USER1_idx` (`creation_user_id` ASC),
  INDEX `fk_ART_CATEGORY_USER2_idx` (`modification_user_id` ASC),
  CONSTRAINT `fk_ART_CATEGORY_USER1`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ART_CATEGORY_USER2`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UFO`.`ARTIST_GROUP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`ARTIST_GROUP` ;

CREATE TABLE IF NOT EXISTS `UFO`.`ARTIST_GROUP` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(255) NULL,
  `version` INT NOT NULL DEFAULT 1,
  `creation_user_id` INT NOT NULL,
  `modification_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ARTIST_GROUP_USER1_idx` (`creation_user_id` ASC),
  INDEX `fk_ARTIST_GROUP_USER2_idx` (`modification_user_id` ASC),
  CONSTRAINT `fk_ARTIST_GROUP_USER1`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTIST_GROUP_USER2`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UFO`.`ARTIST`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`ARTIST` ;

CREATE TABLE IF NOT EXISTS `UFO`.`ARTIST` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `firstname` VARCHAR(100) NOT NULL,
  `lastname` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `country_code` VARCHAR(10) NOT NULL,
  `version` INT NOT NULL DEFAULT 1,
  `artist_category_id` INT NOT NULL,
  `artist_group_id` INT NOT NULL,
  `creation_user_id` INT NOT NULL,
  `modification_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ARTIST_ART_CATEGORY_idx` (`artist_category_id` ASC),
  INDEX `fk_ARTIST_ARTIST_CATEGORY1_idx` (`artist_group_id` ASC),
  INDEX `fk_ARTIST_USER1_idx` (`creation_user_id` ASC),
  INDEX `fk_ARTIST_USER2_idx` (`modification_user_id` ASC),
  CONSTRAINT `fk_ARTIST_ART_CATEGORY`
    FOREIGN KEY (`artist_category_id`)
    REFERENCES `UFO`.`ARTIST_CATEGORY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTIST_ARTIST_CATEGORY1`
    FOREIGN KEY (`artist_group_id`)
    REFERENCES `UFO`.`ARTIST_GROUP` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTIST_USER1`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTIST_USER2`
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL,
  `street` VARCHAR(100) NOT NULL,
  `zip` VARCHAR(100) NOT NULL,
  `country_code` VARCHAR(10) NOT NULL,
  `gps_coordinate` VARCHAR(255) NULL,
  `version` INT NOT NULL DEFAULT 1,
  `creation_user_id` INT NOT NULL,
  `modification_user_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_VENUE_USER1_idx` (`creation_user_id` ASC),
  INDEX `fk_VENUE_USER2_idx` (`modification_user_id` ASC),
  INDEX `fk_VENUE_ARTIST1_idx` (`artist_id` ASC),
  CONSTRAINT `fk_VENUE_USER1`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENUE_USER2`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENUE_ARTIST1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `UFO`.`ARTIST` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UFO`.`PERFORMANCE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UFO`.`PERFORMANCE` ;

CREATE TABLE IF NOT EXISTS `UFO`.`PERFORMANCE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `creation_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `modification_date` TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `artist_id` INT NOT NULL,
  `venue_id` INT NOT NULL,
  `creation_user_id` INT NOT NULL,
  `modification_user_id` INT NOT NULL,
  `version` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_PERFORMANCE_ARTIST1_idx` (`artist_id` ASC),
  INDEX `fk_PERFORMANCE_VENUE1_idx` (`venue_id` ASC),
  INDEX `fk_PERFORMANCE_USER1_idx` (`creation_user_id` ASC),
  INDEX `fk_PERFORMANCE_USER2_idx` (`modification_user_id` ASC),
  CONSTRAINT `fk_PERFORMANCE_ARTIST1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `UFO`.`ARTIST` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERFORMANCE_VENUE1`
    FOREIGN KEY (`venue_id`)
    REFERENCES `UFO`.`VENUE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERFORMANCE_USER1`
    FOREIGN KEY (`creation_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERFORMANCE_USER2`
    FOREIGN KEY (`modification_user_id`)
    REFERENCES `UFO`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
