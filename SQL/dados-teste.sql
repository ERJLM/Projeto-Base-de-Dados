INSERT INTO INDUSTRY(Name)
VALUES
    ('Transportation');


INSERT INTO COUNTRY(Name)
VALUES
    ('Brasil');

INSERT INTO COMPANY(Name, IndustryId)
VALUES 
    ('99',
    (SELECT IndustryId FROM INDUSTRY WHERE Name='Transportation')
    );


INSERT INTO LOCATION(Name, CountryId)
VALUES
    ('Sao Paulo',
    (SELECT CountryId FROM COUNTRY WHERE Name='Brasil')
    );


INSERT INTO BRANCH(CompanyId,Headquarter,LocationId)
VALUES
    ((SELECT CompanyId FROM COMPANY WHERE Name='99'),
    1,
    (SELECT LocationId FROM LOCATION WHERE Name='Sao Paulo')
    );


INSERT INTO LAYOFF(BranchId,FundsRaised,WorkersLaid,Percentage,Date)
VALUES
    ((SELECT BranchId FROM BRANCH WHERE CompanyId=(SELECT CompanyId FROM COMPANY WHERE Name='99') AND LocationId=(SELECT LocationId FROM LOCATION WHERE Name='Sao Paulo')),
    12.0
    35
    0.25
    STR_TO_DATE('30/11/2022', '%d/%m/%Y')
    );