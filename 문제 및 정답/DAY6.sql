-- DAY 6

/*
조인(JOIN)
: 여러 개의 테이블을 하나의 큰 테이블로 합친 결과를 원할 때 사용함
오라클 전용구문과 모든 DBMS가 공통으로 사용하는 표준구문인 ANSI 표준구문
*/

-- 오라클 전용구문으로 JOIN 처리
-- 합칠 테이블명을 FROM 절에 , 로 나열함
-- 테이블을 합치기 위한 컬럼명을 WHERE 절에 명시함

SELECT *
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID;

-- 오라클 전용구문에서는 조인시에 테이블명에 별칭 사용할 수 있음.
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- 사원명, 부서명 조회
SELECT EMP_NAME, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;


-- ANSI 표준구문 
-- 조인 처리를 위한 별도의 구문을 FROM절에 작성함
-- 모든 DBMS 가 공통으로 사용하는 표준 구문임.
SELECT *
FROM EMPLOYEE
INNER JOIN DEPARTMENT USING (DEPT_ID);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
INNER JOIN DEPARTMENT USING (DEPT_ID);
-- USING (컬럼명) : 두 테이블의 컬럼명이 같을 경우

-- ON : 두 테이블의 연결할 컬럼명이 다를 때, (같은 값을 사용하고 있음)
SELECT *
FROM DEPARTMENT
INNER JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- 오라클 전용구문으로
SELECT *
FROM DEPARTMENT, LOCATION
WHERE LOC_ID = LOCATION_ID;

-- 사번(EMP_ID), 사원명(EMP_NAME), 직급명(JOB_TITLE) 조회
-- 오라클 전용구문
SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID;

-- ANSI 표준구문
SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE
INNER JOIN JOB USING (JOB_ID);

-- USING 에 여러 개의 컬럼을 나열 기술할 수도 있음
SELECT *
FROM EMPLOYEE2
INNER JOIN DEPARTMENT USING (DEPT_ID, LOC_ID);
-- 2개의 컬럼값을 하나의 값으로 보고, 같은 값을 찾아서 조인함
-- '10A1' = '10A1' : 조인됨
-- '90A1' <> '90A3' : 조인안됨

-- 조인은 기본이 EQUAL JOIN 임. (EQU-JOIN 이라고도 함)
-- 연결되는 컬럼의 값이 일치하는 행들만 조인이 됨.
-- 오라클, ANSI 둘 다 기본 조인은 EQUAL AND INNER 조인임.

-- OUTER JOIN ****************
-- EQUAL JOIN 이면서, 두 테이블의 지정한 컬럼의 값이 일치하지 않는 행도
-- 조인에 포함시킴.

-- 모든 직원의 정보가 조인의 결과에 포함되게 하려면
-- 오라클 전용구문
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+);

-- ANSI 표준구문
SELECT *
FROM EMPLOYEE
--LEFT OUTER JOIN DEPARTMENT USING (DEPT_ID);
LEFT JOIN DEPARTMENT USING (DEPT_ID);


-- 부서정보 모두 다 조인에 포함되게 하려면
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID;

SELECT *
FROM EMPLOYEE
--RIGHT OUTER JOIN DEPARTMENT USING (DEPT_ID);
RIGHT JOIN DEPARTMENT USING (DEPT_ID);


-- 직원 정보 모두 다와 부서 정보 모두 다 조인에 포함되게 하려면.
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+);
-- 오라클 전용구문에서는 FULL OUTER JOIN 표현할 수 없음

-- ANSI 표준구문
SELECT *
FROM EMPLOYEE
--FULL OUTER JOIN DEPARTMENT USING (DEPT_ID);
FULL JOIN DEPARTMENT USING (DEPT_ID);


-- NATURAL [INNER] JOIN
-- 연결할 테이블의 기본키(PRIMARY KEY)로 설정된 컬럼을 사용해서 조인됨.
SELECT *
FROM EMPLOYEE
--NATURAL INNER JOIN DEPARTMENT;
NATURAL JOIN DEPARTMENT;
-- DEPARTMENT 의 기본키 컬럼이 DEPT_ID 를 사용해서 조인됨


-- NON EQUAL JOIN ************
-- 지정하는 컬럼의 값이 일치하는 행들을 조인하는 경우가 아닌 조인.

-- CROSS JOIN
-- 두 테이블을 연결할 컬럼이 없는 경우에 사용함.
SELECT *
FROM LOCATION, COUNTRY;

SELECT *
FROM LOCATION
CROSS JOIN COUNTRY;  -- 5행 * 5행 => 25행

