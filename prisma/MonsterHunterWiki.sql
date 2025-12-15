-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (arm64)
--
-- Host: localhost    Database: monsterhunter_wiki
-- ------------------------------------------------------
-- Server version	9.5.0

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

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'd14e47ba-c0b2-11f0-ad83-e8e0abb99ad9:1-65';

--
-- Table structure for table `Armes`
--

DROP TABLE IF EXISTS `Armes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Armes` (
  `id_arme` int NOT NULL AUTO_INCREMENT,
  `nom_arme` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_arme` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `element_principal` int DEFAULT NULL,
  PRIMARY KEY (`id_arme`),
  KEY `element_principal` (`element_principal`),
  CONSTRAINT `armes_ibfk_1` FOREIGN KEY (`element_principal`) REFERENCES `Elements` (`id_element`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Armes`
--

LOCK TABLES `Armes` WRITE;
/*!40000 ALTER TABLE `Armes` DISABLE KEYS */;
INSERT INTO `Armes` VALUES (1,'Lame wyverne','Épée longue',1),(2,'Arc du tonnerre','Arc',4),(3,'Lance aquatique','Lance',2),(4,'Marteau volcanique','Marteau',1),(5,'Glaive du dragon','Glaive insecte',5);
/*!40000 ALTER TABLE `Armes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Armes_Monstres`
--

DROP TABLE IF EXISTS `Armes_Monstres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Armes_Monstres` (
  `id_arme` int NOT NULL,
  `id_monstre` int NOT NULL,
  PRIMARY KEY (`id_arme`,`id_monstre`),
  KEY `id_monstre` (`id_monstre`),
  CONSTRAINT `armes_monstres_ibfk_1` FOREIGN KEY (`id_arme`) REFERENCES `Armes` (`id_arme`),
  CONSTRAINT `armes_monstres_ibfk_2` FOREIGN KEY (`id_monstre`) REFERENCES `Monstres` (`id_monstre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Armes_Monstres`
--

LOCK TABLES `Armes_Monstres` WRITE;
/*!40000 ALTER TABLE `Armes_Monstres` DISABLE KEYS */;
INSERT INTO `Armes_Monstres` VALUES (1,1),(2,2),(5,3),(3,4),(4,5);
/*!40000 ALTER TABLE `Armes_Monstres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Butins`
--

DROP TABLE IF EXISTS `Butins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Butins` (
  `id_butin` int NOT NULL AUTO_INCREMENT,
  `id_monstre` int DEFAULT NULL,
  `nom_objet` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rarete` int DEFAULT NULL,
  PRIMARY KEY (`id_butin`),
  KEY `id_monstre` (`id_monstre`),
  CONSTRAINT `butins_ibfk_1` FOREIGN KEY (`id_monstre`) REFERENCES `Monstres` (`id_monstre`),
  CONSTRAINT `butins_chk_1` CHECK ((`rarete` between 1 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Butins`
--

LOCK TABLES `Butins` WRITE;
/*!40000 ALTER TABLE `Butins` DISABLE KEYS */;
INSERT INTO `Butins` VALUES (1,1,'Écaille de Rathalos',3),(2,1,'Aile de Rathalos',5),(3,2,'Cuir de Lagiacrus',4),(4,4,'Dent de Barioth',6),(5,5,'Poudre de Teostra',9);
/*!40000 ALTER TABLE `Butins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Elements`
--

DROP TABLE IF EXISTS `Elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Elements` (
  `id_element` int NOT NULL AUTO_INCREMENT,
  `nom_element` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_element`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Elements`
--

LOCK TABLES `Elements` WRITE;
/*!40000 ALTER TABLE `Elements` DISABLE KEYS */;
INSERT INTO `Elements` VALUES (1,'Feu'),(2,'Eau'),(3,'Glace'),(4,'Foudre'),(5,'Dragon');
/*!40000 ALTER TABLE `Elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faiblesses`
--

DROP TABLE IF EXISTS `Faiblesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Faiblesses` (
  `id_faiblesse` int NOT NULL AUTO_INCREMENT,
  `id_monstre` int DEFAULT NULL,
  `id_element` int DEFAULT NULL,
  `niveau` int DEFAULT NULL,
  PRIMARY KEY (`id_faiblesse`),
  KEY `id_monstre` (`id_monstre`),
  KEY `id_element` (`id_element`),
  CONSTRAINT `faiblesses_ibfk_1` FOREIGN KEY (`id_monstre`) REFERENCES `Monstres` (`id_monstre`),
  CONSTRAINT `faiblesses_ibfk_2` FOREIGN KEY (`id_element`) REFERENCES `Elements` (`id_element`),
  CONSTRAINT `faiblesses_chk_1` CHECK ((`niveau` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faiblesses`
--

LOCK TABLES `Faiblesses` WRITE;
/*!40000 ALTER TABLE `Faiblesses` DISABLE KEYS */;
INSERT INTO `Faiblesses` VALUES (1,1,2,3),(2,2,3,4),(3,3,5,2),(4,4,1,5),(5,5,2,4);
/*!40000 ALTER TABLE `Faiblesses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Habitats`
--

DROP TABLE IF EXISTS `Habitats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Habitats` (
  `id_habitat` int NOT NULL AUTO_INCREMENT,
  `nom_habitat` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_habitat`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Habitats`
--

LOCK TABLES `Habitats` WRITE;
/*!40000 ALTER TABLE `Habitats` DISABLE KEYS */;
INSERT INTO `Habitats` VALUES (1,'Forêt ancienne','Région verte'),(2,'Désert étendu','Région aride'),(3,'Volcan actif','Région brûlante'),(4,'Toundra gelée','Région glaciale'),(5,'Jungle dense','Région tropicale');
/*!40000 ALTER TABLE `Habitats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Monstres`
--

DROP TABLE IF EXISTS `Monstres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Monstres` (
  `id_monstre` int NOT NULL AUTO_INCREMENT,
  `nom_monstre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_type` int DEFAULT NULL,
  `id_habitat` int DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_monstre`),
  KEY `id_type` (`id_type`),
  KEY `id_habitat` (`id_habitat`),
  CONSTRAINT `monstres_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `Types_Monstres` (`id_type`),
  CONSTRAINT `monstres_ibfk_2` FOREIGN KEY (`id_habitat`) REFERENCES `Habitats` (`id_habitat`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monstres`
--

LOCK TABLES `Monstres` WRITE;
/*!40000 ALTER TABLE `Monstres` DISABLE KEYS */;
INSERT INTO `Monstres` VALUES (1,'Rathalos',1,1,'Roi des cieux, maître du feu.'),(2,'Lagiacrus',5,2,'Dominateur des mers, manie la foudre.'),(3,'Tigrex',4,1,'Prédateur féroce des montagnes.'),(4,'Barioth',4,4,'Habite les terres gelées, rapide et agile.'),(5,'Teostra',2,3,'Dragon ancien de feu et de rage.'),(9,'Legiana',5,5,'Le roi de la glace, monstre légendaire '),(10,'Méga magic Yogitus',2,1,'C\'est le roi des spitz ');
/*!40000 ALTER TABLE `Monstres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Quetes`
--

DROP TABLE IF EXISTS `Quetes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Quetes` (
  `id_quete` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `difficulte` enum('Facile','Moyenne','Difficile','Expert') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recompense` int DEFAULT NULL,
  PRIMARY KEY (`id_quete`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quetes`
--

LOCK TABLES `Quetes` WRITE;
/*!40000 ALTER TABLE `Quetes` DISABLE KEYS */;
INSERT INTO `Quetes` VALUES (1,'Le rugissement du roi','Affrontez le Rathalos dans la forêt ancienne.','Difficile',12000),(2,'Chasse aquatique','Terrassez le Lagiacrus dans les mers calmes.','Moyenne',8000),(3,'Chasseur des glaces','Affrontez le Barioth dans la toundra gelée.','Difficile',10000),(4,'Le feu du volcan','Eliminez le Teostra dans le volcan.','Expert',15000),(5,'Rage du Tigrex','Combattez le Tigrex dans la forêt.','Moyenne',9000);
/*!40000 ALTER TABLE `Quetes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Quetes_Monstres`
--

DROP TABLE IF EXISTS `Quetes_Monstres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Quetes_Monstres` (
  `id_quete` int NOT NULL,
  `id_monstre` int NOT NULL,
  PRIMARY KEY (`id_quete`,`id_monstre`),
  KEY `id_monstre` (`id_monstre`),
  CONSTRAINT `quetes_monstres_ibfk_1` FOREIGN KEY (`id_quete`) REFERENCES `Quetes` (`id_quete`),
  CONSTRAINT `quetes_monstres_ibfk_2` FOREIGN KEY (`id_monstre`) REFERENCES `Monstres` (`id_monstre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quetes_Monstres`
--

LOCK TABLES `Quetes_Monstres` WRITE;
/*!40000 ALTER TABLE `Quetes_Monstres` DISABLE KEYS */;
INSERT INTO `Quetes_Monstres` VALUES (1,1),(2,2),(5,3),(3,4),(4,5);
/*!40000 ALTER TABLE `Quetes_Monstres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Types_Monstres`
--

DROP TABLE IF EXISTS `Types_Monstres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Types_Monstres` (
  `id_type` int NOT NULL AUTO_INCREMENT,
  `nom_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Types_Monstres`
--

LOCK TABLES `Types_Monstres` WRITE;
/*!40000 ALTER TABLE `Types_Monstres` DISABLE KEYS */;
INSERT INTO `Types_Monstres` VALUES (1,'Wyverne volante'),(2,'Dragon ancien'),(3,'Amphibien'),(4,'Bête à crocs'),(5,'Léviathan');
/*!40000 ALTER TABLE `Types_Monstres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Utilisateurs`
--

DROP TABLE IF EXISTS `Utilisateurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Utilisateurs` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_creation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` int DEFAULT NULL,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Utilisateurs`
--

LOCK TABLES `Utilisateurs` WRITE;
/*!40000 ALTER TABLE `Utilisateurs` DISABLE KEYS */;
INSERT INTO `Utilisateurs` VALUES (1,'Alice','alice@example.com','1234','2025-11-13 17:12:48',1),(2,'Bob','bob@example.com','hunter1','2025-11-13 17:12:48',1),(3,'Charlie','charlie@example.com','MHrocks','2025-11-13 17:12:48',1),(4,'Diana','diana@example.com','password','2025-11-13 17:12:48',1),(5,'Ethan','ethan@example.com','securepass','2025-11-13 17:12:48',1),(6,'Nicolas','nicodec@hotmail.be','Administrator','2025-11-13 17:29:08',2);
/*!40000 ALTER TABLE `Utilisateurs` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-15  9:04:18
