-- DAY 4

-- 날짜 처리 함수 *********************************
-- SYSDATE 함수
-- 시스템으로 부터 현재 날짜와 시간을 조회

SELECT SYSDATE
FROM DUAL; -- RR//MM/DD 기본 포맷임.

/*
오라클에서는 환경설정, 객체 관련 정보들을 모두 저장 관리하고 있음.
데이터 딕셔너리(데이터 사전) 영역에서 테이블의 형태로 각각 저장되고 있음
데이터 딕셔너리에 저장된 정보는 조회만 할 수 있다. 손 댈수는 없음(수정 불가)
DB 시스템이 자동 저장 관리함
단, 환경설정과 관련된 부분은 세팅 정보를 수정할 수 있음
*/
SELECT *
FROM SYS.NLS_SESSION_PARAMETERS;

-- 날짜 포맷과 관련된 변수 값만 조회
SELECT VALUE
FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT';

-- 날짜 포맷 수정
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-RR';

COMMIT;

-- 확인
SELECT SYSDATE
FROM DUAL;

-- 원래 포맷으로 변경
ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';

COMMIT;

-- ADD_MONTHS(기준날짜값  | 날짜가 기록된 컬럼명, 더하기 할 개월수)
-- 더한 개월수에 대한 날짜가 리턴됨

-- 오늘 날짜에서 10년 뒤에 날짜는?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 120)
FROM DUAL;

-- 직원 테이블에서 입사일이 20년 된 날짜조회

SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 240)
FROM EMPLOYEE;

-- 직원들 중에서, 근무년수가 20년 이상 근무한 직원 정보 조회
-- 사번 이름 부서코드 직급코드 입사일 조회 별칭 처리
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_ID 부서코드,JOB_ID 직급코드, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

-- MONTHS_BETWEEN(날짜1,날짜2)
-- 두 날짜의 개월 수 차이 리턴

-- 직원들의 이름, 입사일, 현재까지 근무일수, 근무개월수, 근무년수 조회
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
           FLOOR(SYSDATE - HIRE_DATE) 근무일수, FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) 근무개월수,
           FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) 근무년수
FROM EMPLOYEE;

-- NEXT_DAY('날짜데이터' | 날짜기록된 컬럼명, '요일이름')
-- 지정한 날짜 뒤쪽 날짜에서 가장가까운 요일의 날짜를 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일')
FROM DUAL;

-- 데이터베이스 사용 언어가 한국어로 지정이 되어있기 때문에 요일이름을 한글 사용.
-- 요일 이름에 영어 사용하면 에러남.
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY')
FROM DUAL; -- ERROR 발생

-- 요일이름에 영어 사용하려면 언어를 변경해야 함
ALTER SESSION
SET NLS_LANGUAGE = AMERICAN;

COMMIT;

ALTER SESSION
SET NLS_LANGUAGE = KOREAN;
COMMIT;
-- 영어로 변경/ 한국어로 재변경

-- LAST_DAY('날짜 데이터' | 날짜가 기록된 컬럼명)
-- 지정한 날짜의 월에대한 마지막 날짜를 리턴함

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- 직원 테이블에서 사원명, 입사일, 입사한 월의 근무일수 조회
-- 주말포함
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, LAST_DAY(HIRE_DATE) - HIRE_DATE "입사한 월의 근무일수"
FROM EMPLOYEE;

-- 오늘 날짜 조회 함수
SELECT SYSDATE,
           SYSTIMESTAMP,
           CURRENT_DATE,
           CURRENT_TIMESTAMP
FROM DUAL;

-- EXTRACT(추출할 항목 FROM 날짜)
-- 날짜데이터에서 원하는 항목만 추출

-- 오늘날짜에서 년도만 추출
SELECT EXTRACT(YEAR FROM SYSDATE),
           EXTRACT(MONTH FROM SYSDATE),
           EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- 직원의 이름, 입사일, 근무년수 조회
SELECT EMP_NAME,
            HIRE_DATE, 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수,
            FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) 근무년수
FROM EMPLOYEE;

-- 형변환 함수 *******************************************
-- 자동형변환
SELECT 20 + '10'
FROM DUAL;
-- 문자 10은 숫자 10으로 자동 형변환

SELECT 20 + TO_NUMBER('10')
FROM DUAL;

