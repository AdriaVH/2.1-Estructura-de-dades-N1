-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_d_ampolla` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cul_d_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`employees` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fullName` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phoneNumber` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `registrationDate` DATE NOT NULL,
  `recomendedBy` INT NULL DEFAULT NULL,
  `employeeId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC) VISIBLE,
  INDEX `id_idx` (`employeeId` ASC) VISIBLE,
  INDEX `id_idx1` (`recomendedBy` ASC) VISIBLE,
  CONSTRAINT `fk_employee`
    FOREIGN KEY (`employeeId`)
    REFERENCES `cul_d_ampolla`.`employees` (`id`),
  CONSTRAINT `fk_recomended`
    FOREIGN KEY (`recomendedBy`)
    REFERENCES `cul_d_ampolla`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phoneNumber` INT NOT NULL,
  `faxNumber` INT NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idsupplier_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`glasses` (
  `id` INT NOT NULL,
  `idSupplier` INT NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `prescriptionLeft` FLOAT NOT NULL,
  `prescriptionRight` FLOAT NOT NULL,
  `frameType` ENUM('flotant', 'pasta', 'metalica') NOT NULL,
  `frameColor` VARCHAR(15) NOT NULL,
  `glassColor` VARCHAR(15) NOT NULL,
  `price` FLOAT NOT NULL,
  `clientId` INT NOT NULL,
  UNIQUE INDEX `ideyeGlasses_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `supplier_UNIQUE` (`idSupplier` ASC) VISIBLE,
  INDEX `id_idx` (`clientId` ASC) VISIBLE,
  CONSTRAINT `idSupplier`
    FOREIGN KEY (`idSupplier`)
    REFERENCES `cul_d_ampolla`.`supplier` (`id`),
  CONSTRAINT `id`
    FOREIGN KEY (`clientId`)
    REFERENCES `cul_d_ampolla`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`sale` (
  `id` INT NOT NULL,
  `idEmployee` INT NOT NULL,
  `idClient` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idSale_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `id_idx` (`idEmployee` ASC) VISIBLE,
  INDEX `id_idx1` (`idClient` ASC) VISIBLE,
  CONSTRAINT `id_employee`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `cul_d_ampolla`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_client`
    FOREIGN KEY (`idClient`)
    REFERENCES `cul_d_ampolla`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`saleDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`saleDetails` (
  `id` INT NOT NULL,
  `saleId` INT NOT NULL,
  `glassesId` INT NOT NULL,
  `priceGlasses` DOUBLE NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`saleId` ASC) VISIBLE,
  INDEX `id_idx1` (`glassesId` ASC) VISIBLE,
  CONSTRAINT `id_sale`
    FOREIGN KEY (`saleId`)
    REFERENCES `cul_d_ampolla`.`sale` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_glasses`
    FOREIGN KEY (`glassesId`)
    REFERENCES `cul_d_ampolla`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
