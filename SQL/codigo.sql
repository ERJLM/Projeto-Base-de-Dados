DROP TABLE IF EXISTS `COMPANY`;

CREATE TABLE COMPANY (
  `CompanyId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `IndustryId` int(11),
  `Funds Raised(in Millions)` int(11) NOT NULL,
  `StageId` int(11),
  `LocationId` int(11) ,
  `CountryId` int(11),
   PRIMARY KEY (`CompanyId`);
   
  )


DROP TABLE IF EXISTS `LAYOFF`;

CREATE TABLE LAYOFF(
  `LayoffId` int(11) AUTO_INCREMENT;
  `CompanyId` int(11) FOREIGN KEY;
  `WorkersLaid` int(11) NOT NULL;
  `Percentage` float(11,2) NOT NULL;
   `Date` DATE NOT NULL;
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
   
  )
  
   DROP TABLE IF EXISTS `STAGE`;

CREATE TABLE STAGE (
  `StageId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
   PRIMARY KEY (`StageId`),
  )
