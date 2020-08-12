
SELECT * FROM emp;

DESC emp;

SELECT empno,ename,job,mgr,
    hiredate,sal,comm,deptno
FROM emp;


-- INSERT
INSERT INTO emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES ( 1001, 'ALICE' , 'CLERK' , 1003,'16/4/9' , 800 , null , 30);



INSERT INTO emp
VALUES ( 1002, 'MORRIS' , 'CLERK', 1003, '16/9/2', 800,null, 30);

SELECT * FROM emp WHERE empno<2000;



SELECT 1,2,'a','b' FROM dual;

SELECT 1003, 'MATHEW' , 'SALESMAN', null , sysdate , 1500 , 100 , 30
FROM dual;

INSERT INTO emp
SELECT 1003, 'MATHEW' , 'SALESMAN', null , sysdate , 1500 , 100 , 30
FROM dual;

SELECT * FROM emp WHERE empno<2000;


-- 다음 두 사원의 정보를 삽입 하세요
-- 사번 1011, 이름 EDWARD ,직무 MANAGER 컬럼 지정하기
INSERT INTO emp ( empno, ename, job)
VALUES (1011, 'EDWARD','MANAGER');

DELETE emp
WHERE empno=1011;


SELECT * FROM emp;
-- 사번 1015, 이름 Richard, 급여 2000 ,
INSERT INTO emp( empno, ename, sal)
VALUES( 1015, 'Richard' , 2000);
SELECT * FROM emp;

-- commit; -- 커밋 , 데이터 변경사항 영구적으로 적용


--DELETE emp; -- 테이블 전체 삭제
-- rollback; -- 롤백, 데이터 변경사항을 되돌리기 , 데이터를 쌓아놓는것 트랜젝션





SELECT * FROM emp;
-- 테이블 생성 (SELECT 구문의 결과를 사본테이블로 생성한다)
CREATE TABLE emp_research
AS
SELECT * FROM emp;

-- 테이블 확인
SELECT * FROM emp_research;

-- 테이블 삭제
DROP TABLE emp_research;


-- 빈 테이블 복사
CREATE TABLE emp_research
AS
SELECT * FROM emp WHERE 1=0; --true를 나타낸다-> 조회 1=0 ->FALSE
SELECT * FROm emp_research;

-- 20번 부서의 모든 데이터를 INSERT
INSERT INTO emp_research
SELECT * FROM emp WHERE deptno=20; 

SELECT * FROM emp_research;


-- 30번 부서의 모든 데이터를 empno, ename 만 INSERT
INSERT INTO emp_research (empno, ename)
SELECT empno, ename FROM emp WHERE deptno=30;


-- 모든 데이터 삭제
DELETE emp_research;

INSERT ALL 
    WHEN deptno=20
        THEN INTO emp_research
    WHEN deptno=30
        THEN INTO emp_research( empno, ename)
        VALUES (empno, ename)
SELECT * FROM emp;

SELECT * FROM emp_research;

-- INSERT ALL QUIZ

-- emp를 이용해 데이터 없이 emp_hire 테이블 생성
--empno, ename, hiredate
CREATE TABLE emp_hire 
AS  
SELECT empno, ename, hiredate FROM emp WHERE 1=0;

--emp를 이용해 데이터 없이 emp_sal 테이블 생성
-- empno, ename , sal

CREATE TABLE emp_sal 
AS  
SELECT empno, ename, sal FROM emp WHERE 1=0;

-- INSERT ALL 사용해서 해결하기

-- emp_hire 테이블 , '1981/06/01' 이전 사원
-- emp_sal 테이블, 2000보다 많은 사원
INSERT ALL
    WHEN hiredate <'1981/06/01'
        THEN INTO emp_hire
        VALUES (empno,ename,hiredate)
    WHEN sal>2000
        THEN INTO emp_sal
        VALUES (empno,ename,sal)
SELECT * FROM emp;

SELECT * FROM emp_hire;
SELECT * FROM emp_sal;

-- commit;
-- rollback;

--테이블 삭제
DELETE emp_hire;
DELETE emp_sal;


SELECT * FROM emp_sal
-- DELETE emp_sal
WHERE empno = 7839;

SELECT * FROM emp
-- DELETE emp
WHERE empno= 7369;

--rollback;


-- UPDATE
SELECT * FROM emp
-- UPDATE emp SET ename ='Mc' , job = 'Donald'
WHERE empno =1001;
--commit;

-- emp_hire 테이블의 전체 데이터의 압사일을 현재시간으로 변경
SELECT * FROM emp_hire;
-- UPDATE emp_hire SET hiredate= trunc(sysdate);
SELECT to_char(hiredate, 'yyyy/mm/dd hh24:mi:ss') FROM emp_hire;
-- emp_sal의 사원들 전부 급여 550 인상

SELECT * FROM emp_sal; 
-- UPDATE emp_sal SET sal = sal+550;
--commit;
--rollback;



--MERGE
CREATE TABLE emp_merge
AS
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno IN (10,20);

SELECT * FROM emp_merge
ORDER BY deptno, empno;

-- emp테이블에서 20,30부서 사원들을 조회(SELECT)
-- emp_merge 테이블과 데이터 병합 (MERGE)
-- 이미 테이블에 존재하는 데이터라면 sal만 30% 인상 (UPDATE)
-- 테이블에 존재하지 않는 데이터라면 삽입 ( INSERT )

MERGE INTO emp_merge M
USING ( 
    SELECT empno, ename, sal ,deptno
    FROM emp
    WHERE deptno IN (20, 30)
)E
ON (M.empno = E.empno )
WHEN MATCHED THEN --존재하는 데이터, 20부서
    UPDATE  SET M.sal = M.sal * 1.3
    WHERE E.sal>1500
WHEN NOT MATCHED THEN --존재하지 않는 데이터 , 30부서
    INSERT (M.empno , M.ename ,M.deptno, M.sal)
    VALUES (E.empno, E.ename , E.deptno, E.sal)
    WHERE E.sal>1000;
    
SELECT * FROM emp_merge
ORDER BY deptno, empno;




--------------------------------------------- 

















