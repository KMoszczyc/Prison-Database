-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Prison
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Prison
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Prison` DEFAULT CHARACTER SET utf8 ;
USE `Prison` ;

-- -----------------------------------------------------
-- Table `Prison`.`block`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`block` (
  `block_id` INT NOT NULL AUTO_INCREMENT,
  `for_dangerous` TINYINT NULL,
  PRIMARY KEY (`block_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`cell`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`cell` (
  `cell_id` INT NOT NULL AUTO_INCREMENT,
  `bed_count` INT UNSIGNED NULL,
  `block_block_id` INT NOT NULL,
  PRIMARY KEY (`cell_id`),
  INDEX `fk_cell_block1_idx` (`block_block_id` ASC) VISIBLE,
  CONSTRAINT `fk_cell_block1`
    FOREIGN KEY (`block_block_id`)
    REFERENCES `Prison`.`block` (`block_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`prisoner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`prisoner` (
  `prisoner_id` INT NOT NULL AUTO_INCREMENT,
  `prisoner_name` VARCHAR(45) NOT NULL,
  `prisoner_surname` VARCHAR(45) NOT NULL,
  `passport_number` VARCHAR(10) NOT NULL,
  `birth_date` DATE NOT NULL,
  `admission_date` DATE NOT NULL,
  `release_date` DATE NULL,
  `job_assignment` VARCHAR(45) NULL,
  `crime` VARCHAR(45) NULL,
  `is_dangerous` TINYINT NULL,
  `cell_cell_id` INT NULL,
  PRIMARY KEY (`prisoner_id`),
  UNIQUE INDEX `idPrisoners_UNIQUE` (`prisoner_id` ASC) VISIBLE,
  UNIQUE INDEX `PESEL_UNIQUE` (`passport_number` ASC) VISIBLE,
  INDEX `fk_prisoner_cell1_idx` (`cell_cell_id` ASC) VISIBLE,
  CONSTRAINT `fk_prisoner_cell1`
    FOREIGN KEY (`cell_cell_id`)
    REFERENCES `Prison`.`cell` (`cell_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`package`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`package` (
  `package_id` INT NOT NULL AUTO_INCREMENT,
  `reception_date` DATE NULL,
  `shipper` VARCHAR(100) NULL,
  `receiver` VARCHAR(100) NULL,
  `prisoner_prisoner_id` INT NOT NULL,
  PRIMARY KEY (`package_id`),
  UNIQUE INDEX `idPackage_UNIQUE` (`package_id` ASC) VISIBLE,
  INDEX `fk_Package_Prisoners_idx` (`prisoner_prisoner_id` ASC) VISIBLE,
  CONSTRAINT `fk_Package_Prisoners`
    FOREIGN KEY (`prisoner_prisoner_id`)
    REFERENCES `Prison`.`prisoner` (`prisoner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`visitor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`visitor` (
  `visitor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `visitor_name` VARCHAR(45) NOT NULL,
  `visitor_surname` VARCHAR(45) NOT NULL,
  `passport_number` VARCHAR(10) NOT NULL,
  `address` VARCHAR(100) NULL,
  PRIMARY KEY (`visitor_id`),
  UNIQUE INDEX `visitor_id_UNIQUE` (`visitor_id` ASC) VISIBLE,
  UNIQUE INDEX `PESEL_UNIQUE` (`passport_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`doctor` (
  `doctor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `doctor_name` VARCHAR(45) NOT NULL,
  `doctor_surname` VARCHAR(45) NOT NULL,
  `specialization` VARCHAR(45) NULL,
  PRIMARY KEY (`doctor_id`),
  UNIQUE INDEX `iddoctor_UNIQUE` (`doctor_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`prisoner_visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`prisoner_visit` (
  `prisoner_visit_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `visit_date` DATE NULL,
  `visit_length_minutes` INT UNSIGNED NULL,
  `prisoner_prisoner_id` INT NOT NULL,
  `visitor_visitor_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`prisoner_visit_id`),
  INDEX `fk_prisoner_visit_prisoner1_idx` (`prisoner_prisoner_id` ASC) VISIBLE,
  INDEX `fk_prisoner_visit_visitor1_idx` (`visitor_visitor_id` ASC) VISIBLE,
  CONSTRAINT `fk_prisoner_visit_prisoner1`
    FOREIGN KEY (`prisoner_prisoner_id`)
    REFERENCES `Prison`.`prisoner` (`prisoner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prisoner_visit_visitor1`
    FOREIGN KEY (`visitor_visitor_id`)
    REFERENCES `Prison`.`visitor` (`visitor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`isolation_cell`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`isolation_cell` (
  `isolation_cell_id` INT NOT NULL AUTO_INCREMENT,
  `block_block_id` INT NOT NULL,
  PRIMARY KEY (`isolation_cell_id`),
  INDEX `fk_isolation_cell_block1_idx` (`block_block_id` ASC) VISIBLE,
  CONSTRAINT `fk_isolation_cell_block1`
    FOREIGN KEY (`block_block_id`)
    REFERENCES `Prison`.`block` (`block_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`isolation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`isolation` (
  `isolation_id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NOT NULL,
  `finish_date` DATE NOT NULL,
  `prisoner_prisoner_id` INT NOT NULL,
  `isolation_cell_isolation_cell_id` INT NOT NULL,
  PRIMARY KEY (`isolation_id`),
  INDEX `fk_isolation_prisoner1_idx` (`prisoner_prisoner_id` ASC) VISIBLE,
  INDEX `fk_isolation_isolation_cell1_idx` (`isolation_cell_isolation_cell_id` ASC) VISIBLE,
  CONSTRAINT `fk_isolation_prisoner1`
    FOREIGN KEY (`prisoner_prisoner_id`)
    REFERENCES `Prison`.`prisoner` (`prisoner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_isolation_isolation_cell1`
    FOREIGN KEY (`isolation_cell_isolation_cell_id`)
    REFERENCES `Prison`.`isolation_cell` (`isolation_cell_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`complaint`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`complaint` (
  `complaint_id` INT NOT NULL AUTO_INCREMENT,
  `contents` VARCHAR(500) NULL,
  `complaint_date` DATE NULL,
  `prisoner_prisoner_id` INT NOT NULL,
  PRIMARY KEY (`complaint_id`),
  INDEX `fk_complaint_prisoner1_idx` (`prisoner_prisoner_id` ASC) VISIBLE,
  CONSTRAINT `fk_complaint_prisoner1`
    FOREIGN KEY (`prisoner_prisoner_id`)
    REFERENCES `Prison`.`prisoner` (`prisoner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`jailer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`jailer` (
  `jailer_id` INT NOT NULL AUTO_INCREMENT,
  `jailer_name` VARCHAR(45) NOT NULL,
  `jailer_surname` VARCHAR(45) NOT NULL,
  `passport_number` VARCHAR(10) NOT NULL,
  `employment_date` DATE NOT NULL,
  `layoff_date` DATE NULL,
  PRIMARY KEY (`jailer_id`),
  UNIQUE INDEX `passport_number_UNIQUE` (`passport_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`reprimand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`reprimand` (
  `reprimand_id` INT NOT NULL AUTO_INCREMENT,
  `reprimand_date` DATE NULL,
  `contents` VARCHAR(500) NULL,
  `jailer_jailer_id` INT NOT NULL,
  `prisoner_prisoner_id` INT NOT NULL,
  PRIMARY KEY (`reprimand_id`),
  INDEX `fk_reprimand_jailer1_idx` (`jailer_jailer_id` ASC) VISIBLE,
  INDEX `fk_reprimand_prisoner1_idx` (`prisoner_prisoner_id` ASC) VISIBLE,
  CONSTRAINT `fk_reprimand_jailer1`
    FOREIGN KEY (`jailer_jailer_id`)
    REFERENCES `Prison`.`jailer` (`jailer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reprimand_prisoner1`
    FOREIGN KEY (`prisoner_prisoner_id`)
    REFERENCES `Prison`.`prisoner` (`prisoner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`deposit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`deposit` (
  `deposit_id` INT NOT NULL AUTO_INCREMENT,
  `deposit_date` DATE NULL,
  `prisoner_prisoner_id` INT NULL,
  PRIMARY KEY (`deposit_id`),
  INDEX `fk_deposit_prisoner1_idx` (`prisoner_prisoner_id` ASC) VISIBLE,
  CONSTRAINT `fk_deposit_prisoner1`
    FOREIGN KEY (`prisoner_prisoner_id`)
    REFERENCES `Prison`.`prisoner` (`prisoner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`object`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`object` (
  `object_id` INT NOT NULL AUTO_INCREMENT,
  `object_name` VARCHAR(45) NULL,
  `deposit_deposit_id` INT NULL,
  PRIMARY KEY (`object_id`),
  INDEX `fk_object_deposit1_idx` (`deposit_deposit_id` ASC) VISIBLE,
  CONSTRAINT `fk_object_deposit1`
    FOREIGN KEY (`deposit_deposit_id`)
    REFERENCES `Prison`.`deposit` (`deposit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`pass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`pass` (
  `pass_id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NOT NULL,
  `finish_date` DATE NOT NULL,
  `prisoner_prisoner_id` INT NOT NULL,
  PRIMARY KEY (`pass_id`),
  INDEX `fk_pass_prisoner1_idx` (`prisoner_prisoner_id` ASC) VISIBLE,
  CONSTRAINT `fk_pass_prisoner1`
    FOREIGN KEY (`prisoner_prisoner_id`)
    REFERENCES `Prison`.`prisoner` (`prisoner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`duty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`duty` (
  `duty_id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATETIME NOT NULL,
  `finish_date` DATETIME NOT NULL,
  `block_block_id` INT NOT NULL,
  PRIMARY KEY (`duty_id`),
  INDEX `fk_duty_block1_idx` (`block_block_id` ASC) VISIBLE,
  CONSTRAINT `fk_duty_block1`
    FOREIGN KEY (`block_block_id`)
    REFERENCES `Prison`.`block` (`block_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`shift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`shift` (
  `shift_id` INT NOT NULL AUTO_INCREMENT,
  `duty_duty_id` INT NOT NULL,
  `jailer_jailer_id` INT NOT NULL,
  PRIMARY KEY (`shift_id`),
  INDEX `fk_shift_duty1_idx` (`duty_duty_id` ASC) VISIBLE,
  INDEX `fk_shift_jailer1_idx` (`jailer_jailer_id` ASC) VISIBLE,
  CONSTRAINT `fk_shift_duty1`
    FOREIGN KEY (`duty_duty_id`)
    REFERENCES `Prison`.`duty` (`duty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shift_jailer1`
    FOREIGN KEY (`jailer_jailer_id`)
    REFERENCES `Prison`.`jailer` (`jailer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prison`.`infirmary_visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prison`.`infirmary_visit` (
  `infirmary_visit_id` INT NOT NULL AUTO_INCREMENT,
  `visit_date` DATETIME NULL,
  `health_description` VARCHAR(500) NULL,
  `prisoner_prisoner_id` INT NOT NULL,
  `doctor_doctor_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`infirmary_visit_id`),
  INDEX `fk_infirmary_visit_prisoner1_idx` (`prisoner_prisoner_id` ASC) VISIBLE,
  INDEX `fk_infirmary_visit_doctor1_idx` (`doctor_doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_infirmary_visit_prisoner1`
    FOREIGN KEY (`prisoner_prisoner_id`)
    REFERENCES `Prison`.`prisoner` (`prisoner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infirmary_visit_doctor1`
    FOREIGN KEY (`doctor_doctor_id`)
    REFERENCES `Prison`.`doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
