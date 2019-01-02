-- 함수(FUNCTION) ********************************************
-- 단일행 함수와 그룹함수로 구분됨
-- SELCT 절에 같이 사용 못 함

-- 단일행 함수 : 읽은 값이  N개이면, 리턴되는 결과 값도 N개임

SELECT EMAIL, UPPER(EMAIL)
FROM EMPLOYEE;

-- 그룹 함수 : N 개의 값을 읽어서, 1개의 결과를 리턴 함

SELECT SUM(SALARY)
FROM EMPLOYEE;

--SELECT UPPER(EMAIL), SUM(SALARY)
--FROM EMPLOYEE; // 에러 발생

-- 단일 행 함수와 그룹함수는 SELECT 절에서 같이 사용 못 함.
-- 그룹 함수는 WHERE 절에서도 사용 못 함.

-- 예) 전체 직원의 급여의 평균보다 급여를 많이 받는 직원 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPR_ID, JOB_ID
FROM EMPLOYEE
WHERE SALARY > AVG(SALARY); -- 에러발생 !! WHERE 절에서는 그룹 함수를 사용 못함

-- 단일행 (SINGLE ROW) 함수 ************************************************
-- 문자관련 함수 : LENGTH
-- LENGTH('문자열리터럴') | 문자열이 기록된 컬럼명
-- 기록된 문자의 글자갯수가 리턴됨

SELECT LENGTH('ORACLE')
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- LENGTH 함수를 이용하여 CHAR 자료형과 VARCHAR2 자료형 차이점 비교확인
SELECT LENGTH(CHARTYPE), LENGTH(VARCHARTYPE)
FROM COLUMN_LENGTH;

-- LENGTHB() 함수
-- LENGTHB('문자열리터럴') | 문자열이 기록된 컬럼명
-- 기록된 문자의 바이트 수를 리턴함

SELECT LENGTHB(CHARTYPE), LENGTHB(VARCHARTYPE)
FROM column_length;

-- INSTR() 함수
-- INSTR('문자열값'| 문자열이 기록된 컬럼 방, '찾을 문자', 찾을 시작위치, 몇번째 문자)

SELECT EMAIL, INSTR(EMAIL,'@')
FROM EMPLOYEE;

-- 이메일 주소에서 '@' 바로 뒤에 있는 'K' 문자의 위치를 조회한다.
-- 단 뒤에서 부터 검색

SELECT EMAIL, INSTR(EMAIL,'k',-1 , 3)
FROM EMPLOYEE;

-- 함수 중첩사용 가능함
-- 이메일 주소에서 '.' 바로 뒤 글자의 위치 조회
-- 단, '.' 문자 바로 앞글자부터 검색을 시작하도록 함

SELECT EMAIL, INSTR(EMAIL, 'k', INSTR(EMAIL,'@')+1 )
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL,'.')-1 )
FROM EMPLOYEE;


-- LPAD / RPAD('문자열 값 | 컬럼명, 출력시킬 너비 지정[, 남은영역에 채울문자]')
-- 채울문자가 생략되면 기본은 공백문자.
SELECT EMAIL AS 원본데이터, LENGTH(EMAIL) 원본길이,
            LPAD(EMAIL,20,'*') 채우기결과,
            LENGTH(LPAD(EMAIL,20,'*')) 결과길이
FROM EMPLOYEE;

SELECT LTRIM('12355431DUST', '0123456789')
FROM DUAL;

SELECT LTRIM ('            ABCS', ' ' )
FROM DUAL;

SELECT LTRIM ('scoiuhocnsXYZ', 'usxcvczawhocnsqctuoiiutydtere%')
FROM DUAL;

SELECT RTRIM('DSDXCZC1232' , '01239456789')
FROM DUAL;

SELECT TRIM( '6' FROM '6754REAL34'  )
FROM DUAL;

SELECT SUBSTR('HI MY NAME IS XXX' ,4, 2)
FROM DUAL;

SELECT SUBSTR('HI MY NAME IS XXX' ,-3 , 3)
FROM DUAL;

-- 직원들의 주민번호에서 생년 생월 생일을 각각 분리조회
SELECT EMP_NO,
            SUBSTR(EMP_NO, 1, 2) 생년,
            SUBSTR(EMP_NO, 3, 2) 생월,
            SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;

--날짜데이터에도 적용할 수 있음
-- 직원들의 입사일에서 입사년도 입사월 입사일 분리 조회

SELECT HIRE_DATE,
            SUBSTR(HIRE_DATE, 1, 2) 입사년도,
            SUBSTR(HIRE_DATE, 4, 2) 입사월,
            SUBSTR(HIRE_DATE, 7, 2) 입사일
