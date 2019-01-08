-- DAY7

-- SET OPERATOR (집합 연산자)
-- UNION, UNION ALL, INTERSECT, MINUS
-- UNION, UNION ALL 합집합 : 여러개의 SELECT 결과를 하나로 합치는 기능
-- INTERSECT 교집합 : 여러개의 SELECT 결과에서 공통된 행만 골라내는 기능
-- MINUS 차집합 : 첫번째 SELECT 결과에서 두번째 SELECT 결과와 겹치는 부분을 뺀 결과만 선택

SELECT  EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
UNION ALL
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

SELECT  EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

SELECT  EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
MINUS
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- SET 연산자 사용시 주의사항
-- SELECT 절에 컬럼의 갯수가 같아야 한다. : 더미 컬럼을 이용해서라도 갯수를 맞춰야함
-- 각 SELECT 절에 항목별 자료형도 같아야 함
SELECT	EMP_NAME, JOB_ID, HIRE_DATE
FROM	EMPLOYEE
WHERE 	DEPT_ID = '20'
UNION	
SELECT	DEPT_NAME, DEPT_ID, NULL
FROM	DEPARTMENT
WHERE	DEPT_ID = '20';

-- 50번 부서에 소속된 직원 중 관리자와 일반직원을 따로 조회해서 하나로 합쳐라
SELECT	EMP_ID, EMP_NAME, '관리자' 구분
FROM	EMPLOYEE	
WHERE	DEPT_ID = '50' AND EMP_ID = '141'
UNION
SELECT	EMP_ID, EMP_NAME, '직원' 구분
FROM	EMPLOYEE
WHERE	DEPT_ID = '50' AND EMP_ID <> '141'
ORDER BY 3, 1;

SELECT 'SQL을 공부하고 있습니다' 문장, 3 순서 FROM DUAL
UNION
SELECT '우리는 지금', 1 FROM DUAL
UNION
SELECT '아주 재미있게' , 2 FROM DUAL
ORDER BY 2;

-- 집합 연산자와 JOIN의 관계
SELECT	EMP_ID, ROLE_NAME
FROM	EMPLOYEE_ROLE
INTERSECT
SELECT	EMP_ID, ROLE_NAME
FROM	ROLE_HISTORY;

-- 조인 구문에서 USING (EMP_ID, ROLE_NAME) 의 의미
-- INTERSECT와 비슷하게 사용가능
-- 두 컬럼의 값을 하나의 값으로 생각하고 일치하는 항목을 찾음..
-- (104 SE) = (104 SE) : 같은 값
-- (104 SE-ANLY) != (104 SE) : 다른 값

-- 위의 쿼리문을 조인구문으로 바꿔라
SELECT	EMP_ID, ROLE_NAME
FROM	EMPLOYEE_ROLE
JOIN	ROLE_HISTORY USING (EMP_ID, ROLE_NAME);

-- 집합연산자와 IN 연산자의 관계
-- UNION 과 IN 이 서로 동일한 결과를 만들 수 있다.
-- 직급이 대리 또는 사원인 직원의 이름과 직급명 조회
-- 직급순 오름차순 정렬하고, 직급이 같은경우 이름 오름차순

SELECT	EMP_NAME, JOB_TITLE
FROM	EMPLOYEE
JOIN	JOB USING (JOB_ID)
WHERE	JOB_TITLE IN ('대리', '사원')
ORDER BY 2, 1;

-- UNION으로 바꾸면
SELECT	EMP_NAME, JOB_TITLE
FROM	EMPLOYEE
JOIN	JOB USING (JOB_ID)
WHERE	JOB_TITLE = '대리'
UNION
SELECT	EMP_NAME, JOB_TITLE
FROM	EMPLOYEE
JOIN	JOB USING (JOB_ID)
WHERE	JOB_TITLE ='사원'
ORDER BY 2, 1;


-- ***************************************************************
/*
메소드 (리턴값이 있는 메소드())
컬럼명 비교연산자 비교할 값 <---- 비교할 값을 알아내기위한 SELECT 문을 값 사용 위치에 바로 사용쓸수있다

컬럼명 비교연산자 (SELECT .....)
*/

-- 서브쿼리 (SUB QUERY)
-- 쿼리문 안에 사용된 쿼리문
-- 예 : 나승원 직원과 같은 부서에 소속된 직원 명단조회
--순서 1 나승원 부서 조회
SELECT	DEPT_ID
FROM	EMPLOYEE
WHERE	EMP_NAME = '나승원';
-- 2 조회된 값을 사용하여 부서원 조회
SELECT	EMP_NAME
FROM	EMPLOYEE
WHERE	DEPT_ID  = '50';

-- 서브쿼리를 사용하여 조회
SELECT	EMP_NAME
FROM	EMPLOYEE
WHERE	DEPT_ID  =  (SELECT	DEPT_ID
					FROM	EMPLOYEE
					WHERE	EMP_NAME = '나승원');
-- 서브쿼리의 유형은
-- 단일형 서브쿼리, 다중행 서브쿼리, 다중열 서브쿼리 , 다중열 다중행 서브쿼리
-- 상호연관 서브쿼리, 스칼라 서브쿼리 로 구분된다.
-- 서브쿼리 앞에 붙는 연산자가 달라짐.

-- 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
-- 서브쿼리의 결과값이 한 개인 경우
-- 단일행 서브쿼리앞에는 일반 비교연산자 모두 사용 가능하다.
-- <, >, <= , >= =, != | <> | ^=

