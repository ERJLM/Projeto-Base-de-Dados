DROP TABLE IF EXISTS `COMPANY`;

CREATE TABLE COMPANY (
  `CompanyId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `IndustryId` int(11),
  `FundsRaised` float(11,4) NOT NULL,
  `StageId` int(11) ,
  `LocationId` int(11) ,
  `CountryId` int(11),
   PRIMARY KEY (`CompanyId`),
   KEY `IndustryId` (`IndustyId`),
   KEY `StageId` (`StageId`),
   KEY `LocationId` (`LocationID`),
   CONSTRAINT `company_ibfk_1` FOREIGN KEY (`IndustryId`) REFERENCES `INDUSTRY` (`IndustyId`) ON UPDATE CASCADE,
   CONSTRAINT `company_ibfk_2` FOREIGN KEY (`StageId`) REFERENCES `STAGE` (`StageId`) ON UPDATE CASCADE,
   CONSTRAINT `company_ibfk_3` FOREIGN KEY (`LocationId`) REFERENCES `LOCATION` (`LocationId`) ON UPDATE CASCADE
  )


DROP TABLE IF EXISTS `LAYOFF`;

CREATE TABLE LAYOFF(
  `LayoffId` int(11) AUTO_INCREMENT,
  `CompanyId` int(11),
  `LocationId` int(11) ,
  `WorkersLaid` int(11) NOT NULL,
  `Percentage` float(1,6) NOT NULL,
   `Date` DATE NOT NULL,
   PRIMARY KEY (`LayoffId`),
   CONSTRAINT `company_ibfk_1` FOREIGN KEY (`CompanyId`) REFERENCES `COMPANY` (`CompanyId`) ON UPDATE CASCADE
   CONSTRAINT `company_ibfk_2` FOREIGN KEY (`LocationId`) REFERENCES `LOCATION` (`LocationId`) ON UPDATE CASCADE,
  )
  
   DROP TABLE IF EXISTS `COUNTRY`;

CREATE TABLE COUNTRY (
  `CountryId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
   PRIMARY KEY (`CountryId`),
  )
  
  DROP TABLE IF EXISTS `LOCATION`;

CREATE TABLE LOCATION (
  `LocationId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `CountryId` int(11),
   PRIMARY KEY (`LocationId`),
   CONSTRAINT `company_ibfk_1` FOREIGN KEY (`CountryId`) REFERENCES `COUNTRY` (`CountryId`) ON UPDATE CASCADE
  )
  
   DROP TABLE IF EXISTS `STAGE`;

CREATE TABLE STAGE (
  `StageId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
   PRIMARY KEY (`StageId`),
  )

DROP TABLE IF EXISTS `INDUSTRY`;

CREATE TABLE INDUSTRY (
  `IndustryId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
   PRIMARY KEY (`IndustryId`),
  )