-- 자동형병환이 안되는 경우
SELECT SYSDATE - '15/03/25'
FROM DUAL; -- ERROR!! 날짜 포맷에 맞춰서 해도 자동 형변환이 안됨.

-- 직접 형변환 해야한다
SELECT SYSDATE - TO_DATE('15/03/25')
FROM DUAL;

-- 또는
SELECT SYSDATE - TO_DATE('15/03/25','RR/MM/DD')
FROM DUAL;

-- TO CHAR(숫자|날짜, '바꾸고자 원하는 포맷문자를 나열')
-- 숫자나 날짜를 원하는 포맷으로 바꿀 때 사용
SELECT EMP_NAME 이름,
           TO_CHAR(SALARY, 'L99,999,999') 급여,
           TO_CHAR(NVL(BONUS_PCT,0), '90.00') 보너스포인트
FROM EMPLOYEE;           

SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234567, 'L999,999,999') FROM DUAL;
SELECT TO_CHAR(1234567, '00009999999') FROM DUAL;
SELECT TO_CHAR(1234, '999') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DAY DY DDD DD D MON MM RM MONTH YYYY YY RR RRRR') FROM DUAL;

-- 날짜데이터에 포맷 적용시에도 TO_CHAR() 사용함
SELECT SYSDATE,
           TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
           TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE,'RR'),
           TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

SELECT HIRE_DATE,
           TO_CHAR(HIRE_DATE, 'YYYY "년"'), TO_CHAR(HIRE_DATE, 'RRRR" 년"'),
           TO_CHAR(HIRE_DATE,'YY'), TO_CHAR(HIRE_DATE, 'RR'),
           TO_CHAR(HIRE_DATE, 'YEAR')
FROM EMPLOYEE;

SELECT SYSDATE,
           TO_CHAR(SYSDATE, 'YYYY "년" MM "월"'),
           TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'),
           TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, RM)
FROM DUAL;
           
SELECT SYSDATE,
        TO_CHAR(SYSDATE, '"1년기준" DDD "일째"'),
        TO_CHAR(SYSDATE, '"월기준" DD "일째"'),
        TO_CHAR(SYSDATE, '"주기준" D "일째"')
FROM DUAL;

SELECT SYSDATE,
            TO_CHAR(SYSDATE, 'Q"사분기"'),
            TO_CHAR(SYSDATE, 'DAY'),
            TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- 직원 테이블에서 이름, 입사일 조회
-- 입사일은 포맷을 적용해서
-- 2016년 05월 19일 (목) 형식으로 출력처리

SELECT EMP_NAME 이름, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" "("DY")"' ) 입사일
FROM EMPLOYEE;

SELECT EMP_NAME AS 이름,
           SUBSTR(HIRE_DATE, 1, 2)|| '년' ||
           SUBSTR(HIRE_DATE, 4, 2)|| '월' ||
           SUBSTR(HIRE_DATE, 7, 2)|| '일' 입사일
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT EMP_NAME,
           TO_CHAR(HIRE_DATE, 'YYYY-MM-DD AM HH:MI:SS'),
           TO_CHAR(HIRE_DATE, 'YYYY-fmMM-DD AM HH:MI:SS'),
           TO_CHAR(HIRE_DATE, 'YYYY-MM-fmDD HH24:MI:SS')
FROM EMPLOYEE
WHERE EMP_ID = '100';

--날짜 데이터 비교연산자 시간을 가진 값에 대해 날짜만 비교 연산할 수 없음.
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = '90/04/01';

-- 해결
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YY/MM/DD') = '90/04/01';

-- 또는
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01';

-- 날짜만 기록된 경우에는 날짜로 비교연산 할 수 있음
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = '04/04/30';

-- TO_DATE 사용 예
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_CHAR('20100101', 'YYYY, MON') FROM DUAL; -- ERROR!
SELECT TO_CHAR(TO_DATE('20100101','YYYYMMDD'),'YYYY, MON') FROM DUAL;
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;
SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'),
            'DD-MON-YY HH:MI:SS PM') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL;

-- 문자로 된 날짜나 시간 ', '앞의 문자 각 자리별 포맷문자
-- 앞의 문자와 뒤의 포맷문자의 갯수가 같아야 함 : 해석의 의미임
SELECT TO_DATE('20161225','YYYYMMDD'),
           TO_CHAR(TO_DATE('20161225', 'YYYYMMDD'),'DY')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('20201225 134550', 'YYYYMMDD HH24MISS'), 'YY-MM-DD DY AM HH:MI:SS')
