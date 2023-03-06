WITH R1 AS
(
    SELECT
        DISTINCT HISTORY.CAR_ID
    FROM
        #CAR_RENTAL_COMPANY_CAR AS CAR
        #INNER JOIN
        CAR_RENTAL_COMPANY_RENTAL_HISTORY AS HISTORY
            #ON CAR.CAR_ID = HISTORY.CAR_ID
    WHERE START_DATE BETWEEN '2022-11-01' AND '2022-11-30'
          OR
          END_DATE BETWEEN '2022-11-01' AND '2022-11-30'
          OR
          START_DATE < '2022-11-01' AND END_DATE > '2022-11-30' #이걸 빼먹음
    #GROUP BY CAR_ID
),
R2 AS
(
    SELECT 
        DISTINCT CAR.*
    FROM
       CAR_RENTAL_COMPANY_CAR AS CAR
       INNER JOIN
       R1
        ON CAR.CAR_ID NOT IN (SELECT * FROM R1)
    WHERE CAR.CAR_TYPE IN ('세단','SUV')
    ORDER BY
        CAR.CAR_ID    
),
R3 AS
(
    SELECT
        R2.*
        ,PLAN.DURATION_TYPE
        ,PLAN.DISCOUNT_RATE
    FROM
        R2
        INNER JOIN
        CAR_RENTAL_COMPANY_DISCOUNT_PLAN AS PLAN
            ON R2.CAR_TYPE = PLAN.CAR_TYPE 
               AND PLAN.DURATION_TYPE LIKE '30%'
)

SELECT
    CAR_ID
    ,CAR_TYPE
    ,FLOOR(DAILY_FEE*30*(100-DISCOUNT_RATE)/100) AS 'FEE'
FROM
    R3
WHERE FLOOR(DAILY_FEE*30*(100-DISCOUNT_RATE)/100) BETWEEN 500000 AND 2000000
ORDER BY
    FEE DESC, CAR_TYPE ASC, CAR_ID DESC
