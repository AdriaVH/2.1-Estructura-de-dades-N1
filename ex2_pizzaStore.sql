-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema pizza_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizza_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizza_store` ;

-- -----------------------------------------------------
-- Table `pizza_store`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`region` (
  `regionId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`regionId`),
  UNIQUE INDEX `regionId_UNIQUE` (`regionId` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`city` (
  `cityId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `regionId` INT NOT NULL,
  PRIMARY KEY (`cityId`),
  UNIQUE INDEX `regionId_UNIQUE` (`regionId` ASC) VISIBLE,
  UNIQUE INDEX `cityId_UNIQUE` (`cityId` ASC) VISIBLE,
  INDEX `idx_regionId` (`regionId` ASC) VISIBLE,
  CONSTRAINT `fk_city_region`
    FOREIGN KEY (`regionId`)
    REFERENCES `pizza_store`.`region` (`regionId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`client` (
  `clientId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `familyName` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `zipCode` VARCHAR(45) NOT NULL,
  `regionId` INT NOT NULL,
  `cityId` INT NOT NULL,
  `phoneNumber` INT NOT NULL,
  PRIMARY KEY (`clientId`),
  UNIQUE INDEX `clientId_UNIQUE` (`clientId` ASC) VISIBLE,
  UNIQUE INDEX `regionId_UNIQUE` (`regionId` ASC) VISIBLE,
  UNIQUE INDEX `cityId_UNIQUE` (`cityId` ASC) VISIBLE,
  INDEX `idx_cityId_client` (`cityId` ASC) VISIBLE,
  INDEX `idx_regionId_client` (`regionId` ASC) VISIBLE,
  CONSTRAINT `fk_client_cityId`
    FOREIGN KEY (`cityId`)
    REFERENCES `pizza_store`.`city` (`cityId`),
  CONSTRAINT `fk_client_regionId`
    FOREIGN KEY (`regionId`)
    REFERENCES `pizza_store`.`city` (`regionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`employee` (
  `employeeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `familyName` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(11) NOT NULL,
  `phoneNumber` INT NOT NULL,
  `position` ENUM('chef', 'driver', 'other') NOT NULL,
  PRIMARY KEY (`employeeId`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  UNIQUE INDEX `employeeId_UNIQUE` (`employeeId` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`pizzastore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`pizzastore` (
  `pizzaStoreId` INT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `cityId` INT NOT NULL,
  `regionId` INT NOT NULL,
  PRIMARY KEY (`pizzaStoreId`),
  UNIQUE INDEX `pizzaStoreId_UNIQUE` (`pizzaStoreId` ASC) VISIBLE,
  UNIQUE INDEX `cityId_UNIQUE` (`cityId` ASC) VISIBLE,
  UNIQUE INDEX `regionId_UNIQUE` (`regionId` ASC) VISIBLE,
  INDEX `idx_cityId_pizzaStore` (`cityId` ASC) VISIBLE,
  INDEX `idx_regionId_pizzaStore` (`regionId` ASC) VISIBLE,
  CONSTRAINT `fk_pizzaStore_cityId`
    FOREIGN KEY (`cityId`)
    REFERENCES `pizza_store`.`city` (`cityId`),
  CONSTRAINT `fk_pizaStore_regionId`
    FOREIGN KEY (`regionId`)
    REFERENCES `pizza_store`.`city` (`regionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`order` (
  `orderId` INT NOT NULL,
  `dateTime` DATETIME NOT NULL,
  `storeOrDelivery` ENUM('delivery', 'pick-up') NOT NULL,
  `pizzaStoreId` INT NOT NULL,
  `clientId` INT NOT NULL,
  `driverId` INT NULL DEFAULT NULL,
  `deliveryTime` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  UNIQUE INDEX `clientId_UNIQUE` (`clientId` ASC) VISIBLE,
  UNIQUE INDEX `pizzaStoreId_UNIQUE` (`pizzaStoreId` ASC) VISIBLE,
  UNIQUE INDEX `orderId_UNIQUE` (`orderId` ASC) VISIBLE,
  UNIQUE INDEX `driverId_UNIQUE` (`driverId` ASC) VISIBLE,
  INDEX `idx_pizzaStoreId_order` (`pizzaStoreId` ASC) VISIBLE,
  INDEX `idx_clientId_order` (`clientId` ASC) VISIBLE,
  CONSTRAINT `fk_driver`
    FOREIGN KEY (`driverId`)
    REFERENCES `pizza_store`.`employee` (`employeeId`),
  CONSTRAINT `fk_order_clientId`
    FOREIGN KEY (`clientId`)
    REFERENCES `pizza_store`.`client` (`clientId`),
  CONSTRAINT `fk_order_pizzaStoreId`
    FOREIGN KEY (`pizzaStoreId`)
    REFERENCES `pizza_store`.`pizzastore` (`pizzaStoreId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`producttype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`producttype` (
  `productTypeId` INT NOT NULL,
  `name` ENUM('Pizza', 'Burger', 'Drinks') NOT NULL,
  PRIMARY KEY (`productTypeId`),
  UNIQUE INDEX `productTypeId_UNIQUE` (`productTypeId` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`pizzatype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`pizzatype` (
  `pizzaTypeId` INT NOT NULL,
  `pizzaTypeName` VARCHAR(45) NOT NULL,
  `productTypeId` INT NOT NULL,
  PRIMARY KEY (`pizzaTypeId`),
  UNIQUE INDEX `pizzaTypeId_UNIQUE` (`pizzaTypeId` ASC) VISIBLE,
  UNIQUE INDEX `productTypeId_UNIQUE` (`productTypeId` ASC) VISIBLE,
  INDEX `fk_pizzaType_productType` (`productTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_pizzaType_productType`
    FOREIGN KEY (`productTypeId`)
    REFERENCES `pizza_store`.`producttype` (`productTypeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`product` (
  `productId` INT NOT NULL,
  `productTypeId` INT NOT NULL,
  `pizzaTypeId` INT NULL DEFAULT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`productId`),
  UNIQUE INDEX `productId_UNIQUE` (`productId` ASC) VISIBLE,
  UNIQUE INDEX `productTypeId_UNIQUE` (`productTypeId` ASC) VISIBLE,
  UNIQUE INDEX `pizzaTypeId_UNIQUE` (`pizzaTypeId` ASC) VISIBLE,
  INDEX `idx_productTypeId_product` (`productTypeId` ASC) VISIBLE,
  INDEX `idx_pizzaType_product` (`pizzaTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_product_pizzaType`
    FOREIGN KEY (`pizzaTypeId`)
    REFERENCES `pizza_store`.`pizzatype` (`pizzaTypeId`),
  CONSTRAINT `fk_product_productTypeId`
    FOREIGN KEY (`productTypeId`)
    REFERENCES `pizza_store`.`producttype` (`productTypeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_store`.`orderdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_store`.`orderdetails` (
  `orderDetailsId` INT NOT NULL,
  `productId` INT NOT NULL,
  `orderId` INT NOT NULL,
  PRIMARY KEY (`orderDetailsId`),
  UNIQUE INDEX `productId_UNIQUE` (`productId` ASC) VISIBLE,
  UNIQUE INDEX `orderId_UNIQUE` (`orderId` ASC) VISIBLE,
  UNIQUE INDEX `orderDetailsId_UNIQUE` (`orderDetailsId` ASC) VISIBLE,
  INDEX `idx_productId_orderDetails` (`productId` ASC) VISIBLE,
  INDEX `idx_orderId_orderDetails` (`orderId` ASC) VISIBLE,
  CONSTRAINT `fk_orderDetails_orderId`
    FOREIGN KEY (`orderId`)
    REFERENCES `pizza_store`.`order` (`orderId`),
  CONSTRAINT `fk_orderDetails_productId`
    FOREIGN KEY (`productId`)
    REFERENCES `pizza_store`.`product` (`productId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `pizza_store`;

DELIMITER $$
USE `pizza_store`$$
DROP TRIGGER IF EXISTS `pizza_store`.`order_BEFORE_INSERT`$$
CREATE
TRIGGER `pizza_store`.`order_BEFORE_INSERT`
BEFORE INSERT ON `pizza_store`.`order`
FOR EACH ROW
BEGIN
    -- Check if storeOrDelivery is 'delivery'
    IF NEW.storeOrDelivery = 'delivery' THEN
        -- Assign driverId from an employee whose position is 'driver'
        SET NEW.driverId = (
            SELECT employeeId
            FROM `pizza_store`.`employee`
            WHERE position = 'driver'
            LIMIT 1
        );
        SET NEW.deliveryTime = NOW();
    ELSE
        -- If not 'delivery', set driverId to NULL
        SET NEW.driverId = NULL;
        SET NEW.deliveryTime = NULL;
    END IF;
END$$

USE `pizza_store`$$
DROP TRIGGER IF EXISTS `pizza_store`.`product_BEFORE_INSERT`$$
CREATE
TRIGGER `pizza_store`.`product_BEFORE_INSERT`
BEFORE INSERT ON `pizza_store`.`product`
FOR EACH ROW
BEGIN
    -- Validate if the pizzaTypeId matches with productTypeId in the pizzaType table
    IF EXISTS (
        SELECT 1
        FROM `pizza_store`.`pizzaType`
        WHERE pizzaTypeId = NEW.pizzaTypeId
          AND productType = NEW.productTypeId
    ) THEN
        -- Accept the value of pizzaTypeId
        SET NEW.pizzaTypeId = NEW.pizzaTypeId;
    ELSE
        -- Assign NULL to pizzaTypeId if the match fails
        SET NEW.pizzaTypeId = NULL;
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
