-- Day 6

/*
조인(JOIN)
- 여러개의 테이블을 하나의 큰 테이블로 합친 결과를 원할 때 사용한다.
오라클 전용 구문과 모든 DBMS가 공통으로 사용하는 표준구문인 ANSI 표준구문
*/

-- 오라클 전용구문으로 JOIN 처리
-- 합칠 테이블명을 FROM절에 ,로 나열한다.
-- 테이블을합치기 위한 컬럼명을 WHERE절에 명시한다.

SELECT  *
FROM    EMPLOYEE,
            DEPARTMENT
WHERE   EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID;   

-- 오라클 전용구문에서는 조인시에 테이블명에 별칭사용가능

SELECT  *
FROM    EMPLOYEE E,
            DEPARTMENT D
WHERE   E.DEPT_ID = D.DEPT_ID;   

-- 사원명, 부서명 조회
SELECT    EMP_NAME,
              DEPT_NAME,
              E.DEPT_ID
FROM     EMPLOYEE E,
              DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- ANSI 표준구문
-- 조인 처리를 위해 별도의 구문을 FROM절에 작성한다.

SELECT *
FROM    EMPLOYEE
JOIN    DEPARTMENT USING (DEPT_ID);

SELECT      EMP_NAME, DEPT_ID, DEPT_NAME
FROM       EMPLOYEE
JOIN    DEPARTMENT USING(DEPT_ID);

-- USING(컬럼명) : 두 테이블의 컬럼명이 같을경우
-- ON : 두 테이블의 연결할 컬럼이 다를경우

-- ON 두테이블의 연결할 컬럼명이 다를 때,
SELECT *
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- 오라클 전용구문으로
SELECT      *
FROM        DEPARTMENT, LOCATION
WHERE      LOC_ID = LOCATION_ID;

-- 사번, 사원명, 직급명 조회
--오라클 전용구문
SELECT      EMP_ID,
                EMP_NAME,
                JOB_TITLE
FROM       EMPLOYEE E,
                JOB J
WHERE      E.JOB_ID = J.JOB_ID; 
            
-- ANSI 표준구문
SELECT      EMP_ID,
                EMP_NAME,
                JOB_TITLE
FROM       EMPLOYEE
JOIN        JOB USING (JOB_ID);

-- USING에 이어 여러개의 컬럼을 나열 기술할 수도 있음
SELECT *
FROM        EMPLOYEE2
JOIN        DEPARTMENT USING (DEPT_ID,LOC_ID);

-- 2개의 컬럼값을 하나의 값으로 보고, 같은 값을 찾아서 조인함
-- '10A1' = '10A1' 조인됨
-- '90A1' <> '90A3' : 조인안됨

-- 조인은 기본이 EQUAL JOIN 임. (EQU JOIN 이라고도 함)
-- 연결되는 컬럼의 값이 일치하는 행들만 조인이 됨
-- INNER 조인과 같은 뜻
-- 오라클, ANSI 둘 다 기본 조인은 INNER

-- OUTER JOIN ******************************************************
-- EQUAL JOIN 이면서 두 테이블의 지정한 컬럼의 값이 일치하지 않는 행도 조인에 포함시킴.

--모든 직원에 정보가 조인의 결과에 포함되게 하려면
-- 오라클 전용 구문
SELECT      *   
FROM        EMPLOYEE E, DEPARTMENT D
WHERE       E.DEPT_ID = D.DEPT_ID(+);

-- ANSI 표준구문
SELECT      *
FROM        EMPLOYEE
LEFT OUTER      JOIN DEPARTMENT USING (DEPT_ID);

-- 부서정보 모두 다 조인에 포함되게 하려면

-- 오라클 전용
SELECT      *
FROM       EMPLOYEE E, DEPARTMENT D
WHERE      E.DEPT_ID(+) = D.DEPT_ID; 

-- ANSI 표준구문
SELECT
    *
FROM        EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT USING (DEPT_ID);

-- 직원 정보 모두 다, 부서정보 모두 다


SELECT
    *
FROM    EMPLOYEE E, DEPARTMENT D
WHERE   E.DEPT_ID(+) = D.DEPT_ID(+);
-- 오라클 전용 구문에서는 FULL OUTER JOIN 사용 불가

-- ANSI 표준 구문
SELECT
    *
FROM    EMPLOYEE
FULL      JOIN DEPARTMENT USING (DEPT_ID);





