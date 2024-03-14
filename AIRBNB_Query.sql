-- CHANGING THE COLUMN VALUES FOR BETTER COMPREHENSION

SELECT host_is_superhost ,
CASE
	WHEN host_is_superhost = 't' THEN 'True'
	WHEN host_is_superhost = 'f' THEN 'False'
	WHEN host_is_superhost = 'FALSE' THEN 'False'
	ELSE host_is_superhost

END
FROM Airbnb

UPDATE Airbnb
SET host_is_superhost =

CASE 
WHEN host_is_superhost = 't' THEN 'True'
	WHEN host_is_superhost = 'f' THEN 'False'
	WHEN host_is_superhost = 'FALSE' THEN 'False'
	ELSE host_is_superhost
END


UPDATE Airbnb
SET host_identity_verified =

CASE 
WHEN host_identity_verified = 't' THEN 'True'
	WHEN host_identity_verified = 'f' THEN 'False'
	WHEN host_identity_verified = 'FALSE' THEN 'False'
	WHEN host_identity_verified = 'TRUE' THEN 'True'
	ELSE host_identity_verified
END


UPDATE Airbnb
SET instant_bookable =

CASE 
WHEN instant_bookable = 't' THEN 'True'
	WHEN instant_bookable = 'f' THEN 'False'
	WHEN instant_bookable = 'FALSE' THEN 'False'
	WHEN instant_bookable = 'TRUE' THEN 'True'
	ELSE instant_bookable
END

UPDATE Airbnb
SET has_availability =

CASE 
WHEN has_availability = 't' THEN 'True'
	WHEN has_availability = 'f' THEN 'False'
	WHEN has_availability = 'FALSE' THEN 'False'
	WHEN has_availability = 'TRUE' THEN 'True'
	ELSE has_availability
	END

--CHANGING THE COLUMN TYPE OF THE ID TO BIG INT TO REPRESENT THE NUMBERS AS A WHOLE

ALTER TABLE Airbnb
ALTER COLUMN id BIGINT;

--SEPARATING THE COLUMN OF HOST LOCATION TO HOST CITY AND HOST COUNTRY COLUMNS


ALTER TABLE Airbnb
ADD host_city NvarCHAR (255),
host_country NvarCHAR (255);

UPDATE Airbnb
SET 
    host_city = CASE 
        WHEN CHARINDEX(',', host_location) > 0 THEN SUBSTRING(host_location, 1, CHARINDEX(',', host_location) - 1)
        ELSE host_location
    END,
    host_country = CASE 
        WHEN CHARINDEX(',', host_location) > 0 THEN SUBSTRING(host_location, CHARINDEX(',', host_location) + 1, LEN(host_location))
        ELSE host_location
    END;


-- CREATING CATEGORICAL COLUMNS DERIVED FROM NUMERICAL COLUMNS

ALTER TABLE Airbnb
ADD host_response_updated NvarCHAR (255);

UPDATE Airbnb
SET host_response_updated = 
CASE
	WHEN host_response_rate >= 0 and host_response_rate <= 25 THEN 'very low'
	WHEN host_response_rate > 25 and host_response_rate <= 50 THEN 'low'
	WHEN host_response_rate > 50 and host_response_rate <= 75 THEN 'high'
	WHEN host_response_rate > 75 and host_response_rate <= 100 THEN 'very high'
    ELSE NULL
END 


ALTER TABLE Airbnb
ADD host_acceptance_updated NvarCHAR (255);

UPDATE Airbnb
SET host_acceptance_updated = 
CASE
	WHEN host_acceptance_rate >= 0 and host_acceptance_rate <= 25 THEN 'very low'
	WHEN host_acceptance_rate > 25 and host_acceptance_rate <= 50 THEN 'low'
	WHEN host_acceptance_rate > 50 and host_acceptance_rate <= 75 THEN 'high'
	WHEN host_acceptance_rate > 75 and host_acceptance_rate <= 100 THEN 'very high'
    ELSE NULL
END 


-- CHANGING THE VERIFICATIONS COLUMN TO A NUMERICAL VALUE INSTEAD OF A LIST LIKE COLUMN
ALTER TABLE Airbnb
ADD host_verification_updated AS (LEN(host_verifications) - LEN(REPLACE(host_verifications, ',', '')) + 1)


-- Filling the null values from the host_neighbourhood column with the available neighbourhood names in the cleansed column
UPDATE Airbnb
SET host_neighbourhood = ISNULL(host_neighbourhood, neighbourhood_cleansed)



-- Adding an availability percentage column derived from the number of days available
ALTER TABLE Airbnb
ADD availability_rate FLOAT

UPDATE Airbnb
SET availability_rate = CAST(ROUND((availability_365 * 100)/365,2) as float)

-- Adding a potential revenue column to approximately estimate how much an airbnb could profit
ALTER TABLE Airbnb
ADD approximate_income INT

UPDATE Airbnb
SET approximate_income = (price * minimum_nights)



--Adding a years since hosting column

ALTER TABLE Airbnb
ADD years_since_hosting INT

UPDATE Airbnb
SET years_since_hosting = DATEDIFF(year, host_since, GETDATE())



--Fixing string erros in the country column (white space)

UPDATE Airbnb
SET host_country= TRIM(host_country) 


--Deleting unecessary columns
ALTER TABLE Airbnb
DROP COLUMN host_response_rate, host_acceptance_rate, host_location


SELECT*
FROM Airbnb