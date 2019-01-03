-- SCOTT_SELECT_연습문제_답.sql


-- DEPT 테이블로 부터 모든 데이터를 조회
SELECT *
FROM DEPT;

-- EMP 테이블로 부터 사번(EMPNO), 사원이름(ENAME)을 조회
SELECT EMPNO, ENAME
FROM EMP;

-- EMP 테이블로 부터 사원명, 급여, 연봉 조회
SELECT ENAME, SAL, SAL * 12
FROM EMP;

-- EMP 테이블로 부터 사원명, 급여, 직급, 커미션, 연봉, 커미션이 포함된 연봉 조회
SELECT ENAME, SAL, JOB, NVL(COMM, 0),
       SAL * 12, SAL * 12 + NVL(COMM, 0)
FROM EMP;       


-- emp 테이블에 사용된 부서코드 값 조회
select deptno
from emp;

-- emp 테이블에 사용된 부서코드 값 조회, 단 중복된 값은 한개만 출력되게 함.
select distinct deptno
from emp;

-- emp 테이블에서 사용된 직급 조회
select job 
from emp;

-- emp 테이블에 사용된 직급 데이터를 한개씩만 조회
select distinct job
from emp;

-- WHERE 절 

-- 급여를 3000 이상을 받는 직원의 정보 조회
select *
from emp
where sal >= 3000;

-- 부서코드가 10인 직원의 이름, 직급, 급여 조회
select ename, job, sal
from emp
where deptno = 10;

-- 비교값이 문자, 문자열, 날짜 데이터일 때는 반드시 '값' 로 표현함.
-- 직원의 이름이 'ford'인 직원의 정보 조회
select *
from emp
where ename = 'FORD';

-- 입사일이 1980년 이후에 입사한 직원들의 정보 조회
SELECT *
FROM EMP
WHERE HIREDATE >= '81/01/01';

-- 부서코드가 10이면서, 직급이 'MANAGER'인 직원의 정보 조회
SELECT *
FROM EMP
WHERE DEPTNO = 10 AND JOB = 'MANAGER';


-- 부서코드가 10 이거나, 직급이 'MANAGER'인 직원의 정보 조회
SELECT *
FROM EMP
WHERE DEPTNO = 10 OR JOB = 'MANAGER';

-- 직급이 'MANAGER'가 아닌 직원들의 정보 조회
SELECT *
FROM EMP
--WHERE JOB != 'MANAGER';
--WHERE JOB <> 'MANAGER';
--WHERE JOB ^= 'MANAGER';
WHERE NOT JOB = 'MANAGER';

-- 급여가 2000 이상 3000 이하의 급여를 받는 직원의 조회
SELECT ENAME, SAL
FROM EMP
--WHERE SAL >= 2000 AND SAL <= 3000;
WHERE SAL BETWEEN 2000 AND 3000;


--2000 미만 3000 초과된 범위의 급여를 받는 직원 조회
SELECT ENAME, SAL
FROM EMP
--WHERE SAL < 2000 OR SAL > 3000;
--WHERE NOT (SAL >= 2000 AND SAL <= 3000);
WHERE NOT SAL BETWEEN 2000 AND 3000;


-- 커미션이 300 또는 500 또는 1400인 직원 조회
SELECT *
FROM EMP
--WHERE COMM = 300 OR COMM = 500 OR COMM = 1400;
WHERE COMM IN (300, 500, 1400);


-- 사원번호가 7521 또는 7654 또는 7844인 사원들의 급여 조회
SELECT EMPNO, SAL
FROM EMP
--WHERE EMPNO =7521 OR EMPNO = 7654 OR EMPNO = 7844;
WHERE EMPNO IN (7521, 7654, 7844);

-- 사번이 7521, 7654, 7844 가 아닌 직원 조회
SELECT EMPNO, SAL
FROM EMP
--WHERE EMPNO <> 7521 AND EMPNO != 7654 AND EMPNO ^= 7844;
--WHERE EMPNO NOT IN (7521, 7654, 7844);
WHERE NOT EMPNO IN (7521, 7654, 7844);


-- 1980년 1월 1일 에서 부터 1980년 12월 31일 사이에 입사한 직원 조회
-- 1980년도에 입사한 직원 조회
SELECT *
FROM EMP
WHERE HIREDATE BETWEEN '1980/01/01' AND '1980/12/31';

-- 1980년이 아닌 해에 입사한 직원 조회
SELECT *
FROM EMP
WHERE HIREDATE NOT BETWEEN '1980/01/01' AND '1980/12/31';

-- 사원 이름이 'F'로 시작하는 직원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE 'F%';

-- 사원 이름이 'J'로 시작화는 직원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE 'J%';

-- 이름에 'A'가 포함된 직원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%A%';

-- 이름의 마지막 글자가 'N'으로 끝나는 직원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%N';


-- 이름에 두번째 글자가 'A'인 직원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '_A%';

-- 이름에 세번째 글자가 'A'인 직원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '__A%';


-- 사원명에 '_' 문자 앞 글자가 두 글자인 직원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '__\_%' ESCAPE '\';

-- 사원명에 마지막 글자가 '%P'인 직원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%#%P' ESCAPE '#';

-- 이름에 'A'가 없는 직원 정보 조회
SELECT *
FROM EMP
--WHERE ENAME NOT LIKE '%A%';
WHERE NOT ENAME LIKE '%A%';