-- 나승원과 직급이 같으면서, 나승원 보다 급여를 많이 받는 직원조회
-- 이름, 직급, 급여 조회

--1 나승원 직급 조회
SELECT	JOB_ID
FROM	EMPLOYEE
WHERE	EMP_NAME = '나승원';

--2 나승원 급여 조회
SELECT	SALARY
FROM	EMPLOYEE
WHERE	EMP_NAME = '나승원';

--3 결과 조회
SELECT	EMP_NAME, JOB_ID, SALARY
FROM	EMPLOYEE
WHERE	JOB_ID = 'J5' AND SALARY > 2300000;

-- 서브쿼리 사용
SELECT	EMP_NAME, JOB_ID, SALARY
FROM	EMPLOYEE
WHERE	JOB_ID = (	SELECT	JOB_ID
					FROM	EMPLOYEE
					WHERE	EMP_NAME = '나승원') 
					
AND	SALARY > (	SELECT	SALARY
					FROM	EMPLOYEE
					WHERE	EMP_NAME = '나승원' );
					
-- 직원중에서 최저급여를 받는 직원 조회
SELECT	MIN(SALARY)
FROM	EMPLOYEE;
--
SELECT	EMP_NAME, SALARY
FROM	EMPLOYEE
WHERE	SALARY = (	SELECT	MIN(SALARY)
					FROM	EMPLOYEE);
					
-- 부서별 급여합계 중 가장 큰 값 조회
-- 가장 많은 급여를 받는 부서 조회 HAVING에 서브쿼리 사용
SELECT		DEPT_NAME,
			SUM(SALARY)
FROM		EMPLOYEE
LEFT JOIN	DEPARTMENT USING (DEPT_ID)
GROUP BY 	DEPT_ID, DEPT_NAME
HAVING	SUM(SALARY) = (	SELECT	MAX(SUM(SALARY))
								FROM EMPLOYEE
								GROUP BY DEPT_ID); -- 단일형 서브쿼리

-- 서브쿼리는 SELECT형 FROM절 WHERE절 GROUP BY 절 HAVING 절 ORDER BY절 모두 사용가능								

-- 다중행(MULTIPLE ROW) 서브쿼리 ************************************************************
-- 서브쿼리 결과값의 갯수가 여려개인 경우

-- 부서별 급여 최저값 조회
SELECT	MIN(SALARY)
FROM	EMPLOYEE
GROUP BY DEPT_ID;

-- 부서별로 그 부서의 최저 급여를 받고있는 직원 조회
SELECT	EMP_ID, EMP_NAME, SALARY
FROM	EMPLOYEE
WHERE	SALARY IN (	SELECT	MIN(SALARY)
					FROM	EMPLOYEE
					GROUP BY DEPT_ID); -- 다중행 서브쿼리

/*
다중행 서브쿼리 앞에는 일반 비교 연산자 사용 못 함.
일반 비교 연산자는 한 개의 값을 가지고 비교 판단함
다중행 서브쿼리 앞에 사용할 수 있는 연산자는
컬럼명 IN (다중행 서브쿼리) : 여러개의 값 중 하나라도 일치하는 값이 있다면....
컬럼명 NOT IN (다중행 서브쿼리) : 여러개의 값 중 하나라도 일치하지 않는다면...
컬럼명 > ANY (다중형 서브쿼리) : 여러개의 값 중 하나라도 큰 가? (가장 작은 값 보다 큰가?) 
컬럼명 < ANY (다중형 서브쿼리) : 여러개의 값 중 하나라도 작은 가?  (가장 큰 값 보다 작은가?)
컬럼명 > ALL (다중형 서브쿼리) : 모든 값보다 큰 가? (가장 큰 값 보다 큰 가?) 
컬럼명 < ALL (다중형 서브쿼리) : 모든 값보다 작은 가? (가장 작은 값 보다 작은 가?) 
*/								
								
SELECT	EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM	EMPLOYEE
WHERE	SALARY IN (	SELECT	MIN(SALARY)
					FROM	EMPLOYEE
					GROUP BY DEPT_ID);
					
-- IN/ NOT IN
-- 여러개의 값과 비교하여 같은 값이 있는지  / 같은 값이 없는지 비교
SELECT	DISTINCT MGR_ID
FROM	EMPLOYEE
WHERE	MGR_ID IS NOT NULL;

-- 직원정보에서 관리자만 추출 조회
SELECT	EMP_NAME, EMP_ID, '관리자' 구분
FROM	EMPLOYEE
WHERE	EMP_ID IN(	SELECT	DISTINCT MGR_ID
					FROM	EMPLOYEE
					WHERE	MGR_ID IS NOT NULL)
UNION					
SELECT	EMP_NAME, EMP_ID, '직원' 구분
FROM	EMPLOYEE
WHERE	EMP_ID NOT IN(		SELECT	DISTINCT MGR_ID
							FROM	EMPLOYEE
							WHERE	MGR_ID IS NOT NULL)
ORDER BY 3, 1;							

-- SELECT 절에서도 서브쿼리 사용할 수 있음
SELECT	EMP_NAME, EMP_ID,
		CASE
		WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '관리자'
		ELSE '직원'
		END 구분
FROM	EMPLOYEE
ORDER BY 3, 1;













					
					
					
					
					
					
					
					