FROM EMPLOYEE;

-- SUBSTRB('문자열값 | 컬럼명,', 추출할 바이트 위치, 추출할 바이트)
SELECT SUBSTR('ORACLE', 3, 2), SUBSTRB('ORACLE', 3,2)
FROM DUAL;

SELECT SUBSTR('오라클' ,2,2) , SUBSTRB('오라클',4,6)
FROM DUAL;

-- UPPER('문자열값' | 컬럼명) : 대문자로 바꾸는 함수
-- LOWER('문자열 값' | 컬럼명) : 소문자로 바꾸는 함수
-- INITCAP('문자열 값' | 컬럼명) : 첫글자만 대문자로 바꾸는 함수

SELECT 'ORACLE', UPPER('ORACLE'), LOWER('ORACLE'), INITCAP('oracle')
FROM DUAL;

-- 함수의 중첩 사용 가능함
-- 함수 안에 값 사용 위치에 함수 사용함
-- 안쪽 함수가 리턴하는 값을 바깥쪽 함수가 사용하는 의미이다.

-- 직원정보에서 이름, 아이디 조회
-- 아이디는 이메일에서 아이디 분리 추출하도록 함.

SELECT EMP_NAME 이름,
           SUBSTR(EMAIL,1, INSTR(EMAIL,'@')-1) 아이디
FROM EMPLOYEE;

-- 직원 테이블에서 사원명, 주민번호를 조회
-- 주민번호는 생년월일 - 성별 만 보이게 하고 나머지는 '*'문자 처리

SELECT EMP_NAME 사원명,
           RPAD(SUBSTR(EMP_NO,1,8), 14,'*') 주민번호
FROM EMPLOYEE;


-- 숫자처리함수 *****************************
-- ROUND, TRUNC, FLOOR, ABS, MOD

-- ROUND(숫자 | 숫자가 기록된 컬럼명 | 계산식, 반올림할 자릿수)
-- 버려지는 값이 5이상이면 자동 반올림됨
-- 자릿수가 양수이면 소숫점 아래 자리 의미
-- 자릿수가 음수이면 소수점 왼쪽 정수부 자리를 의미
SELECT ROUND('122.1234', 2)
FROM DUAL;

SELECT ROUND(54222, -3)
FROM DUAL;

SELECT ROUND(123.1234)
FROM DUAL;

-- 직원 정보에서 사번, 이름, 급여, 보너스포인트, 보너스 포인트가 적용된 연봉 조회
-- 연봉은 별칭 : 1년급여
-- 연봉은 천단위에서 반올림

SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT, ROUND((SALARY +(SALARY * NVL(BONUS_PCT,0)))*12,-4) "1년급여"
FROM EMPLOYEE;

-- TRUNC(숫자 | 컬럼명 | 계산식, 자릿수)
-- 자릿수까지의 값을 버리는 함수임. 반올림 없음

SELECT 145.678,
           TRUNC(145.678),
           TRUNC(145.678, 1),
           TRUNC(145.678, -1),
           TRUNC(145.678, -3)
FROM DUAL;

-- 직원정보에서 급여의 평균을 구함
-- 10자리까지 절사함

SELECT AVG(SALARY), TRUNC(AVG(SALARY),-2), FLOOR(AVG(SALARY))
FROM EMPLOYEE;

-- FLOOR(숫자 | 컬럼명 | 계산식)
-- 소숫점 아래값을 버리는 함수, 정수 만드는 함수임

SELECT ROUND(123.45), TRUNC(123.45), FLOOR(123.45)
FROM DUAL;

-- ABS(숫자 | 컬럼명 | 계산식)
-- 절대값 구하는 함수
-- 음수를 양수로 바꿈
SELECT ABS(123), ABS(-123)
FROM DUAL;

-- 입사일 - 오늘, 오늘 - 입사일 조회 : 별칭은 총 근무일수
-- 근무일수는 정수로 처리, 모두 양수로 출력되게 함

SELECT HIRE_DATE, SYSDATE,
           ABS(FLOOR(HIRE_DATE - SYSDATE)) "총 근무일수",
           ABS(FLOOR(SYSDATE - HIRE_DATE)) " 총 근무일수"
FROM EMPLOYEE;

-- MOD (나눌 값, 나눌 수)
-- 나누기 한 나머지 구하는 함수
SELECT FLOOR(25 / 7), MOD(25,7)
FROM DUAL;

-- 사번이 홀수인 직원들의 정보 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;



