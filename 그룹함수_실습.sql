-- 그룹함수 실습 **************************************

-- 부서별 급여평균, 급여는 천단위에서 반올림되게 함.
SELECT	DEPT_ID,
		ROUND(AVG(SALARY),-3)
FROM	EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 1;

-- 성별별 급여 평균  : group by 절에 계산식 사용 가능
-- DECODE, SUBSTR 사용
SELECT	DECODE(SUBSTR(EMP_NO,8,1),1, '남자' , 3, '남자', '여자') 성별, 
		TO_CHAR(ROUND(AVG(SALARY),-3),'999,999,999')||'원' 급여평균
FROM	EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1, '남자' , 3, '남자', '여자');
-- 계산식이 똑같이 입력되어야 함



-- 실습 : 직급별 급여의 합계와 인원수를 조회함
-- 출력은 직급, 급여합게, 인원수 
SELECT	JOB_ID 직급,
		SUM(SALARY) 급여합계,
		COUNT(*) 인원수
FROM	EMPLOYEE
GROUP BY JOB_ID
ORDER BY 1;

-- 실습 : 부서코드와 직급코드를 함께 그룹을 묶고, 
-- 급여의 합계를 구함
-- ROLLUP 사용함

SELECT	DEPT_ID, 
		JOB_ID,
		SUM(SALARY)
FROM	EMPLOYEE
WHERE	DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID)
ORDER BY 1;

-- ************************************************
-- rollup 함수  
/* 부서/직업별 평균임금 조회 */

SELECT	DEPT_ID,
		JOB_ID,
		TO_CHAR(ROUND(AVG(SALARY),-3),'999,999,999') 평균임금
FROM	EMPLOYEE
WHERE	DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID)
ORDER BY 1;







-- cube 함수











