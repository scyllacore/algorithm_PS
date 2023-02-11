SELECT CAR_ID, ROUND(AVG(DATEDIFF(END_DATE,START_DATE)+1),1) AS 'AVERAGE_DURATION'
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
GROUP BY CAR_ID HAVING AVG(DATEDIFF(END_DATE,START_DATE)+1) >= 7
ORDER BY AVERAGE_DURATION DESC, CAR_ID DESC

/*
SELECT *, DATEDIFF(END_DATE,START_DATE) AS 'AVERAGE_DURATION'
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
*/

/*
SELECT CAR_ID, ROUND(AVG(DATEDIFF(END_DATE,START_DATE)),1) AS 'AVERAGE_DURATION'
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
WHERE DATEDIFF(END_DATE,START_DATE) >= 7
GROUP BY CAR_ID
ORDER BY AVERAGE_DURATION DESC, CAR_ID DESC
*/