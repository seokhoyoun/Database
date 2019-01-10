-- DAY 8

-- 다중형 서브쿼리에 사용할수 없는 연산자
-- IN/NOT IN, ANY, ALL

-- 컬럼명 > ANY (다중형 서브쿼리) : 서브쿼리 값들 중에 최소값보다 크나?
-- 컬럼명 < ANY (다중형 서브쿼리) : 서브쿼리 값들 중에 최대값보다 큰가?

-- 대리 직급의 직원 중에서 과장 직급 급여의 최소값보다 많이 받는 직원 조회
SELECT	EMP_ID,
		EMP_NAME,
		JOB_TITLE,
		SALARY		
FROM		EMPLOYEE
JOIN		JOB USING ( JOB_ID )
WHERE	JOB_TITLE = '대리'
AND		SALARY >ANY (	SELECT	SALARY
					FROM		EMPLOYEE
					JOIN		JOB USING( JOB_ID )
					WHERE	JOB_TITLE = '과장');
					
-- 컬럼명 > ALL (다중형 서브쿼리) : 컬럼값이 서브쿼리 결과값들과 비교하여 가장 큰 값보다 큰가?
-- 컬럼명 < ALL (다중형 서브쿼리) : 컬럼값이 서브쿼리 결과값들과 비교하여 가장 작은 값보다 작은가?

-- 과장 직급의 급여중 가장 큰 값보다 급여를 많이 받는 대리 직원 조회
SELECT	EMP_NAME,
		JOB_TITLE,
		SALARY
FROM		EMPLOYEE
JOIN		JOB USING ( JOB_ID )			
WHERE	JOB_TITLE = '대리'
AND		SALARY > ALL (	SELECT	SALARY
					FROM		EMPLOYEE
					JOIN		JOB USING ( JOB_ID )
					WHERE	JOB_TITLE = '과장' );
					
-- 서브쿼리 사용 위치
-- SELECT 절, FROM 절, WHERE 절, GROUP BY 절, HAVING 절, ORDER BY절
-- INSERT문 , UPDATE문, CREATE TABLE 문, CREATE VIEW문

-- 자기 직급에 평균 급여를 받는 직원을 조회
-- 1. WHERE절에서 서브쿼리 사용
SELECT	JOB_ID,
		TRUNC ( AVG ( SALARY ) , -5 )
FROM		EMPLOYEE
GROUP BY 	JOB_ID;

SELECT	EMP_NAME,
		JOB_TITLE,
		SALARY,
		JOB_ID
FROM		EMPLOYEE
LEFT JOIN	JOB USING ( JOB_ID )
WHERE	SALARY IN ( SELECT	TRUNC ( ( AVG (SALARY ) ) , -5 )
				FROM		EMPLOYEE
				GROUP BY 	JOB_ID
				);
				
SELECT	EMP_NAME,
		JOB_TITLE,
		SALARY
		
FROM		EMPLOYEE E
LEFT JOIN	JOB USING (JOB_ID)
WHERE	SALARY IN ( SELECT	TRUNC ( ( AVG (SALARY ) ) , -5 ) 
				FROM		EMPLOYEE L
				LEFT JOIN	JOB USING (JOB_ID)
				WHERE	L.JOB_ID = E.JOB_ID
				
				GROUP BY 	JOB_ID
				);				
--2. FROM 절에서 사용한 서브쿼리
-- FROM 테이블명 >>>> FROM ( 서브쿼리 )
-- 테이블을 대신함
-- 인라인 뷰 (INLINE VIEW) : FROM 절에 사용된 서브쿼리의 결과 집합
-- 조인 처리서 오라클 전용 구문 과 ANSI 표준 구문의 ON 사용시에 테이블 별칭 사용

SELECT	EMP_NAME,
		JOB_TITLE,
		SALARY
FROM		( 
		SELECT	JOB_ID,
				TRUNC ( AVG ( SALARY ) , -5) JOBAVG
		FROM		EMPLOYEE
		GROUP BY	JOB_ID ) V -- 인라인 뷰
LEFT JOIN	EMPLOYEE E ON 	(
					V.JOBAVG = E.SALARY 
					AND	NVL ( V.JOB_ID, ' ' ) = NVL ( E.JOB_ID, ' ' ) 
					)
LEFT JOIN 	JOB J ON ( E.JOB_ID = J.JOB_ID )
ORDER BY	3, 2;

/*
서브쿼리의 종류
단일행 서브쿼리 : 결과값이 항목 1개에 값 1개
다중행 서브쿼리 : 결과값이 항목 1개에 값 여러개
다중열 단일행서브쿼리 : 결과값 항목이 여러개 값은 1행
다중열 다중행 서브쿼리 : 결과값이 항목 여러개, 값 여러행
=> 대부분의 서브쿼리는 서브쿼리가 만든 값을 메인쿼리가 사용하는 구조임
상호연관 서브쿼리 : 서브쿼리가 메인쿼리의 값을 가져다가 결과를 만듦
			메인쿼리의 값에 따라 서브쿼리의 결과도 달라짐
스칼라 서브쿼리 :  상관쿼리이면서 단일행 서브쿼리

*/

-- 3. 상[호연]관 서브쿼리 사용
SELECT	EMP_NAME,
		JOB_TITLE,
		SALARY
