-- SCOTT 함수 연습문제 


-- COMM 의 값이 NULL이 아닌 정보 조회
SELECT ENAME, JOB, COMM
FROM EMP
WHERE COMM IS NOT NULL;

-- 커미션을 받지 못하는 직원 조회
SELECT ENAME, JOB, COMM
FROM EMP
WHERE COMM IS NULL;

-- 관리자가 없는 직원 정보 조회
SELECT * 
FROM EMP
WHERE MGR IS NULL;

-- 급여를 많이 받는 직원 순으로 조회
SELECT EMPNO, ENAME, JOB, COMM, SAL
FROM EMP
ORDER BY SAL DESC;

-- 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT EMPNO, ENAME, COMM, SAL
FROM EMP
ORDER BY 4 DESC, 3 DESC;

-- EMP 테이블에서 사원번호, 사원명,직급, 입사일 조회
-- 단 입사일을 오름차순 정렬 처리함.
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직급, 
       HIREDATE 입사일
FROM EMP
ORDER BY HIREDATE;       

-- EMP 테이블로 부터 사원번호, 사원명 조회
-- 사원번호 기준 내림차순 정렬
SELECT EMPNO, ENAME
FROM EMP
ORDER BY 1 DESC;

-- 사번, 입사일, 사원명, 급여 조회
-- 부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일순으로 처리
SELECT EMPNO, HIREDATE, ENAME, SAL
FROM EMP
ORDER BY DEPTNO, HIREDATE DESC;

/***** 함수 *****/

-- 시스템으로 부터 오늘 날짜에 대한 정보를 얻고자 할 때
SELECT SYSDATE
FROM DUAL;   

-- EMP 테이블로 부터 사번, 사원명, 급여 조회
-- 단, 급여는 100단위 까지의 값만 출력 처리함.
-- 급여 기준 내림차순 정렬함.
SELECT EMPNO 사번, ENAME 사원명, ROUND(SAL, -2) 급여
FROM EMP
ORDER BY SAL DESC;


-- EMP 테이블로 부터 사원번호가 홀수인 사원들을 조회
SELECT EMPNO, ENAME
FROM EMP
WHERE MOD(EMPNO, 2) = 1;


/* 문자 처리 함수*/  

-- EMP 테이블로 부터 사원명, 입사일 조회
-- 단, 입사일은 년도와 월을 분리 추출해서 출력
SELECT ENAME, 
       SUBSTR(HIREDATE, 1, 2) || '년 ' || 
       SUBSTR(HIREDATE, 4, 2) || '월' AS 입사일
FROM EMP;

-- EMP 테이블로 부터 9월에 입사한 직원의 정보 조회
SELECT *
FROM EMP
WHERE SUBSTR(HIREDATE, 4, 2) = '09';

-- EMP 테이블로 부터 '81'년도에 입사한 직원 조회
SELECT *
FROM EMP
WHERE SUBSTR(HIREDATE, 1, 2) = '81';

-- EMP 테이블로 부터 이름이 'E'로 끝나는 직원 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%E';

-- SUBSTR( ) 함수 사용
SELECT *
FROM EMP
WHERE SUBSTR(ENAME, -1, 1) = 'E';


-- emp 테이블로 부터 이름의 세번째 글자가 'R'인 직원의 정보 조회
-- LIKE 연산자를 사용
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

-- SUBSTR() 함수 사용
SELECT *
FROM EMP
WHERE SUBSTR(ENAME, 3 , 1) = 'R';


/************ 날짜 처리 함수 **************/

-- 입사일로 부터 40년 되는 날짜 조회
SELECT ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 480) AS "40년 되는 날"
FROM EMP;      

-- 입사일로 부터 33년 이상 근무한 직원의 정보 조회
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE ADD_MONTHS(HIREDATE, 396) < SYSDATE;


-- 오늘 날짜에서 년도만 추출
SELECT EXTRACT(YEAR FROM SYSDATE),
       EXTRACT(MONTH FROM SYSDATE),
       EXTRACT(DAY FROM SYSDATE) 
FROM DUAL;





   



