CREATE TABLE AIRPORT(
AIRPORT_NAME VARCHAR(20) NOT NULL,
 CITY VARCHAR(20),
 STATE VARCHAR(20),
PRIMARY KEY (AIRPORT_NAME)
);
CREATE TABLE AIRLINE(
AIRLINE_ID INT NOT NULL PRIMARY KEY,
AIRLINE_NAME VARCHAR(10),
AIRPORT_NAME VARCHAR(20),
FOREIGN KEY (AIRPORT_NAME) REFERENCES AIRPORT(AIRPORT_NAME)
);
CREATE TABLE CONTAINS(
AIRPORT_NAME VARCHAR(20),
 AIRLINE_ID INT,
FOREIGN KEY (AIRPORT_NAME) REFERENCES AIRPORT(AIRPORT_NAME),
FOREIGN KEY (AIRLINE_ID) REFERENCES AIRLINE(AIRLINE_ID)
);
CREATE TABLE FLIGHT(
FLIGHT_NO INT NOT NULL PRIMARY KEY,
SOURCE VARCHAR(20) NOT NULL,
DESTINATION VARCHAR(20) NOT NULL,
D_TIME DATE,
A_TIME DATE,
DURATION INT NOT NULL,
AIRLINE_ID INT,
FOREIGN KEY (AIRLINE_ID) REFERENCES AIRLINE(AIRLINE_ID)
);
CREATE TABLE EMPLOYEE(
E_ID INT PRIMARY KEY,
 NAME VARCHAR(20),
 ADDRESS VARCHAR(20),
 SEX VARCHAR(10),
 SALARY INT,
 AGE INT,
 AIRPORT_NAME VARCHAR(20),
 FOREIGN KEY (AIRPORT_NAME) REFERENCES AIRPORT(AIRPORT_NAME));
