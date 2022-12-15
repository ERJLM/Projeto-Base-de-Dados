DROP TABLE IF EXISTS `COMPANY`;

CREATE TABLE COMPANY (
  `CompanyId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `IndustryId` int(11),
   PRIMARY KEY (`CompanyId`),
   KEY `IndustryId` (`IndustyId`),
   
   CONSTRAINT `company_ibfk_1` FOREIGN KEY (`IndustryId`) REFERENCES `INDUSTRY` (`IndustyId`) ON UPDATE CASCADE  
  )

DROP TABLE IF EXISTS `COMPANY_INDUSTRY`;

CREATE TABLE COMPANY_INDUSTRY (
  `CompanyId` int(11) NOT NULL,
  `IndustryId` int(11)NOT NULL,
   PRIMARY KEY (`CompanyId`),
   PRIMARY KEY (`IndustyId`),
   
   CONSTRAINT `company_industry_ibfk_1` FOREIGN KEY (`CompanyId`) REFERENCES `INDUSTRY` (`CompanyId`) ON UPDATE CASCADE,
   CONSTRAINT `company_industry_ibfk_2` FOREIGN KEY (`IndustryId`) REFERENCES `INDUSTRY` (`IndustyId`) ON UPDATE CASCADE  
  )

DROP TABLE IF EXISTS `HEADQUARTER`;

CREATE TABLE HEADQUARTER (
  `HeadquarterId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `CompanyId` int(11),
  `LocationId` int(11),
   PRIMARY KEY (`HeadquarterId`),
   KEY `CompanyId` (`CompanyId`),
   
   CONSTRAINT `headquarter_ibfk_1` FOREIGN KEY (`CompanyId`) REFERENCES `COMPANY` (`CompanyId`) ON UPDATE CASCADE,
   CONSTRAINT `headquarter_ibfk_2` FOREIGN KEY (`LocationId`) REFERENCES `LOCATION` (`LocationId`) ON UPDATE CASCADE    
  )


DROP TABLE IF EXISTS `LAYOFF`;

CREATE TABLE LAYOFF(
  `LayoffId` int(11) AUTO_INCREMENT,
  `HeadquarterId` int(11) NOT NULL,
  `FundsRaised` int(11) NOT NULL,
  `WorkersLaid` int(11) NOT NULL,
  `Percentage` float(2,6) NOT NULL,
   `Date` DATE NOT NULL,
   PRIMARY KEY (`LayoffId`),
   KEY `HeadquarterId` (`HeadquarterId`),

   CONSTRAINT `layoff_ibfk_1` FOREIGN KEY (`HeadquarterId`) REFERENCES `HEADQUARTER` (`HeadquarterId`) ON UPDATE CASCADE
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
   CONSTRAINT `location_ibfk_1` FOREIGN KEY (`CountryId`) REFERENCES `COUNTRY` (`CountryId`) ON UPDATE CASCADE
  )

DROP TABLE IF EXISTS `INDUSTRY`;

CREATE TABLE INDUSTRY (
  `IndustryId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
   PRIMARY KEY (`IndustryId`),
  )
