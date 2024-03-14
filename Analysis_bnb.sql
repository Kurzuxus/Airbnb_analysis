-- I. WHICH FACTORS INFLUENCE THE PRICE (HOW TO DETERMINE THE BEST PRICE FOR AN AIRBNB)

---Looking for the most expensive neighbourhood in London

SELECT DISTINCT (neighbourhood_cleansed), COUNT (neighbourhood_cleansed) as number_of_listings, AVG(price) as average_price, MIN(price) as minimum_price, 
MAX(price) as maximum_price
FROM Airbnb
GROUP BY neighbourhood_cleansed
ORDER BY 3 DESC

---What is the most expensive room_type
SELECT DISTINCT (room_type), COUNT(room_type) as number_of_listings,AVG(price) as average_price, MIN(price)as minimum_price, MAX(price)as maximum_price
FROM Airbnb
GROUP BY room_type
ORDER BY 3 DESC

--- Do the number of beds influence the price

SELECT DISTINCT	(beds), COUNT(beds) as number_of_beds, AVG(price) as average_price
FROM Airbnb
GROUP BY beds
ORDER BY 3 DESC


--- Do hosts with super host status earn more
SELECT DISTINCT (host_is_superhost), COUNT(host_is_superhost) as number_of_individuals, AVG(approximate_income) approximate_income
FROM Airbnb
GROUP BY host_is_superhost
ORDER BY 3 DESC


---Does the instant bookable status increase the price of an Airbnb

SELECT DISTINCT(instant_bookable), COUNT(instant_bookable) as number_of_listings, AVG(price) as average_price
FROM Airbnb
GROUP BY instant_bookable
ORDER BY 3 DESC

---Which number of accommodations typically have the highest price
SELECT DISTINCT (accommodates), COUNT (accommodates) as count, AVG(price) as average_price
FROM Airbnb
GROUP BY accommodates
ORDER BY 3 DESC

---Do older members tend to earn higher than newer members
SELECT years_since_hosting, AVG(approximate_income)  as approximate_income
FROM Airbnb
GROUP BY years_since_hosting
ORDER BY 2 DESC

---BONUS: Do foreigners earn more than local hosts
SELECT DISTINCT(host_country), COUNT(host_country) as number_of_listings, AVG(approximate_income) as approximate_income
FROM Airbnb
GROUP BY host_country
ORDER BY 2 DESC





-- II. Which factors lead to higher and better reviews for an Airbnb

---Which neighbourhoods have the highest reviews
SELECT DISTINCT(neighbourhood_cleansed), COUNT(neighbourhood_cleansed) as number_of_listings, AVG(review_scores_rating)as average_rating,STDEV(review_scores_rating) as STD 
FROM Airbnb
GROUP BY neighbourhood_cleansed
ORDER BY 3 DESC

--Does the acceptance and response rate/time effect the ratings

SELECT DISTINCT (host_acceptance_updated), COUNT(host_acceptance_updated) as count, AVG(review_scores_rating) as average_rating, STDEV(review_scores_rating) as STD 
FROM Airbnb	
GROUP BY host_acceptance_updated
ORDER BY 3 DESC


SELECT DISTINCT (host_response_updated), COUNT(host_response_updated)as count, AVG(review_scores_rating)as average_rating, STDEV(review_scores_rating) as STD 
FROM Airbnb	
GROUP BY host_response_updated
ORDER BY 3 DESC


SELECT DISTINCT (host_response_time), COUNT(host_response_time)as count, AVG(review_scores_rating)as average_rating, STDEV(review_scores_rating) as STD 
FROM Airbnb	
GROUP BY host_response_time
ORDER BY 3 DESC


---Which room type to users typically enjoy
SELECT DISTINCT (room_type), COUNT(room_type)as count, AVG(review_scores_rating)as average_rating, STDEV(review_scores_rating) as STD 
FROM Airbnb	
GROUP BY room_type
ORDER BY 3 DESC




--III. Which factors lead to an Airbnb being more attractive (having more bookings)

--- Which neighbourhoods are the most active in terms of average bookings and total bookings

SELECT neighbourhood_cleansed, COUNT(neighbourhood_cleansed) as count, AVG(number_of_reviews) as average_bookings, SUM(number_of_reviews) as total_bookings, AVG(availability_rate) as availability
FROM Airbnb
GROUP BY neighbourhood_cleansed
ORDER BY AVG(number_of_reviews) DESC, SUM(number_of_reviews) DESC


---Does the more verified the user is lead to more bookings

SELECT host_verification_updated, COUNT(host_verification_updated) as count, AVG(number_of_reviews) as average_bookings
FROM Airbnb
GROUP BY host_verification_updated

---Which number of accomodations do people generally gravitate towards

SELECT accommodates, COUNT(accommodates) as count, AVG(number_of_reviews) as average_bookings
FROM Airbnb
GROUP BY accommodates
ORDER BY 3 DESC


---Does the identity verification of the user lead to more bookings

SELECT host_identity_verified, COUNT(host_identity_verified) as count, AVG(number_of_reviews) as average_bookings
FROM Airbnb
GROUP BY host_identity_verified

---Do hosts with multiple properties tend to have more ratings
SELECT listing_type, COUNT(listing_type) as count, AVG(number_of_reviews)  as average_bookings
FROM (
    SELECT number_of_reviews,
        CASE
            WHEN host_total_listings_count = 1 THEN 'Single'
            WHEN host_total_listings_count > 1 THEN 'Multiple'
        END AS listing_type
		
    FROM Airbnb
) AS subquery
GROUP BY listing_type
ORDER BY 3 DESC

SELECT DISTINCT(room_type), COUNT(room_type) as count, AVG(number_of_reviews) as average_booking
FROM Airbnb
GROUP BY room_type

SELECT *
FROM Airbnb