-- NON-EQU JOIN
-- 연결하는 테이블의 컬럼값을 범위로 해서 조인할 수도 있음
SELECT *
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN
-- 같은 테이블을 두 번 조인하는 경우
-- 같은 테이블 안의 다른 컬럼을 외부 참조키(F)로 사용하고 있는 경우에 셀프조인 가능함
SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

SELECT *
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 직원 이름과 그 직원의 관리자 이름 조회
SELECT E.EMP_NAME 직원이름, M.EMP_NAME 관리자이름 
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

-- N개의 테이블 조인
-- 테이블간의 관계(RELATIONSHIP)를 고려해서 순서를 정해야 함
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID);



--JOIN 연습문제
--
--1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT TO_CHAR(TO_DATE('2020/12/25', 'RRRR/MM/DD'), 'DAY')
FROM DUAL;
 
--2. 주민번호가 60년대 생이면서 성별이 여자이고, 성이 김씨인 직원들의 
--사원명, 주민번호, 부서명, 직급명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_ID = D.DEPT_ID
AND E.JOB_ID = J.JOB_ID
AND EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '김%';

-- ANSI 표준구문
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '김%';

--3. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.

-- 나이의 최소값 조회
SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) 나이
FROM EMPLOYEE;

-- 오라클 전용구문
SELECT EMP_ID, EMP_NAME, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) 나이, 
        DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) = 30;

-- ANSI 표준구문
SELECT EMP_ID, EMP_NAME, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) 나이, 
        DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) = 30;


--4. 이름에 '성'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID 
AND EMP_NAME LIKE '%성%';

-- ANSI 표준구문
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NAME LIKE '%성%';

--5. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, JOB_TITLE, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND DEPT_NAME LIKE '해외영업%'
ORDER BY 4;

-- ANSI 표준구문
SELECT EMP_NAME, JOB_TITLE, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME LIKE '해외영업%'
ORDER BY 4;

--6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND BONUS_PCT IS NOT NULL
AND BONUS_PCT <> 0.0;

-- ANSI 표준구문
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL
AND BONUS_PCT <> 0.0;

--7. 부서코드가 20인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.

-- 오라클 전용구문


-- ANSI 표준구문


--8. 직급별 연봉의 최소급여(MIN_SAL)보다 많이 받는 직원들의
--사원명, 직급명, 급여, 연봉을 조회하시오.
--연봉에 보너스포인트를 적용하시오.

-- 오라클 전용구문
SELECT EMP_NAME, JOB_TITLE, SALARY, 
        (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 연봉
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID 
AND (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 > MIN_SAL;

-- ANSI 표준구문
SELECT EMP_NAME, JOB_TITLE, SALARY, 
        (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 연봉
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 > MIN_SAL;

--9. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--사원명(emp_name), 부서명(dept_name), 지역명(loc_describe), 국가명(country_name)을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID
AND L.COUNTRY_ID IN ('KO', 'JP');

-- ANSI 표준구문
SELECT EMP_NAME, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID)
WHERE COUNTRY_ID IN ('KO', 'JP');

--10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
--self join 사용

-- 오라클 전용구문
SELECT E.EMP_NAME 사원명, E.DEPT_ID 부서코드,
        C.EMP_NAME 동료이름, C.DEPT_ID 부서코드
FROM EMPLOYEE E, EMPLOYEE C
WHERE E.EMP_NAME <> C.EMP_NAME
AND E.DEPT_ID = C.DEPT_ID
ORDER BY E.EMP_NAME;

-- ANSI 표준구문
SELECT E.EMP_NAME 사원명, E.DEPT_ID 부서코드,
        C.EMP_NAME 동료이름, C.DEPT_ID 부서코드
FROM EMPLOYEE E
JOIN EMPLOYEE C ON (E.DEPT_ID = C.DEPT_ID)
WHERE E.EMP_NAME <> C.EMP_NAME
ORDER BY E.EMP_NAME;

--11. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 
-- 사원명, 직급명, 급여를 조회하시오.
--단, join과 IN 사용할 것

-- 오라클 전용구문
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID 
AND E.JOB_ID IN ('J4', 'J7')
AND BONUS_PCT IS NULL;

-- ANSI 표준구문
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID IN ('J4', 'J7')
AND BONUS_PCT IS NULL;


--12. 기혼인 직원과 미혼인 직원의 수를 조회하시오.
SELECT DECODE(MARRIAGE, 'Y', '기혼', 'N', '미혼') 결혼유무,
        COUNT(*) 직원수
FROM EMPLOYEE
GROUP BY DECODE(MARRIAGE, 'Y', '기혼', 'N', '미혼')
ORDER BY 1;
