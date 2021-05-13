/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 5.7.33-log : Database - ordertracker
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ordertracker` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ordertracker`;

/*Table structure for table `country` */

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `country_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `code` varchar(8) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `country` */

insert  into `country`(`country_id`,`name`,`code`,`active`) values 
(1,'United States','USA',1);

/*Table structure for table `state` */

DROP TABLE IF EXISTS `state`;

CREATE TABLE `state` (
  `state_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `code` varchar(8) DEFAULT NULL,
  `countryId` int(11) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`state_id`),
  KEY `countryId` (`countryId`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

/*Data for the table `state` */

insert  into `state`(`state_id`,`name`,`code`,`countryId`,`active`) values 
(1,'Alabama','AL',1,1),
(2,'Alaska','AK',1,1),
(3,'Arizona','AZ',1,1),
(4,'Arkansas','AR',1,1),
(5,'California','CA',1,1),
(6,'Colorado','CO',1,1),
(7,'Connecticut','CT',1,1),
(8,'Delaware','DE',1,1),
(9,'District of Columbia','DC',1,1),
(10,'Florida','FL',1,1),
(11,'Georgia','GA',1,1),
(12,'Hawaii','HI',1,1),
(13,'Idaho','ID',1,1),
(14,'Illinois','IL',1,1),
(15,'Indiana','IN',1,1),
(16,'Iowa','IA',1,1),
(17,'Kansas','KS',1,1),
(18,'Kentucky','KY',1,1),
(19,'Louisiana','LA',1,1),
(20,'Maine','ME',1,1),
(21,'Maryland','MD',1,1),
(22,'Massachusetts','MA',1,1),
(23,'Michigan','MI',1,1),
(24,'Minnesota','MN',1,1),
(25,'Mississippi','MS',1,1),
(26,'Missouri','MO',1,1),
(27,'Montana','MT',1,1),
(28,'Nebraska','NE',1,1),
(29,'Nevada','NV',1,1),
(30,'NEW Hampshire','NH',1,1),
(31,'NEW Jersey','NJ',1,1),
(32,'NEW Mexico','NM',1,1),
(33,'NEW York','NY',1,1),
(34,'North Carolina','NC',1,1),
(35,'North Dakota','ND',1,1),
(36,'Ohio','OH',1,1),
(37,'Oklahoma','OK',1,1),
(38,'Oregon','OR',1,1),
(39,'Pennsylvania','PA',1,1),
(40,'Rhode Island','RI',1,1),
(41,'South Carolina','SC',1,1),
(42,'South Dakota','SD',1,1),
(43,'Tennessee','TN',1,1),
(44,'Texas','TX',1,1),
(45,'Utah','UT',1,1),
(46,'Vermont','VT',1,1),
(47,'Virginia','VA',1,1),
(48,'Washington','WA',1,1),
(49,'West Virginia','WV',1,1),
(50,'Wisconsin','WI',1,1),
(51,'Wyoming','WY',1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
