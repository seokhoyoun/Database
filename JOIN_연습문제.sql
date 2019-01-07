--JOIN 연습문제
--
--1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT  TO_CHAR(TO_DATE('20201225','RRRRMMDD'),'DAY') "2020/12/25"
FROM    DUAL;

--2. 주민번호가 60년대 생이면서 성별이 여자이고, 성이 김씨인 직원들의 
--사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT  EMP_NAME 사원명,
            EMP_NO 주민번호,
            DEPT_NAME 부서명,
            JOB_TITLE 직급명
FROM    EMPLOYEE
JOIN    DEPARTMENT USING (DEPT_ID)
JOIN    JOB USING (JOB_ID)
WHERE   SUBSTR(EMP_NO,1,2) LIKE '6_%' AND SUBSTR(EMP_NO,8,1) = '2' AND EMP_NAME LIKE '김%';

--3. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.
SELECT  EMP_ID 사번,
            EMP_NAME 사원명,
            TO_CHAR(SYSDATE,'RRRR') - TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,2),'RR'),'RRRR') 나이,
            DEPT_NAME 부서명,
            JOB_TITLE 직급명
FROM    EMPLOYEE
JOIN    DEPARTMENT USING (DEPT_ID)
JOIN    JOB USING (JOB_ID)
WHERE   TO_CHAR(SYSDATE,'RRRR') - TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,2),'RR'),'RRRR') = (SELECT MIN(TO_CHAR(SYSDATE,'RRRR') - TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,2),'RR'),'RRRR'))                                                                                                                
                                                                                                                                    FROM EMPLOYEE);

--4. 이름에 '성'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT   EMP_ID,
             EMP_NAME,
             DEPT_NAME
FROM    EMPLOYEE
JOIN    DEPARTMENT USING (DEPT_ID)
WHERE   EMP_NAME LIKE '%성%';

--5. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT   EMP_NAME,
             JOB_TITLE,
             DEPT_ID,
             DEPT_NAME
FROM    EMPLOYEE
JOIN    DEPARTMENT USING (DEPT_ID)
JOIN    JOB USING (JOB_ID)
WHERE   DEPT_NAME LIKE '해외영업%';

--6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT   EMP_NAME 사원명,
             BONUS_PCT 보너스포인트,
             DEPT_NAME 부서명,
             LOC_DESCRIBE 근무지역명
FROM    EMPLOYEE2 E
JOIN    DEPARTMENT USING (DEPT_ID)
JOIN    LOCATION L   ON (E.LOC_ID = L.LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL;

--7. 부서코드가 20인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
SELECT   EMP_NAME,
             JOB_TITLE,
             DEPT_NAME,
             LOC_DESCRIBE
FROM    EMPLOYEE2 E
JOIN    JOB USING (JOB_ID)
JOIN    LOCATION L ON (E.LOC_ID = L.LOCATION_ID)
JOIN    DEPARTMENT D ON (E.DEPT_ID = D.DEPT_ID)
WHERE E.DEPT_ID = '20';

--8. 직급별 연봉의 최소급여(MIN_SAL)보다 많이 받는 직원들의
--사원명, 직급명, 급여, 연봉을 조회하시오.
--연봉에 보너스포인트를 적용하시오.

SELECT   EMP_NAME 사원명,
             JOB_TITLE 직급명,
             SALARY 급여,
             (SALARY + (SALARY * NVL(BONUS_PCT,0))) * 12 연봉,
             MIN_SAL
FROM    EMPLOYEE 
JOIN    JOB J USING (JOB_ID)
WHERE  (SALARY + (SALARY * NVL(BONUS_PCT,0))) * 12 > MIN_SAL;

--9. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--사원명(emp_name), 부서명(dept_name), 지역명(loc_describe), 국가명(country_name)을 조회하시오.
SELECT  EMP_NAME,
            DEPT_NAME,
            LOC_DESCRIBE,
            COUNTRY_NAME
FROM   EMPLOYEE 
JOIN    DEPARTMENT USING (DEPT_ID)
JOIN    LOCATION  ON (LOC_ID = LOCATION_ID)
JOIN    COUNTRY  USING (COUNTRY_ID)
WHERE   COUNTRY_ID IN('KO','JP'); 

--10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
--self join 사용
SELECT   E1.EMP_NAME,
             E1.DEPT_ID,         
             E2.EMP_NAME
FROM    EMPLOYEE E1
JOIN EMPLOYEE E2 ON (E1.MGR_ID = E2.EMP_ID)
ORDER BY 2;


--11. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
--단, join과 IN 사용할 것
--
--
--12. 기혼인 직원과 미혼인 직원의 수를 조회하시오.