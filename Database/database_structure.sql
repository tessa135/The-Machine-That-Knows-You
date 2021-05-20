-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: database-tessa.cp1otesgrats.eu-west-1.rds.amazonaws.com    Database: KI
-- ------------------------------------------------------
-- Server version	8.0.20

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `Codes`
--

DROP TABLE IF EXISTS `Codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Codes` (
  `ID` int NOT NULL,
  `Code` varchar(45) DEFAULT '',
  `Is_Used` int DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Consent`
--

DROP TABLE IF EXISTS `Consent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Consent` (
  `Date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Session` varchar(100) DEFAULT NULL,
  `VPCode` varchar(45) DEFAULT NULL,
  `Informing` int DEFAULT NULL,
  `Consent` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Date`),
  UNIQUE KEY `Date_UNIQUE` (`Date`),
  UNIQUE KEY `Session_UNIQUE` (`Session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Final_Questionnaire`
--

DROP TABLE IF EXISTS `Final_Questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Final_Questionnaire` (
  `idFinal_Questionnaire` int NOT NULL AUTO_INCREMENT,
  `Session` varchar(100) DEFAULT NULL,
  `Date` datetime DEFAULT CURRENT_TIMESTAMP,
  `VPCode` varchar(45) DEFAULT NULL,
  `UEQS_1` int DEFAULT NULL,
  `UEQS_2` int DEFAULT NULL,
  `UEQS_3` int DEFAULT NULL,
  `UEQS_4` int DEFAULT NULL,
  `UEQS_5` int DEFAULT NULL,
  `UEQS_6` int DEFAULT NULL,
  `UEQS_7` int DEFAULT NULL,
  `UEQS_8` int DEFAULT NULL,
  `GQS_3_1` int DEFAULT NULL,
  `GQS_3_2` int DEFAULT NULL,
  `GQS_3_3` int DEFAULT NULL,
  `GQS_3_4` int DEFAULT NULL,
  `GQS_3_5` int DEFAULT NULL,
  `GQS_4_1` int DEFAULT NULL,
  `GQS_4_2` int DEFAULT NULL,
  `GQS_4_3` int DEFAULT NULL,
  `GQS_4_4` int DEFAULT NULL,
  `GQS_4_5` int DEFAULT NULL,
  `GQS_5_1` int DEFAULT NULL,
  `GQS_5_2` int DEFAULT NULL,
  `GQS_5_3` int DEFAULT NULL,
  `KIT_1` int DEFAULT NULL,
  `KIT_2` int DEFAULT NULL,
  `KIT_3` int DEFAULT NULL,
  `KIT_4` int DEFAULT NULL,
  `KIT_5` int DEFAULT NULL,
  `KIT_6` int DEFAULT NULL,
  `KIT_7` int DEFAULT NULL,
  `KIT_8` int DEFAULT NULL,
  `KIT_9` int DEFAULT NULL,
  `KIT_10` int DEFAULT NULL,
  `KIT_11` int DEFAULT NULL,
  `KUSIV3_1` int DEFAULT NULL,
  `KUSIV3_2` int DEFAULT NULL,
  `KUSIV3_3` int DEFAULT NULL,
  `Fun` int DEFAULT NULL,
  `SD_Gender` int DEFAULT NULL,
  `SD_Age` int DEFAULT NULL,
  `Notes` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`idFinal_Questionnaire`),
  UNIQUE KEY `idFinal_Questionnaire_UNIQUE` (`idFinal_Questionnaire`)
) ENGINE=InnoDB AUTO_INCREMENT=753 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Questions` (
  `ID` int NOT NULL,
  `Questions` varchar(255) DEFAULT NULL,
  `Questions_Shortcuts` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `User_Input`
--

DROP TABLE IF EXISTS `User_Input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Input` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Session` varchar(100) DEFAULT NULL,
  `VPCode` varchar(45) DEFAULT NULL,
  `A1` int DEFAULT NULL,
  `A2` int DEFAULT NULL,
  `A3` int DEFAULT NULL,
  `A4` int DEFAULT NULL,
  `A5` int DEFAULT NULL,
  `A6` int DEFAULT NULL,
  `A7` int DEFAULT NULL,
  `A8` int DEFAULT NULL,
  `A9` int DEFAULT NULL,
  `A10` int DEFAULT NULL,
  `C1` int DEFAULT NULL,
  `C2` int DEFAULT NULL,
  `C3` int DEFAULT NULL,
  `C4` int DEFAULT NULL,
  `C5` int DEFAULT NULL,
  `C6` int DEFAULT NULL,
  `C7` int DEFAULT NULL,
  `C8` int DEFAULT NULL,
  `C9` int DEFAULT NULL,
  `C10` int DEFAULT NULL,
  `E1` int DEFAULT NULL,
  `E2` int DEFAULT NULL,
  `E3` int DEFAULT NULL,
  `E4` int DEFAULT NULL,
  `E5` int DEFAULT NULL,
  `E6` int DEFAULT NULL,
  `E7` int DEFAULT NULL,
  `E8` int DEFAULT NULL,
  `E9` int DEFAULT NULL,
  `E10` int DEFAULT NULL,
  `N1` int DEFAULT NULL,
  `N2` int DEFAULT NULL,
  `N3` int DEFAULT NULL,
  `N4` int DEFAULT NULL,
  `N5` int DEFAULT NULL,
  `N6` int DEFAULT NULL,
  `N7` int DEFAULT NULL,
  `N8` int DEFAULT NULL,
  `N9` int DEFAULT NULL,
  `N10` int DEFAULT NULL,
  `O1` int DEFAULT NULL,
  `O2` int DEFAULT NULL,
  `O3` int DEFAULT NULL,
  `O4` int DEFAULT NULL,
  `O5` int DEFAULT NULL,
  `O6` int DEFAULT NULL,
  `O7` int DEFAULT NULL,
  `O8` int DEFAULT NULL,
  `O9` int DEFAULT NULL,
  `O10` int DEFAULT NULL,
  `TFPred1` int DEFAULT NULL,
  `TFPred2` int DEFAULT NULL,
  `TFPred3` int DEFAULT NULL,
  `TFPred4` int DEFAULT NULL,
  `TFPred5` int DEFAULT NULL,
  `TFPred6` int DEFAULT NULL,
  `Prediction1` int DEFAULT NULL,
  `Prediction2` int DEFAULT NULL,
  `Prediction3` int DEFAULT NULL,
  `Prediction4` int DEFAULT NULL,
  `Prediction5` int DEFAULT NULL,
  `Prediction6` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `Session_UNIQUE` (`Session`)
) ENGINE=InnoDB AUTO_INCREMENT=863 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-19 13:57:25
