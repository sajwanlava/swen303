CREATE TABLE BANKS(
BankName VARCHAR(25) NOT NULL, 
City VARCHAR(15) NOT NULL,
NoAccounts INT CONSTRAINT noAccountsChk CHECK (NoAccounts >= 0),
Security VARCHAR(10) DEFAULT ‘weak’ CONSTRAINT securityChk CHECK (Security IN(‘weak’, ‘good’, ‘very good’, ‘excellent’)), 
CONSTRAINT bpk PRIMARY KEY (BankName, City)
);

CREATE TABLE ROBBERIES(
BankName VARCHAR(25) NOT NULL,
City VARCHAR(15) NOT NULL,
Date DATE NOT NULL,
Amount DECIMAL CONSTRAINT amountChk CHECK (Amount >=0),
CONSTRAINT rpk PRIMARY KEY (BankName, City, Date),
CONSTRAINT rfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE PLANS(
BankName VARCHAR(25) NOT NULL,
City VARCHAR(15) NOT NULL,
PlannedDate DATE NOT NULL,
NoRobbers INT CONSTRAINT NoRobbersChk CHECK (NoRobbers >=1),
CONSTRAINT ppk PRIMARY KEY ( BankName, City, PlannedDate),
CONSTRAINT pfk FOREIGN KEY (BankName, City)  REFERENCES BANKS (BankName, City) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ROBBERS(
RobberId SERIAL UNIQUE,
Nickname VARCHAR(20),
Age INT CONSTRAINT robbersAge CHECK (Age > 0),
NoYears INT CONSTRAINT totalYears CHECK (Age >= NoYears),
CONSTRAINT rbpk PRIMARY KEY (RobberID)
);
CREATE SEQUENCE robbers_robberID;
ALTER SEQUENCE robbers_robberID restart with 1;

CREATE TABLE SKILLS(
SkillID SERIAL PRIMARY KEY, 
Description VARCHAR(50) UNIQUE
);
CREATE SEQUENCE skills_skillsID;
ALTER SEQUENCE skills_skillsID restart with 1;

CREATE TABLE HASSKILLS(
RobberID INT NOT NULL,
SkillID INT NOT NULL,
Preference INT CONSTRAINT hasSkillsPreference CHECK (Preference>=1),
Grade VARCHAR(2) CONSTRAINT hasSkillsGrade CHECK (Grade IN('A+', 'A+ ', 'A', 'A ', 'B+', 'B+ ', 'B', 'B ','C+', 'C+ ', 'C', 'C ')),
CONSTRAINT hsrifk FOREIGN KEY (RobberID) REFERENCES ROBBERS (RobberId) ON UPDATE CASCADE ON DELETE CASCADE,
 CONSTRAINT hssifk FOREIGN KEY (SkillID) REFERENCES SKILLS (SkillID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE HASACCOUNTS(
RobberID INT NOT NULL,
BankName VARCHAR(25) NOT NULL,
City VARCHAR(15) NOT NULL,
CONSTRAINT hafk FOREIGN KEY (RobberID) REFERENCES ROBBERS(RobberID) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT habfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ACCOMPLICES(
RobberID INT NOT NULL,
BankName VARCHAR(25) NOT NULL,
City VARCHAR(15) NOT NULL,
RobberyDate DATE NOT NULL,
Share REAL CONSTRAINT accomplicesShare CHECK (Share >= 0),
CONSTRAINT afk FOREIGN KEY (RobberID) REFERENCES ROBBERS (RobberID) ON UPDATE CASCADE ON DELETE NO ACTION,
CONSTRAINT abfk FOREIGN KEY (BankName, City, RobberyDate) REFERENCES ROBBERIES (BankName, City, Date) ON UPDATE CASCADE ON DELETE NO ACTION
);
