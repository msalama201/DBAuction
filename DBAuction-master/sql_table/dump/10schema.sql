CREATE DATABASE  IF NOT EXISTS `Auction` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `Auction`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: auctiondb.cbtlxellt5gi.us-east-2.rds.amazonaws.com    Database: Auction
-- ------------------------------------------------------
-- Server version	5.6.39-log

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
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account` (
  `accID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userID` int(10) DEFAULT NULL,
  `username` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `pword` varchar(50) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `rating` int(11) DEFAULT '0',
  PRIMARY KEY (`accID`),
  UNIQUE KEY `username` (`username`),
  KEY `Account_ibfk_1` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AuctionT`
--

DROP TABLE IF EXISTS `AuctionT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuctionT` (
  `auctionID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isbn` varchar(13) DEFAULT NULL,
  `accID` int(10) unsigned DEFAULT NULL,
  `min_sell` decimal(15,2) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `min_bid` decimal(15,2) unsigned DEFAULT '1.00',
  PRIMARY KEY (`auctionID`),
  KEY `AuctionT_ibfk_1` (`accID`),
  KEY `AuctionT_ibfk_2_idx` (`isbn`),
  CONSTRAINT `AuctionT_ibfk_1` FOREIGN KEY (`accID`) REFERENCES `Account` (`accID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `AuctionT_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `Books` (`isbn`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Auto_Bids`
--

DROP TABLE IF EXISTS `Auto_Bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Auto_Bids` (
  `accID` int(10) unsigned NOT NULL,
  `auctionID` int(10) unsigned NOT NULL,
  `max_bid` decimal(15,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`accID`,`auctionID`),
  KEY `Auto_Bids_ibfk_2` (`auctionID`),
  CONSTRAINT `Auto_Bids_ibfk_1` FOREIGN KEY (`accID`) REFERENCES `Account` (`accID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Auto_Bids_ibfk_2` FOREIGN KEY (`auctionID`) REFERENCES `AuctionT` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Bids`
--

DROP TABLE IF EXISTS `Bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bids` (
  `accID` int(10) unsigned NOT NULL DEFAULT '0',
  `auctionID` int(10) unsigned NOT NULL DEFAULT '0',
  `bid_amount` decimal(15,2) unsigned DEFAULT NULL,
  `winner` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`auctionID`,`accID`),
  KEY `Bids_ibfk_2` (`accID`),
  CONSTRAINT `Bids_ibfk_1` FOREIGN KEY (`auctionID`) REFERENCES `AuctionT` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Books` (
  `isbn` varchar(13) NOT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Email`
--

DROP TABLE IF EXISTS `Email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Email` (
  `emailID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accID` int(10) unsigned NOT NULL,
  `staffID` int(10) unsigned DEFAULT '0',
  `subject` varchar(50) DEFAULT NULL,
  `timeSent` datetime DEFAULT CURRENT_TIMESTAMP,
  `content` text,
  PRIMARY KEY (`emailID`),
  KEY `Email_ibfk_1` (`accID`),
  KEY `Email_ibfk_2` (`staffID`),
  CONSTRAINT `Email_ibfk_1` FOREIGN KEY (`accID`) REFERENCES `Account` (`accID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `Email_ibfk_2` FOREIGN KEY (`staffID`) REFERENCES `Staff` (`staffID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Genre_Award`
--

DROP TABLE IF EXISTS `Genre_Award`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Genre_Award` (
  `isbn` varchar(13) NOT NULL,
  `fantasy` bit(1) DEFAULT b'0',
  `scifi` bit(1) DEFAULT b'0',
  `thriller` bit(1) DEFAULT b'0',
  `comic` bit(1) DEFAULT b'0',
  `youngAdult` bit(1) DEFAULT b'0',
  `drama` bit(1) DEFAULT b'0',
  `romance` bit(1) DEFAULT b'0',
  `historical` bit(1) DEFAULT b'0',
  `biography` bit(1) DEFAULT b'0',
  `arts` bit(1) DEFAULT b'0',
  `tech` bit(1) DEFAULT b'0',
  `food` bit(1) DEFAULT b'0',
  `diy` bit(1) DEFAULT b'0',
  `outdoor` bit(1) DEFAULT b'0',
  `health` bit(1) DEFAULT b'0',
  `religion` bit(1) DEFAULT b'0',
  `naturalScience` bit(1) DEFAULT b'0',
  `socialScience` bit(1) DEFAULT b'0',
  `award_title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`isbn`),
  CONSTRAINT `Genre_Award_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `Books` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `QnA`
--

DROP TABLE IF EXISTS `QnA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QnA` (
  `qID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accID` int(10) unsigned NOT NULL,
  `auctionID` int(10) unsigned NOT NULL,
  `question` tinytext,
  `answer` tinytext,
  `qTime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `aTime` datetime DEFAULT NULL,
  PRIMARY KEY (`qID`),
  KEY `QnA_ibfk_1` (`auctionID`),
  KEY `QnA_ibfk_2` (`accID`),
  CONSTRAINT `QnA_ibfk_1` FOREIGN KEY (`auctionID`) REFERENCES `AuctionT` (`auctionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `QnA_ibfk_2` FOREIGN KEY (`accID`) REFERENCES `Account` (`accID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Question` (
  `questionID` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(300) DEFAULT NULL,
  `staffID` int(11) DEFAULT NULL,
  `answer` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`questionID`),
  KEY `1_idx` (`staffID`),
  CONSTRAINT `1` FOREIGN KEY (`staffID`) REFERENCES `StaffAcc` (`staffAccID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Staff` (
  `staffID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nameUser` varchar(20) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`staffID`),
  UNIQUE KEY `username_UNIQUE` (`nameUser`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `StaffAcc`
--

DROP TABLE IF EXISTS `StaffAcc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StaffAcc` (
  `staffAccID` int(11) NOT NULL AUTO_INCREMENT,
  `staffID` int(10) unsigned DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `pword` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`staffAccID`),
  KEY `2_idx` (`staffID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `userID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nameUser` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Wish`
--

DROP TABLE IF EXISTS `Wish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Wish` (
  `wID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accID` int(10) unsigned NOT NULL,
  `isbn` varchar(13) DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `award_title` varchar(100) DEFAULT NULL,
  `minBid` decimal(15,2) unsigned DEFAULT NULL,
  `maxBid` decimal(15,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`wID`),
  KEY `Wish_ibfk_1` (`accID`),
  CONSTRAINT `Wish_ibfk_1` FOREIGN KEY (`accID`) REFERENCES `Account` (`accID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-09 15:03:35
