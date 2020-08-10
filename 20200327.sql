--1. 2012년 1월 3일 내원환자 중 
-- 정형외과(코드:05xx)와 성형외과(코드:08xx)와 이비인후과(코드:13xx)
-- 환자조회
--32	박환자
--33	권이나
--37	강성
--42	지유
--43	허민지
SELECT * FROM department;
SELECT * FROM patient;
SELECT * FROM doctor;
SELECT * FROM treat;
SELECT P.PAT_NAME , P.pat_code
FROM patient P, treat T, doctor DOC, department DEP  
WHERE P.pat_code = T.pat_code AND
         T.doc_code = DOC.doc_code AND
        DOC.dep_code = DEP.dep_code AND
        
        (TRT_YEAR =2012 AND TRT_DATE = 0103)
    AND( DEP.dep_code LIKE '05%' OR DEP.dep_code LIKE '08%' OR DEP.dep_code LIKE '13%');
--정형외과(코드:05xx)와 성형외과(코드:08xx)와 이비인후과(코드:13xx)
    




--2. 2012년 1월 3일 내원환자 중 내원 진료시간이 09:00 ~ 12:00 이고
-- 진료과가 정형외과(코드:05xx)와 성형외과(코드:08xx)와 이비인후과(코드:13xx)
-- 가 아닌 환자조회
--30	권환자
--35	황환자
--39	고기리
--40	유희애
SELECT P.PAT_NAME , P.pat_code
FROM patient P, treat T, doctor DOC, department DEP  
WHERE P.pat_code = T.pat_code AND
         T.doc_code = DOC.doc_code AND
        DOC.dep_code = DEP.dep_code AND
        (TRT_YEAR =2012 AND TRT_DATE = 0103 AND(TRT_TIME BETWEEN 0900  AND 1200))
    AND NOT( DEP.dep_code  LIKE '05%' OR DEP.dep_code  LIKE '08%' OR DEP.dep_code   LIKE '13%');





--3. 2014년 1월 1일 내원환자 중 5명만 출력
-- (진료시간순서 상 마지막 진료환자 5명)

--5	오대식
--19	우별희
--21	송주희
--24	차은비
--27	안성댁
SELECT pat_name FROM (
    SELECT rownum rnum, P.* FROM(
        SELECT * FROM (
        SELECT P.PAT_NAME , P.pat_code
            FROM patient P, treat T   
            WHERE P.pat_code = T.pat_code AND
        (TRT_YEAR =2014 AND TRT_DATE = 0101) -- 조회하려는 대상지정
        ORDER BY TRT_TIME DESC -- 정렬기준 설정
    ) P
    ) P
) R
WHERE rnum<=5
ORDER BY PAT_CODE;
