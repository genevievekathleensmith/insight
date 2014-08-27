-- MySQL dump 10.13  Distrib 5.6.15, for osx10.9 (x86_64)
--
-- Host: localhost    Database: FCC
-- ------------------------------------------------------
-- Server version	5.6.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `states`
--

USE FCC;

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `states` (
  `index` bigint(20) DEFAULT NULL,
  `state` varchar(63) DEFAULT NULL,
  `comment_rate` float DEFAULT NULL,
  `sentiment_score` float DEFAULT NULL,
  `duplication_rate` float DEFAULT NULL,
  `party` varchar(63) DEFAULT NULL,
  `rank` bigint(20) DEFAULT NULL,
  `average` varchar(63) DEFAULT NULL,
  `sent_average` varchar(63) DEFAULT NULL,
  `full_name` varchar(63) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (0,'AK',1.73524,0.104124,0.67732,'republican',6,'above','below','Alaska'),(1,'AL',0.584198,0.210374,0.537337,'republican',49,'below','above','Alabama'),(2,'AR',0.610259,0.204345,0.512176,'republican',47,'below','above','Arkansas'),(3,'AZ',1.2839,0.218849,0.562511,'republican',13,'above','above','Arizona'),(4,'CA',1.35201,0.136222,0.501621,'democrat',10,'above','below','California'),(5,'CO',1.63393,0.16972,0.487716,'democrat',7,'above','below','Colorado'),(6,'CT',0.962565,0.180553,0.532229,'democrat',26,'below','below','Connecticut'),(7,'DC',2.58333,0.204615,0.700579,'democrat',1,'above','above','D.C.'),(8,'DE',1.31912,0.151167,0.647715,'democrat',12,'above','below','Delaware'),(9,'FL',0.818036,0.201384,0.482441,'democrat',40,'below','above','Florida'),(10,'GA',0.737566,0.189807,0.513706,'republican',44,'below','above','Georgia'),(11,'HI',1.00915,0.12424,0.491387,'democrat',22,'below','below','Hawaii'),(12,'IA',0.881378,0.193093,0.564399,'democrat',31,'below','above','Iowa'),(13,'ID',0.990144,0.247972,0.547473,'republican',24,'below','above','Idaho'),(14,'IL',0.988201,0.148671,0.507776,'democrat',25,'below','below','Illinois'),(15,'IN',0.817395,0.172898,0.508069,'republican',41,'below','below','Indiana'),(16,'KS',0.865297,0.24499,0.555673,'republican',34,'below','above','Kansas'),(17,'KY',0.739869,0.167419,0.521201,'republican',43,'below','below','Kentucky'),(18,'LA',0.570062,0.213549,0.472422,'republican',50,'below','above','Louisiana'),(19,'MA',1.45703,0.145828,0.52678,'democrat',9,'above','below','Massachusetts'),(20,'MD',1.07862,0.187238,0.58368,'democrat',20,'below','above','Maryland'),(21,'ME',1.49674,0.114973,0.507472,'democrat',8,'above','below','Maine'),(22,'MI',0.919224,0.184018,0.488588,'democrat',29,'below','below','Michigan'),(23,'MN',1.13053,0.16692,0.540323,'democrat',17,'above','below','Minnesota'),(24,'MO',0.862854,0.233088,0.512123,'republican',36,'below','above','Missouri'),(25,'MS',0.431643,0.246165,0.489144,'republican',51,'below','above','Mississippi'),(26,'MT',1.1992,0.22275,0.492802,'republican',15,'above','above','Montana'),(27,'NC',0.826749,0.192969,0.522526,'republican',38,'below','above','North Carolina'),(28,'ND',0.830292,0.255228,0.562637,'republican',37,'below','above','North Dakota'),(29,'NE',0.878788,0.181211,0.532759,'republican',32,'below','below','Nebraska'),(30,'NH',1.79531,0.171394,0.627825,'democrat',5,'above','below','New Hampshire'),(31,'NJ',0.87601,0.160211,0.519411,'democrat',33,'below','below','New Jersey'),(32,'NM',1.32653,0.119183,0.451282,'democrat',11,'above','below','New Mexico'),(33,'NV',1.00474,0.204109,0.530217,'democrat',23,'below','above','Nevada'),(34,'NY',1.15963,0.132941,0.504764,'democrat',16,'above','below','New York'),(35,'OH',0.862994,0.196294,0.52093,'democrat',35,'below','above','Ohio'),(36,'OK',0.681047,0.249487,0.554954,'republican',46,'below','above','Oklahoma'),(37,'OR',2.11637,0.138316,0.506278,'democrat',2,'above','below','Oregon'),(38,'PA',0.938438,0.16437,0.505782,'democrat',27,'below','below','Pennsylvania'),(39,'RI',1.01691,0.142798,0.490499,'democrat',21,'below','below','Rhode Island'),(40,'SC',0.609304,0.244607,0.54491,'republican',48,'below','above','South Carolina'),(41,'SD',1.09121,0.218515,0.68806,'republican',18,'above','above','South Dakota'),(42,'TN',0.820682,0.190193,0.506702,'republican',39,'below','above','Tennessee'),(43,'TX',0.80035,0.203909,0.505532,'republican',42,'below','above','Texas'),(44,'UT',1.20839,0.230708,0.543296,'republican',14,'above','above','Utah'),(45,'VA',1.08594,0.190327,0.547886,'democrat',19,'below','above','Virginia'),(46,'VT',1.93834,0.164256,0.552684,'democrat',4,'above','below','Vermont'),(47,'WA',2.00344,0.14435,0.537906,'democrat',3,'above','below','Washington'),(48,'WI',0.932161,0.181966,0.520309,'democrat',28,'below','below','Wisconsin'),(49,'WV',0.6875,0.154143,0.465035,'republican',45,'below','below','West Virginia'),(50,'WY',0.911111,0.225892,0.465854,'republican',30,'below','above','Wyoming');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-25 11:35:00