FROM DUAL;

SELECT TO_DATE('2013-03-15', 'YYYY-MM-DD')
FROM DUAL;

-- RR의 경우와 YY의 차이
-- 두 자리 년도를 네자리 년도로 바꿀 때
-- 현재년도 (19 : 50보다 작음) 일 때,
-- 바꿀 년도가 50 미만이면 2000년도가 적용, 바꿀 년도가 50이상이면 1900이 적용된다.
SELECT HIRE_DATE,
           TO_CHAR(HIRE_DATE, 'YYYY'), TO_CHAR(HIRE_DATE, 'RRRR')
FROM EMPLOYEE;

-- 현재 년도와 바꿀 년도가 둘 다 50 미만이면 Y,R 둘다 사용가능
SELECT TO_CHAR(TO_DATE('160505','YYMMDD'),'YYYY-MM-DD'),
           TO_CHAR(TO_DATE('160505','RRMMDD'),'RRRR-MM-DD'),
           TO_CHAR(TO_DATE('160505','RRMMDD'),'YYYY-MM-DD'),
           TO_CHAR(TO_DATE('160505','YYMMDD'),'RRRR-MM-DD')
FROM DUAL;

-- 현재 년도가 50 미만이고, 바꿀년도가 50이상일 때,
-- 년도로 바꿀 때, Y 사용하면 현재세기(2000년대 적용)
-- R을 사용하면 이이전세기가 적용됨

SELECT TO_CHAR(TO_DATE('990101','YYMMDD'),'YYYY-MM-DD'), -- 2099
                TO_CHAR(TO_DATE('990101','RRMMDD'),'RRRR-MM-DD'), -- 1999
                TO_CHAR(TO_DATE('990101','YYMMDD'),'RRRR-MM-DD'), --2099
                TO_CHAR(TO_DATE('990101','RRMMDD'),'YYYY-MM-DD') -- 1999
FROM DUAL;

-- 결론 :  문자를 년도로 바꿀 때, 년도에 'R' 사용하면 됨.

-- 기타 함수 ******************************************************

-- NVL(컬럼명, 컬럼의 값이 NULL일 때 바꿀 값)
SELECT EMP_NAME, BONUS_PCT, DEPT_ID, JOB_ID
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(BONUS_PCT, 0.0) 보너스포인트, NVL(DEPT_ID, '00') 부서코드 , NVL(JOB_ID,'J0') 직급코드
FROM EMPLOYEE;

-- NVL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼에 값이 있으면, 바꿀값 1로 변경하고, 값이 NULL이면 바꿀 값2로 변경함

-- 직원정보에서 보너스 포인트가 0.2 미만이거나 NULL인 직원들 조회
-- 사번 이름 보너스포인트 변경보너스포인트
-- 변경보너스포인트는 값이 있으면 0.15로 바꾸고, NULL이면 0.05로 바꿈
SELECT EMP_ID, EMP_NAME, BONUS_PCT, NVL2(BONUS_PCT, 0.15, 0.05)
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 OR BONUS_PCT IS NULL;

-- DECODE(함수식 | 계산식 | 컬럼명, 제시 값1, 선택값1, ....제시값N,선택값N, [DEFAULT 모든제시값이 아닐때 선택됨])
-- 오라클 전용 함수
-- SWITCH문의 형식을 갖는 함수이다.

-- 50번 부서에 속한 직원들의 이름과 성별 조회
-- 성별은 주민번호 8번째 값이 1,3 이면 남자 2 또는 4이면 여자
SELECT EMP_NAME 이름,
            DECODE(SUBSTR(EMP_NO,8,1),
                            '1', '남자',
                            '3', '남자',
                            '2', '여자',
                            '4', '여자') 성별
FROM EMPLOYEE
WHERE DEPT_ID = '50'
ORDER BY 성별, 이름;

-- 직원의 이름과 관리자 사번 조회
-- 관리자 사번이 NULL이면 '관리자없음'으로 출력 처리

-- DECODE() 사용
SELECT EMP_NAME, 
            DECODE(MGR_ID, NULL, '관리자없음', MGR_ID)
FROM EMPLOYEE;

-- NVL 사용
SELECT EMP_NAME,
            NVL(MGR_ID,'관리자없음')
FROM EMPLOYEE;

