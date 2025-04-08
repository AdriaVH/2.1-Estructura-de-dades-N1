-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pizza_store
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE SCHEMA IF NOT EXISTS `pizza_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizza_store` ;
--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `cityId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `regionId` int NOT NULL,
  PRIMARY KEY (`cityId`),
  UNIQUE KEY `regionId_UNIQUE` (`regionId`),
  UNIQUE KEY `cityId_UNIQUE` (`cityId`),
  KEY `idx_regionId` (`regionId`),
  CONSTRAINT `fk_city_region` FOREIGN KEY (`regionId`) REFERENCES `region` (`regionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `clientId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `familyName` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `zipCode` varchar(45) NOT NULL,
  `regionId` int NOT NULL,
  `cityId` int NOT NULL,
  `phoneNumber` int NOT NULL,
  PRIMARY KEY (`clientId`),
  UNIQUE KEY `clientId_UNIQUE` (`clientId`),
  UNIQUE KEY `regionId_UNIQUE` (`regionId`),
  UNIQUE KEY `cityId_UNIQUE` (`cityId`),
  KEY `idx_cityId_client` (`cityId`),
  KEY `idx_regionId_client` (`regionId`),
  CONSTRAINT `fk_client_cityId` FOREIGN KEY (`cityId`) REFERENCES `city` (`cityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employeeId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `familyName` varchar(45) NOT NULL,
  `NIF` varchar(11) NOT NULL,
  `phoneNumber` int NOT NULL,
  `position` enum('chef','driver','other') NOT NULL,
  PRIMARY KEY (`employeeId`),
  UNIQUE KEY `NIF_UNIQUE` (`NIF`),
  UNIQUE KEY `employeeId_UNIQUE` (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `dateTime` datetime NOT NULL,
  `storeOrDelivery` enum('delivery','pick-up') NOT NULL,
  `pizzaStoreId` int NOT NULL,
  `clientId` int NOT NULL,
  `driverId` int DEFAULT NULL,
  `deliveryTime` time DEFAULT NULL,
  `employeeId` varchar(45) NOT NULL,
  PRIMARY KEY (`orderId`),
  UNIQUE KEY `clientId_UNIQUE` (`clientId`),
  UNIQUE KEY `pizzaStoreId_UNIQUE` (`pizzaStoreId`),
  UNIQUE KEY `orderId_UNIQUE` (`orderId`),
  UNIQUE KEY `employeeId_UNIQUE` (`employeeId`),
  UNIQUE KEY `driverId_UNIQUE` (`driverId`),
  KEY `idx_pizzaStoreId_order` (`pizzaStoreId`),
  KEY `idx_clientId_order` (`clientId`),
  CONSTRAINT `fk_driver` FOREIGN KEY (`driverId`) REFERENCES `employee` (`employeeId`),
  CONSTRAINT `fk_order_clientId` FOREIGN KEY (`clientId`) REFERENCES `client` (`clientId`),
  CONSTRAINT `fk_order_pizzaStoreId` FOREIGN KEY (`pizzaStoreId`) REFERENCES `pizzastore` (`pizzaStoreId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `orderDetailsId` int NOT NULL AUTO_INCREMENT,
  `productId` int NOT NULL,
  `orderId` int NOT NULL,
  PRIMARY KEY (`orderDetailsId`),
  UNIQUE KEY `productId_UNIQUE` (`productId`),
  UNIQUE KEY `orderId_UNIQUE` (`orderId`),
  UNIQUE KEY `orderDetailsId_UNIQUE` (`orderDetailsId`),
  KEY `idx_productId_orderDetails` (`productId`),
  KEY `idx_orderId_orderDetails` (`orderId`),
  CONSTRAINT `fk_orderDetails_orderId` FOREIGN KEY (`orderId`) REFERENCES `order` (`orderId`),
  CONSTRAINT `fk_orderDetails_productId` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzastore`
--

DROP TABLE IF EXISTS `pizzastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzastore` (
  `pizzaStoreId` int NOT NULL AUTO_INCREMENT,
  `address` varchar(45) NOT NULL,
  `cityId` int NOT NULL,
  `regionId` int NOT NULL,
  PRIMARY KEY (`pizzaStoreId`),
  UNIQUE KEY `pizzaStoreId_UNIQUE` (`pizzaStoreId`),
  UNIQUE KEY `cityId_UNIQUE` (`cityId`),
  UNIQUE KEY `regionId_UNIQUE` (`regionId`),
  KEY `idx_cityId_pizzaStore` (`cityId`),
  KEY `idx_regionId_pizzaStore` (`regionId`),
  CONSTRAINT `fk_pizzaStore_cityId` FOREIGN KEY (`cityId`) REFERENCES `city` (`cityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzastore`
--

LOCK TABLES `pizzastore` WRITE;
/*!40000 ALTER TABLE `pizzastore` DISABLE KEYS */;
/*!40000 ALTER TABLE `pizzastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzatype`
--

DROP TABLE IF EXISTS `pizzatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzatype` (
  `pizzaTypeId` int NOT NULL AUTO_INCREMENT,
  `pizzaTypeName` varchar(45) NOT NULL,
  `productTypeId` int NOT NULL,
  PRIMARY KEY (`pizzaTypeId`),
  UNIQUE KEY `pizzaTypeId_UNIQUE` (`pizzaTypeId`),
  UNIQUE KEY `productTypeId_UNIQUE` (`productTypeId`),
  KEY `fk_pizzaType_productType` (`productTypeId`),
  CONSTRAINT `fk_pizzaType_productType` FOREIGN KEY (`productTypeId`) REFERENCES `producttype` (`productTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzatype`
--

LOCK TABLES `pizzatype` WRITE;
/*!40000 ALTER TABLE `pizzatype` DISABLE KEYS */;
/*!40000 ALTER TABLE `pizzatype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `productTypeId` int NOT NULL,
  `pizzaTypeId` int DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  `image` varchar(45) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  PRIMARY KEY (`productId`),
  UNIQUE KEY `productId_UNIQUE` (`productId`),
  UNIQUE KEY `productTypeId_UNIQUE` (`productTypeId`),
  UNIQUE KEY `pizzaTypeId_UNIQUE` (`pizzaTypeId`),
  KEY `idx_productTypeId_product` (`productTypeId`),
  KEY `idx_pizzaType_product` (`pizzaTypeId`),
  CONSTRAINT `fk_product_pizzaType` FOREIGN KEY (`pizzaTypeId`) REFERENCES `pizzatype` (`pizzaTypeId`),
  CONSTRAINT `fk_product_productTypeId` FOREIGN KEY (`productTypeId`) REFERENCES `producttype` (`productTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producttype`
--

DROP TABLE IF EXISTS `producttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producttype` (
  `productTypeId` int NOT NULL AUTO_INCREMENT,
  `name` enum('Pizza','Burger','Drinks') NOT NULL,
  PRIMARY KEY (`productTypeId`),
  UNIQUE KEY `productTypeId_UNIQUE` (`productTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producttype`
--

LOCK TABLES `producttype` WRITE;
/*!40000 ALTER TABLE `producttype` DISABLE KEYS */;
/*!40000 ALTER TABLE `producttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `regionId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`regionId`),
  UNIQUE KEY `regionId_UNIQUE` (`regionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-08 13:01:06
