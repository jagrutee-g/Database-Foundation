-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Project_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Project_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project_db` DEFAULT CHARACTER SET utf8 ;
USE `Project_db` ;

-- -----------------------------------------------------
-- Table `Project_db`.`metro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_db`.`metro` (
  `metro_id` INT NOT NULL,
  `metro` VARCHAR(45) NULL,
  PRIMARY KEY (`metro_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_db`.`county`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_db`.`county` (
  `county_id` INT NOT NULL,
  `county` VARCHAR(45) NULL,
  PRIMARY KEY (`county_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_db`.`city_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_db`.`city_table` (
  `city_id` INT NOT NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `metro_metro_id` INT NULL,
  `county_county_id` INT NULL,
  `rank_ppsq` VARCHAR(45) NULL,
  `rank_price` VARCHAR(45) NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_table_metro_idx` (`metro_metro_id` ASC),
  INDEX `fk_city_table_county1_idx` (`county_county_id` ASC),
  CONSTRAINT `fk_city_table_metro`
    FOREIGN KEY (`metro_metro_id`)
    REFERENCES `Project_db`.`metro` (`metro_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_city_table_county1`
    FOREIGN KEY (`county_county_id`)
    REFERENCES `Project_db`.`county` (`county_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_db`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_db`.`state` (
  `state` INT NOT NULL,
  PRIMARY KEY (`state`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_db`.`price`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_db`.`price` (
  `price_pk` INT NOT NULL,
  `date` VARCHAR(45) NULL,
  `price` VARCHAR(45) NULL,
  `city_table_city_id` INT NULL,
  PRIMARY KEY (`price_pk`),
  INDEX `fk_price_city_table1_idx` (`city_table_city_id` ASC),
  CONSTRAINT `fk_price_city_table1`
    FOREIGN KEY (`city_table_city_id`)
    REFERENCES `Project_db`.`city_table` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_db`.`ppsq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project_db`.`ppsq` (
  `ppsq_pk` INT NOT NULL,
  `date` VARCHAR(45) NULL,
  `ppsq` VARCHAR(45) NULL,
  `city_table_city_id` INT NULL,
  PRIMARY KEY (`ppsq_pk`),
  INDEX `fk_ppsq_city_table1_idx` (`city_table_city_id` ASC),
  CONSTRAINT `fk_ppsq_city_table1`
    FOREIGN KEY (`city_table_city_id`)
    REFERENCES `Project_db`.`city_table` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
