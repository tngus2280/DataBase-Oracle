--1. 2013년 1월 25일 내원한 환자중 다음의 정보조회
-- 진료과명, 진료의사명, 접수시간, 환자번호, 환자이름, 생년월일, 성별
--(진료과, 진료의, 접수시간으로 내림차순 정렬)
SELECT DE.dep_name , D.doc_name , T.trt_receipt , P.pat_code , P.pat_name , P.pat_birth, P.pat_gender
FROM patient P , treat T , doctor D , department DE
WHERE P.pat_code = T.pat_code AND
         T.doc_code = D.doc_code AND
        D.dep_code = DE.dep_code 
        AND(TRT_YEAR =2013 AND TRT_DATE = 0125)
ORDER BY DE.dep_name , D.doc_name  , T.trt_receipt DESC;


--2. 2013년 12월 25일 내원한 환자의 다음 정보조회
--내원일자, 환자번호, 환자이름, 생년월일, 성별
--*단 2014년 이후로 입원했던적이 있다면 입원일자, 입원시간도 출력
--(진료시간 기준 정렬)
-- OUTER JOIN (+)
SELECT * FROM inpatient;
SELECT T.trt_date,P.pat_code,P.pat_name,P.pat_birth,P.pat_gender , IP.inp_year, IP.inp_date ,IP.inp_time
FROM patient P , treat T , (SELECT *FROM inpatient WHERE inp_year>=2014) IP
WHERE   
        P.pat_code  = T.pat_code AND
        P.pat_code = IP.pat_code(+)
       
        AND(TRT_YEAR =2013 AND TRT_DATE = 1225)
       
ORDER BY T.trt_time;


-- 3. 1번을 ANSI 코드로 작성하시오
SELECT DE.dep_name , D.doc_name , T.trt_receipt , P.pat_code , P.pat_name , P.pat_birth, P.pat_gender
FROM patient P 
    INNER JOIN treat T 
        ON P.pat_code = T.pat_code
    INNER JOIN doctor D  
        ON T.doc_code = D.doc_code
    INNER JOIN department DE
        ON  D.dep_code = DE.dep_code
 
 WHERE       TRT_YEAR =2013 AND TRT_DATE = 0125
ORDER BY DE.dep_name , D.doc_name  , T.trt_receipt DESC;


-- 2번 코드를 ANSI 코드로 작성하시오
SELECT * FROM inpatient;
SELECT T.trt_date,P.pat_code,P.pat_name,P.pat_birth,P.pat_gender , IP.inp_year, IP.inp_date ,IP.inp_time
FROM patient P 

INNER JOIN treat T 
    ON P.pat_code  = T.pat_code
LEFT OUTER JOIN (SELECT *FROM inpatient WHERE inp_year>=2014) IP
        ON P.pat_code = IP.pat_code
       
       WHERE TRT_YEAR =2013 AND TRT_DATE = 1225
       
ORDER BY T.trt_time;
