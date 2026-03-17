-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: pizzeria
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Regina Ruiz','Monterosa #205','4778561236'),(2,'Salvador Torres','Cima','4775624178'),(3,'Maribel Lopez','Isla Mindanao','4772153187'),(4,'José Hernández','Naranja 106','4775624190'),(5,'Luis Galvan','Limones #108','4772158496'),(6,'Daniela Gomez','Cima Plus #130','4793568472'),(7,'Regina Ruiz','Monterosa #205','4778561236'),(8,'Roberto Gonzalez','Privada #106','4798546321'),(9,'Cristian Torres','Isla Sumatra #322','4775678439'),(10,'Carmen Garcia','Isla Mindanao #118','4776185279'),(11,'Yuliana Martinez','Calle del Trancazo #204','4775648271'),(12,'Roberto Padilla','Rayando el Sol #16','4776328479'),(13,'Javier Delgado','Maremoto #302','4798201045'),(14,'Jesús Ramirez','Salsipuedes #50','4771348272'),(15,'Maria Lopez','La Favorita #215','4774873641'),(16,'Valeria Gonzalez','Isla Contoy #228','4796841237'),(17,'Juan Hernández','Isla Sumatra #102','4776781245');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_pedido`
--

DROP TABLE IF EXISTS `detalle_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_pedido` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_pizza` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_pizza` (`id_pizza`),
  CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`id_pizza`) REFERENCES `pizzas` (`id_pizza`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_pedido`
--

LOCK TABLES `detalle_pedido` WRITE;
/*!40000 ALTER TABLE `detalle_pedido` DISABLE KEYS */;
INSERT INTO `detalle_pedido` VALUES (1,1,1,1,40.00),(2,1,2,1,150.00),(3,2,3,2,300.00),(4,3,4,1,60.00),(5,3,5,1,110.00),(6,4,6,3,330.00),(7,5,7,1,100.00),(8,6,8,3,450.00),(9,7,9,1,100.00),(10,7,10,1,40.00),(11,8,11,1,150.00),(12,8,12,1,100.00),(13,8,13,2,80.00),(14,9,14,1,100.00),(15,9,15,1,40.00),(16,10,16,2,300.00),(17,10,17,1,40.00),(18,11,18,1,140.00),(19,12,19,1,40.00),(20,12,20,1,100.00),(21,13,21,2,300.00),(22,14,22,1,110.00),(23,14,23,1,40.00),(24,15,24,1,40.00),(25,15,25,1,110.00),(26,16,26,2,300.00),(27,16,27,1,40.00),(28,17,28,1,140.00),(29,17,29,1,80.00);
/*!40000 ALTER TABLE `detalle_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `fecha` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,'2025-08-25',190.00),(2,2,'2026-03-15',300.00),(3,3,'2025-01-12',170.00),(4,4,'2026-01-25',330.00),(5,5,'2026-02-10',100.00),(6,6,'2026-03-04',450.00),(7,7,'2026-03-12',140.00),(8,8,'2026-01-23',330.00),(9,9,'2025-04-07',140.00),(10,10,'2025-05-20',340.00),(11,11,'2025-06-06',140.00),(12,12,'2025-07-31',140.00),(13,13,'2025-08-17',300.00),(14,14,'2025-09-17',150.00),(15,15,'2025-10-30',150.00),(16,16,'2025-11-08',340.00),(17,17,'2025-12-14',220.00);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzas`
--

DROP TABLE IF EXISTS `pizzas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzas` (
  `id_pizza` int NOT NULL AUTO_INCREMENT,
  `tamano` varchar(20) DEFAULT NULL,
  `ingredientes` varchar(200) DEFAULT NULL,
  `precio` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id_pizza`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzas`
--

LOCK TABLES `pizzas` WRITE;
/*!40000 ALTER TABLE `pizzas` DISABLE KEYS */;
INSERT INTO `pizzas` VALUES (1,'Chica','Queso',40.00),(2,'Grande','Jamon, Piña, Champiñones',150.00),(3,'Grande','Jamon, Piña, Champiñones',300.00),(4,'Chica','Jamon, Piña',60.00),(5,'Mediana','Jamon, Piña, Champiñones',110.00),(6,'Mediana','Jamon, Piña, Champiñones',330.00),(7,'Mediana','Jamon, Piña',100.00),(8,'Grande','Jamon, Piña, Champiñones',450.00),(9,'Mediana','Jamon, Piña',100.00),(10,'Chica','Queso',40.00),(11,'Grande','Jamon, Piña, Champiñones',150.00),(12,'Mediana','Jamon, Piña',100.00),(13,'Chica','Queso',80.00),(14,'Mediana','Jamon, Piña',100.00),(15,'Chica','Queso',40.00),(16,'Grande','Jamon, Piña, Champiñones',300.00),(17,'Chica','Queso',40.00),(18,'Grande','Jamon, Piña',140.00),(19,'Chica','Queso',40.00),(20,'Mediana','Jamon, Champiñones',100.00),(21,'Grande','Jamon, Piña, Champiñones',300.00),(22,'Mediana','Jamon, Piña, Champiñones',110.00),(23,'Chica','Queso',40.00),(24,'Chica','Queso',40.00),(25,'Mediana','Jamon, Piña, Champiñones',110.00),(26,'Grande','Jamon, Piña, Champiñones',300.00),(27,'Chica','Queso',40.00),(28,'Grande','Jamon, Piña',140.00),(29,'Mediana','Queso',80.00);
/*!40000 ALTER TABLE `pizzas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-17  8:32:45
