DROP DATABASE IF EXISTS guest;

CREATE DATABASE IF NOT EXISTS guest;

USE guest;

DROP TABLE IF EXISTS `COUNTRY`;

CREATE TABLE COUNTRY (
  `CountryId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
   PRIMARY KEY (`CountryId`)
  );
  
DROP TABLE IF EXISTS `LOCATION`;

CREATE TABLE LOCATION (
  `LocationId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `CountryId` int(11),
   PRIMARY KEY (`LocationId`),
   CONSTRAINT `location_ibfk_1` FOREIGN KEY (`CountryId`) REFERENCES `COUNTRY` (`CountryId`) ON UPDATE CASCADE
  );

DROP TABLE IF EXISTS `INDUSTRY`;

CREATE TABLE INDUSTRY (
  `IndustryId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
   PRIMARY KEY (`IndustryId`)
  );


DROP TABLE IF EXISTS `COMPANY`;

CREATE TABLE COMPANY (
  `CompanyId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
   PRIMARY KEY (`CompanyId`)
  );

DROP TABLE IF EXISTS `COMPANY_INDUSTRY`;

CREATE TABLE COMPANY_INDUSTRY (
  `CompanyId` int(11),
  `IndustryId` int(11)
 );

DROP TABLE IF EXISTS `BRANCH`;

CREATE TABLE BRANCH (
  `BranchId` int(11) NOT NULL AUTO_INCREMENT,
  `Headquarter` bit NOT NULL DEFAULT (0),
  `CompanyId` int(11),
  `LocationId` int(11),
   PRIMARY KEY (`BranchId`),
   KEY `CompanyId` (`CompanyId`),
   KEY `LocationId` (`LocationId`),
   CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`CompanyId`) REFERENCES `COMPANY` (`CompanyId`) ON UPDATE CASCADE,
   CONSTRAINT `branch_ibfk_2` FOREIGN KEY (`LocationId`) REFERENCES `LOCATION` (`LocationId`) ON UPDATE CASCADE    
  );


DROP TABLE IF EXISTS `LAYOFF`;

CREATE TABLE LAYOFF(
  `LayoffId` int(11) AUTO_INCREMENT,
  `BranchId` int(11) NOT NULL,
  `FundsRaised` int(11) NOT NULL,
  `WorkersLaid` int(11) NOT NULL,
  `Percentage` float(6) NOT NULL,
   `Date` DATE NOT NULL,
   PRIMARY KEY (`LayoffId`),
   KEY `BranchId` (`BranchId`),

   CONSTRAINT `layoff_ibfk_1` FOREIGN KEY (`BranchId`) REFERENCES `BRANCH` (`BranchId`) ON UPDATE CASCADE
  );