CREATE TABLE EMP_PHONE_NO(
 E_ID INT,
 PHONE_NO VARCHAR(11),
FOREIGN KEY (E_ID) REFERENCES EMPLOYEE(E_ID)
);
CREATE TABLE PASSENGER(
PASSPORT_NO VARCHAR(20) NOT NULL PRIMARY KEY,
NAME VARCHAR(20) NOT NULL,
ADDRESS VARCHAR(20),
SEX VARCHAR(5),
DOB DATE,
AGE INT,
FLIGHT_NO INT,
TICKET_NO VARCHAR(20),
FOREIGN KEY (FLIGHT_NO) REFERENCES FLIGHT(FLIGHT_NO));
CREATE TABLE SERVES(
E_ID INT,
PASSPORT_NO VARCHAR(20),
FOREIGN KEY (E_ID) REFERENCES EMPLOYEE(E_ID),
FOREIGN KEY (PASSPORT_NO) REFERENCES PASSENGER(PASSPORT_NO)
);
CREATE TABLE PASSENGER_PHONE_NO(
PASSPORT_NO VARCHAR(20),
PHONE_NO VARCHAR(11),
FOREIGN KEY (PASSPORT_NO) REFERENCES PASSENGER(PASSPORT_NO));
CREATE TABLE TICKET(
TICKET_NO VARCHAR(20) NOT NULL PRIMARY KEY,
AIRLINE_NAME VARCHAR(20) NOT NULL,
PRICE INT NOT NULL,
SEAT_NO VARCHAR(20),
CLASS VARCHAR(5),
D_TIME Date,
A_TIME Date,
DURATION INT,
DESTINATION VARCHAR(20),
SOURCE VARCHAR(20),
PASSPORT_NO VARCHAR(20),
PASSENGER_NAME VARCHAR(20),
FOREIGN KEY (PASSPORT_NO) REFERENCES PASSENGER(PASSPORT_NO));
ALTER TABLE AIRPORT DROP COLUMN STATE;
ALTER TABLE AIRPORT ADD STATE VARCHAR(20);
ALTER TABLE AIRPORT RENAME COLUMN AIRPORT_NAME TO AIR_NAME;
ALTER TABLE AIRPORT RENAME TO AIRPORT_DETAILS;
ALTER TABLE AIRPORT_DETAILS RENAME TO AIRPORT;
ALTER TABLE AIRPORT RENAME COLUMN AIR_NAME TO AIRPORT_NAME;
INSERT INTO AIRPORT VALUES ('Shivaji', 'Mumbai', 'Maharashtra');
INSERT INTO AIRPORT VALUES ('Indra Gandhi Int', 'Delhi', 'Maharashtra');
SELECT * FROM AIRPORT;
INSERT INTO EMPLOYEE VALUES(13,'parth','mumbai','M',40000,19,'Shivaji');
INSERT INTO EMPLOYEE VALUES(14,'ramesh','mumbai','M',30000,20,'Shivaji');
INSERT INTO EMPLOYEE VALUES(15,'ram','delhi','M',20000,23,'Indra Gandhi Int');
INSERT INTO EMPLOYEE VALUES(16,'rani','delhi','F',22000,19,'Indra Gandhi Int');
select * from EMPLOYEE;
INSERT INTO EMP_PHONE_NO VALUES(13,'1111111111');
INSERT INTO EMP_PHONE_NO VALUES(14,'3333333333');
INSERT INTO EMP_PHONE_NO VALUES(16,'6666666666');
select * from EMP_PHONE_NO;
INSERT INTO AIRLINE VALUES(123,'MLines','Shivaji');
INSERT INTO AIRLINE VALUES(124,'Dlines','Indra Gandhi Int');
select * from AIRLINE;
INSERT INTO FLIGHT VALUES(12345,'Mumbai','Delhi', to_date('20-FEB-2022 4:00 am','dd-mon-yyyy hh:mi am'),to_date('20-feb-2022 8:30 am','dd-mon-yyyy hh:mi am'),360,123);
INSERT INTO FLIGHT VALUES(12356,'Delhi', 'Mumbai', to_date('20-02-2022 10:00 pm','dd-mm-yyyy hh:mi am'),to_date('21-02-2022 4:00 am','dd-mm-yyyy hh:mi am'), 180,123);
INSERT INTO FLIGHT VALUES(12389,'Delhi', 'Mumbai', to_date('24-02-2022 9:15 am','dd-mm-yyyy hh:mi am'),to_date('25-02-2022 9:30 am','dd-mm-yyyy hh:mi am'), 150,123);
select * from FLIGHT;
INSERT INTO PASSENGER VALUES(123,'Parth','A22','Male',date'2002-03-28',5,'12356','786');
INSERT INTO PASSENGER VALUES(456, 'Tushar', 'B22', 'Male', date'2001-08-12', 19, '12345', '777');
INSERT INTO PASSENGER VALUES(789, 'Raj', 'D45', 'Male', date'1972-06-13', 64, '12345', '786');
SELECT * from PASSENGER;
INSERT INTO TICKET VALUES('786', 'SpiceJet', 6000,'A-2','First',to_date('20-FEB-2022 4:00
am','dd-mon-yyyy hh:mi am'),to_date('20-feb-2022 8:30 am','dd-mon-yyyy hh:mi am'),5,
'banglore','delhi',123,'Parth');
INSERT INTO TICKET VALUES('777', 'Mumbai Airlines',4000,'H-42','Secon',to_date('24-02-2022
9:15 am','dd-mm-yyyy hh:mi am'),to_date('25-02-2022 9:30 am','dd-mm-yyyy hh:mi
am'),4,'goa','chandigarh',456,'Tushar');
select * from TICKET;
INSERT INTO PASSENGER_PHONE_NO VALUES(123,'1111');
INSERT INTO PASSENGER_PHONE_NO VALUES(456,'3333333333');
INSERT INTO PASSENGER_PHONE_NO VALUES(789,'6666666666');
select * from PASSENGER_PHONE_NO;
SELECT E.NAME, E.SALARY
FROM EMPLOYEE E
WHERE E_ID IN
(SELECT EP.E_ID
FROM EMP_PHONE_NO EP
WHERE EP.E_ID=E.E_ID);
select E.E_ID, E.NAME, E.SALARY
from EMPLOYEE E
where E.E_ID in
(select EP.E_ID
from EMP_PHONE_NO EP
where EP.E_ID in (1,5));
select E.NAME, E.E_ID
from EMPLOYEE E
where E.AIRPORT_NAME in
(select A.AIRPORT_NAME
from AIRPORT A
where A.CITY='mumbai');
SELECT E.E_ID, E.NAME, E.SEX
FROM EMPLOYEE E
WHERE E.E_ID IN (SELECT EP.E_ID
FROM EMP_PHONE_NO EP
WHERE E.E_ID = EP.E_ID AND EP.E_ID>=3);
SELECT E.NAME, E.E_ID
FROM EMPLOYEE E
WHERE E.E_ID IN
(SELECT EP.E_ID
FROM EMP_PHONE_NO EP
GROUP BY EP.E_ID
HAVING COUNT(*) > 1);
SELECT E.NAME, E.ADDRESS, E.AGE, E.SEX
FROM EMPLOYEE E
WHERE E.AIRPORT_NAME IN
(SELECT A.AIRPORT_NAME
FROM AIRPORT A
WHERE A.CITY in ('mumbai', 'delhi'));
SELECT P.NAME, P.PASSPORT_NO
FROM PASSENGER P
WHERE P.TICKET_NO IN
(SELECT T.TICKET_NO
FROM TICKET T
WHERE T.AIRLINE_NAME = 'Mumbai Airlines');
SELECT P.NAME, P.PASSPORT_NO
FROM PASSENGER P
WHERE P.TICKET_NO IN
(SELECT T.TICKET_NO
FROM TICKET T
WHERE T.CLASS = 'First Class');
SELECT P.NAME
FROM PASSENGER P
WHERE P.PASSPORT_NO IN
(SELECT PPN.PASSPORT_NO
FROM PASSENGER_PHONE_NO PPN
GROUP BY PPN.PASSPORT_NO
HAVING COUNT(*)>1);
SELECT P.NAME, P.SEX, P.TICKET_NO
FROM PASSENGER P
WHERE P.FLIGHT_NO IN
(SELECT F.FLIGHT_NO
FROM FLIGHT F
WHERE F.DESTINATION = 'Delhi');
select E.E_ID,P.PHONE_NO,A.AIRPORT_NAME
from EMPLOYEE E,EMP_PHONE_NO P,AIRPORT A
where E.E_ID=P.E_ID
and E.AIRPORT_NAME=A.AIRPORT_NAME
and A.CITY in ('delhi');
select P.PASSPORT_NO, P.NAME, P.AGE, P.FLIGHT_NO, T.TICKET_NO
from PASSENGER P, TICKET T
where T.SOURCE in ('Delhi') and (P.AGE >= 60 or P.AGE <= 10);
select P.PASSPORT_NO, P.NAME, P.AGE, P.FLIGHT_NO, T.TICKET_NO, T.SEAT_NO
from PASSENGER P, TICKET T
where (T.DESTINATION) in ('Delhi') and (P.AGE >= 60) and T.AIRLINE_NAME in
(select AIRLINE_NAME
from TICKET
where AIRLINE_NAME = 'SpiceJet');
CREATE TABLE AAIRPORT(
 AIRPORT_NAME VARCHAR(20) NOT NULL,
 CITY VARCHAR(20),
 STATE VARCHAR(20),
PRIMARY KEY (AIRPORT_NAME)
);
INSERT INTO AAIRPORT VALUES('mumbai', 'mumbai', 'maharashtra');
INSERT INTO AAIRPORT VALUES('delhi', 'delhi', 'delhi');
INSERT INTO AAIRPORT VALUES('pune', 'pune', 'maharashtra');
SELECT * FROM AAIRPORT;

--1st trigger
CREATE OR REPLACE TRIGGER AFTER_INSERT_TR
AFTER INSERT ON AAIRPORT
FOR EACH ROW
BEGIN
dbms_output.put_line('insert successfully');
END;
/
INSERT INTO AAIRPORT VALUES('A', 'A', 'A');
DROP TRIGGER AFTER_INSERT_TR;

--2nd trigger
CREATE OR REPLACE TRIGGER BEFORE_INSERT_TR
BEFORE INSERT ON AAIRPORT
FOR EACH ROW
BEGIN
 :new.AIRPORT_NAME := TRIM(:new.AIRPORT_NAME);
 :new.CITY := TRIM(:new.CITY);
 :new.STATE := TRIM(:new.STATE);
END;
/
INSERT INTO AAIRPORT (AIRPORT_NAME, CITY, STATE) VALUES ('B', 'B', 'B');
SELECT * FROM AAIRPORT;
/
DROP TRIGGER BEFORE_INSERT_TR;
/

--procedure
CREATE OR REPLACE PROCEDURE add3(n IN VARCHAR, c IN VARCHAR, s IN VARCHAR) IS
BEGIN
  INSERT INTO AIRPORT(AIRPORT_NAME, CITY, STATE) VALUES(n, c, s);
END;
/
DECLARE
  nam2 AIRPORT.AIRPORT_NAME%TYPE;
  cit2 AIRPORT.CITY%TYPE;
  stat2 AIRPORT.STATE%TYPE;
BEGIN
  nam2 := 'Dabolim Airport';
  cit2 := 'Dabolim';
  stat2 := 'Goa';
  add3(nam2, cit2, stat2);
END;
/
SELECT * FROM AIRPORT;

--procedure
create or replace procedure add4(num5 in number,nam10 in varchar,nam11 in varchar) is
begin
insert into AIRLINE values(num5,nam10,nam11);
end;
/
declare
nam2 AIRLINE.AIRLINE_ID%type;
cit2 AIRLINE.AIRLINE_NAME%type;
stat2 AIRLINE.AIRPORT_NAME%type;
begin
nam2:=130;
cit2:='Indigo';
stat2:='Dabolim Airport';
add4(nam2,cit2,stat2);
end;
/
select * from AIRLINE;
declare
nam9 EMPLOYEE.AIRPORT_NAME%type;
ans number;
function no_of_employee(nam6 in varchar) return number is
a number;
begin
select count(*) into a from EMPLOYEE where AIRPORT_NAME=nam6;
return a;
end;
begin
nam9:='Shivaji';
ans:=no_of_employee(nam9);
dbms_output.put_line('No. of employees at '||nam9||' airport are '||ans);
end;
/

--3rd trigger
CREATE OR REPLACE TRIGGER BEFORE_INSERT_TRxyz
BEFORE INSERT ON AIRPORT
FOR EACH ROW
DECLARE
	nam2 AIRLINE.AIRLINE_ID%type;
  cit2 AIRLINE.AIRLINE_NAME%type;
  stat2 AIRLINE.AIRPORT_NAME%type;
  PROCEDURE add4(num5 IN NUMBER, nam10 IN VARCHAR2, nam11 IN VARCHAR2) IS
  BEGIN
    INSERT INTO AIRLINE (AIRLINE_ID, AIRLINE_NAME, AIRPORT_NAME) VALUES (num5, nam10, nam11);
  END;
BEGIN
  :new.AIRPORT_NAME := TRIM(:new.AIRPORT_NAME);
  :new.CITY := TRIM(:new.CITY);
  :new.STATE := TRIM(:new.STATE);

  nam2 := 140;
  cit2 := 'Indigo';
  stat2 := 'Dabolim Airport';
  add4(nam2, cit2, stat2);
END;
/
SELECT * FROM AIRLINE;
INSERT INTO AIRPORT (AIRPORT_NAME, CITY, STATE) VALUES ('X', 'Y', 'Z');
/
SELECT * FROM AIRPORT;
DROP TRIGGER BEFORE_INSERT_TRxyz;