-- 직급별 급여 인상분이 다를 때
SELECT EMP_NAME, JOB_ID, SALARY,
            DECODE(JOB_ID, 'J7',SALARY * 1.1,
                                    'J6',SALARY * 1.15,
                                    'J5',SALARY * 1.2,
                                    SALARY* 1.05) 인상급여
FROM EMPLOYEE;

-- CASE 표현식
SELECT EMP_NAME, JOB_ID, SALARY,
            CASE JOB_ID
            WHEN 'J7' THEN SALARY * 1.1
            WHEN 'J6' THEN SALARY * 1.15
            WHEN 'J5' THEN SALARY * 1.2
            ELSE SALARY * 1.05
            END 인상급여
FROM EMPLOYEE;

-- CASE 표현식은 다중 IF문처럼 사용할 수도 있음
SELECT EMP_ID, EMP_NAME, SALARY,
            CASE
            WHEN SALARY <= 3000000 THEN '초급'
            WHEN SALARY <= 4000000 THEN '중급'
            ELSE '고급'
            END 구분
FROM EMPLOYEE
ORDER BY 구분;


-- 그룹함수 *********************************************
-- 여러개의 값을 읽어서 계산하고, 하나의 결과를 리턴하는 함수
-- SUM, AVG,MIN, MAX, COUNT
SELECT SUM(SALARY), SUM(DISTINCT SALARY),
            FLOOR(AVG(SALARY)), AVG(DISTINCT SALARY),
            MIN(SALARY), MAX(SALARY),
            COUNT(*), COUNT(SALARY), COUNT(BONUS_PCT)
FROM EMPLOYEE;

--함수 연습문제
--
--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******

SELECT EMP_NAME 직원명, RPAD(SUBSTR(EMP_NO,1,8),14,'*') 주민번호
FROM EMPLOYEE;

--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임

SELECT EMP_NAME 직원명, JOB_ID 직급코드, TO_CHAR((SALARY+(NVL(BONUS_PCT,0)*SALARY)*12), 'L999,999,999') "연봉(원)"
FROM EMPLOYEE
ORDER BY "연봉(원)" DESC;

--3. 부서코드가 50, 90인 직원들 중에서 2004년도에 입사한 직원의 
--   수 조회함.
--	사번 사원명 부서코드 입사일
SELECT COUNT(*) AS  "04년도에 입사한직원수"
FROM EMPLOYEE
WHERE (DEPT_ID = '50' OR DEPT_ID = '90') AND TO_CHAR(HIRE_DATE, 'RRRR') = 2004;

--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--  단, 주말도 포함함
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서, 
--     ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함

SELECT EMP_NAME 직원명, DEPT_ID 부서코드, TO_CHAR(TO_DATE((SUBSTR(EMP_NO,1,6)),'RRMMDD'),'RR"년 "MM"월 "DD"일"') 생년월일,
        FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO,1,6),'RRMMDD'))/12) "나이(만)"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,5,6) <= '31';

--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, sum 사용
--
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------

SELECT COUNT(EMP_NAME) 전체직원수,
        COUNT(DECODE(TO_CHAR(HIRE_DATE,'RRRR'),
                '2001', 1))
FROM EMPLOYEE;

SELECT COUNT(EMP_NAME) 전체직원수,
        SUM(DECODE(TO_CHAR(HIRE_DATE,'RRRR'),'2001', 1)) "2001년",
        SUM(DECODE(TO_CHAR(HIRE_DATE,'RRRR'),'2002', 1)) "2002년",
        SUM(DECODE(TO_CHAR(HIRE_DATE,'RRRR'),'2003', 1)) "2003년",
        SUM(DECODE(TO_CHAR(HIRE_DATE,'RRRR'),'2004', 1)) "2004년"
FROM EMPLOYEE;

--7.  부서코드가 50이면 총무부, 60이면 기획부, 90이면 영업부로 처리하시오.
--   단, 부서코드가 50, 60, 90 인 직원의 정보만 조회함
--  => case 사용
--	부서코드 기준 오름차순 정렬함.

SELECT EMP_NAME, DEPT_ID,
        CASE DEPT_ID
        WHEN '50' THEN '총무부'
        WHEN '60' THEN '기획부'
        WHEN '90' THEN '영업부'
        END 부서코드
FROM EMPLOYEE
WHERE DEPT_ID IN('50','60','90')
ORDER BY DEPT_ID;