FROM		EMPLOYEE E
LEFT JOIN	JOB J ON ( E.JOB_ID = J.JOB_ID )
WHERE	SALARY = 	( 
				SELECT	TRUNC (AVG ( SALARY) , -5 )
				FROM		EMPLOYEE
				WHERE	NVL(JOB_ID,' ') = NVL(E.JOB_ID,' ') 
				)
ORDER BY	2;

--4 다중행 다중열 서브쿼리 사용
SELECT	EMP_NAME,
		JOB_TITLE,
		SALARY
FROM		EMPLOYEE
LEFT JOIN	JOB USING ( JOB_ID )
WHERE	( NVL ( JOB_ID, ' ' ), SALARY )  
		IN	(
			SELECT	NVL ( JOB_ID , ' '),
					TRUNC ( AVG ( SALARY ) , -5 )
			FROM		EMPLOYEE
			GROUP BY NVL ( JOB_ID, ' ' )
			)
ORDER BY 	2;

-- EXISTS / NOT EXISTS 연산자
-- 상관쿼리에만 사용하는 연산자임
-- 서브쿼리의 결과가 존재하지않는지 / 존재하는지 물어보는 연산자임

-- 관리자인 직원 정보 조회
SELECT	EMP_ID,
		EMP_NAME,
		'관리자' 구분
FROM 	EMPLOYEE E
WHERE	EXISTS (
			SELECT	NULL 
			FROM		EMPLOYEE
			WHERE	E.EMP_ID = MGR_ID
				);
-- 서브쿼리의 조건을 만족하는 행들만 골라냄

-- 관리자가 아닌 직원 정보 조회
SELECT	EMP_ID,
		EMP_NAME,
		'직원' 구분
FROM		EMPLOYEE E
WHERE	NOT EXISTS (
				SELECT	NULL
				FROM		EMPLOYEE
				WHERE	E.EMP_ID = MGR_ID
				);
-- 서브쿼리 조건절과 일치하지 않는 행을 골라냄

-- 스칼라 서브쿼리
-- 한컬럼의 한개의 행만 결과로 반환하는 상관커리
-- 상관쿼리 + 단일행 서브쿼리

-- 사원명, 부서코드, 급여 ,해당 직원이 소속된 부서의 급여평균 조회
SELECT	EMP_NAME
		DEPT_ID,
		SALARY,
		(
		SELECT	TRUNC ( AVG ( SALARY ), -5 )
		FROM		EMPLOYEE
		WHERE	DEPT_ID = E.DEPT_ID
		) AS 급여평균
FROM		EMPLOYEE E;

-- CASE 표현식에 서브쿼리 사용
-- 부서의 근무지역이 OT이면 본사팀, 아니면 지역팀 으로 
-- 직원의 근무지역에 대한 소속을 조회
SELECT	EMP_ID,
		EMP_NAME,
		CASE
		WHEN DEPT_ID =  (
					SELECT	DEPT_ID
					FROM		DEPARTMENT
					WHERE	LOC_ID = 'OT'
					) 					THEN '본사팀'
		ELSE '지역팀'
		END AS 소속
		
FROM		EMPLOYEE
ORDER BY	소속 DESC;

-- ORDER BY 절에 스칼라 서브쿼리 사용 가능

-- 직원이 소속된 부서의 부서명이 큰 값부터 정렬되게 직원 정보 조회
SELECT	EMP_ID,
		EMP_NAME,
		DEPT_ID,
		HIRE_DATE
FROM		EMPLOYEE E
ORDER BY	(
		SELECT	DEPT_NAME
		FROM		DEPARTMENT
		WHERE	DEPT_ID = E.DEPT_ID
			) DESC NULLS LAST;
-- TOP-N 분석 *******************************************************
-- 상위 몇 개, 하위 몇개를 조회할 때

-- 인라인 뷰와 RANK() 함수 이용한 TOP-N 분석의 예
-- 예 : 직원 정보에서 급여를 가장 많이 받는 직원 5명 조회

SELECT	*
FROM		(
		SELECT	EMP_NAME,
				SALARY,
				RANK() OVER (ORDER BY SALARY DESC) 순위
		FROM		EMPLOYEE
		)
WHERE	순위 <= 5;

-- ROWNUM 을 이용한 TOP-N 분석
SELECT  	EMP_ID, EMP_NAME, ROWNUM
FROM 	EMPLOYEE
WHERE	SALARY > 3500000
ORDER BY 	2;

-- ROWNUM 행 번호가 붙여지는 시점은 FROM 할 때이다.
-- ORDER BY 하면 행번호가 섞인다.
-- 해결 : ORDER BY 이후에 ROWNUM이 부여되게 하려면 FROM절에 서브쿼리를 사용한다. (인라인 뷰)

-- 급여를 많이 받는 직원 3명 조회
SELECT	ROWNUM, EMP_NAME, SALARY
FROM		EMPLOYEE
WHERE	ROWNUM < 4
ORDER BY 	3 DESC; -- 잘못된 쿼리
-- 급여 내림차순 정렬 전에 ROWNUM이 설정된다.
-- 실제 결과는 다르다.

-- 해결방법 : 정렬 되고나서 ROWNUM이 부여되게끔 하면 가능하다.
-- 인라인뷰를 사용해야한다.

SELECT	EMP_NAME, SALARY, ROWNUM
FROM		(
		SELECT	*
		FROM		EMPLOYEE
		ORDER BY	SALARY DESC
		)
WHERE	ROWNUM < 4;	








