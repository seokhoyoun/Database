-- DAY3

-- SELECT 연습문제 *********************************

--1. 부서코드가 90이면서, 직급코드가 J2인 직원들의 사번, 이름, 부서코드, 직급코드, 급여 조회함
--   별칭 적용함
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_ID 부서코드, 
        JOB_ID 직급코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_ID = '90' AND JOB_ID = 'J2';

--2. 입사일이 '1982-01-01' 이후이거나, 
--  직급코드가 J3 인 직원들의 사번, 이름, 관리자 사번, 보너스포인트 조회함
SELECT EMP_ID 사번, EMP_NAME 이름, MGR_ID 관리자사번, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE HIRE_DATE > '82/01/01' OR JOB_ID = 'J3';

--3. 직급코드가 J4가 아닌 직원들의 급여와 보너스포인트가 적용된 연봉을 조회함.
--  별칭 적용함, 사번, 사원명, 직급코드, 연봉(원)
--  단, 보너스포인트가 null 일 때는 0으로 바꾸어 계산하도록 함.
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_ID 직급코드, 
      (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 || ' (원)' 연봉
FROM EMPLOYEE
WHERE JOB_ID != 'J4';

--4. 보너스포인트가 0.1 이상 0.2 이하인 직원들의 사번, 사원명, 이메일, 급여, 보너스포인트 조회함
SELECT EMP_ID 사번, EMP_NAME 사원명, EMAIL 이메일, SALARY 급여, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT BETWEEN 0.1 AND 0.2;


--5. 보너스포인트가 0.1 보다 작거나(미만), 0.2 보다 많은(초과) 직원들의 사번, 사원명, 보너스포인트, 급여, 입사일 조회함
SELECT EMP_ID 사번, EMP_NAME 사원명, EMAIL 이메일, SALARY 급여, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT NOT BETWEEN 0.1 AND 0.2;

--6. '1982-01-01' 이후에 입사한 직원들의 사원명, 보너스포인트, 급여 조회함
SELECT EMP_NAME 사원명, BONUS_PCT 보너스포인트, SALARY 급여
FROM EMPLOYEE
WHERE HIRE_DATE > '82/01/01';

--7. 보너스포인트가 0.1, 0.2 인 직원들의 사번, 사원명, 보너스포인트, 전화번호 조회함
SELECT EMP_ID 사번, EMP_NAME 사원명, BONUS_PCT 보너스포인트, PHONE 전화번호
FROM EMPLOYEE
WHERE BONUS_PCT IN (0.1, 0.2);

--8. 보너스포인트가 0.1도 0.2도 아닌 직원들의 사번, 사원명, 보너스포인트, 주민번호 조회함
SELECT EMP_ID 사번, EMP_NAME 사원명, BONUS_PCT 보너스포인트, EMP_NO 주민번호
FROM EMPLOYEE
WHERE BONUS_PCT NOT IN (0.1, 0.2);

--9. 성이 '이'씨인 직원들의 사번, 사원명, 입사일 조회함
--  단, 입사일 기준 오름차순 정렬함
SELECT EMP_ID 사번, EMP_NAME 사원명, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE EMP_NAME LIKE '이%'
ORDER BY HIRE_DATE ASC;


--10. 주민번호 8번째 값이 '2'인 직원의 사번, 사원명, 주민번호, 급여를 조회함
--  단, 급여 기준 내림차순 정렬함
SELECT EMP_ID 사번, EMP_NAME 사원명, EMP_NO 주민번호, SALARY 급여
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%'
ORDER BY SALARY DESC;


-- 함수(FUNCTION) ***************************************
-- 단일행함수와 그룹함수로 구분됨
-- SELECT 절에 같이 사용 못 함

-- 단일행함수 : 읽은 값이 n개이면, 리턴되는 결과값도 n개임
SELECT EMAIL, UPPER(EMAIL)
FROM EMPLOYEE;

-- 그룹함수 : n개의 값을 읽어서, 1개의 결과를 리턴함
SELECT SUM(SALARY)
FROM EMPLOYEE;

SELECT UPPER(EMAIL), SUM(SALARY)
FROM EMPLOYEE;  -- ERROR
-- 단일행함수와 그룹함수는 SELECT 절에서 같이 사용 못 함

-- 그룹함수는 WHERE 절에서도 사용 못 함
-- 예 : 전체 직원의 급여의 평균보다 급여를 많이 받는 직원 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_ID, JOB_ID
FROM EMPLOYEE
WHERE SALARY > AVG(SALARY);  -- ERROR


-- 단일행(SINGLE ROW) 함수 *********************
-- 문자관련 함수 : LENGTH
-- LENGTH('문자열리터럴' | 문자열이 기록된 컬럼명)
-- 기록된 문자의 글자갯수가 리턴됨

SELECT LENGTH('ORACLE')
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- LENGTH() 함수를 이용해서, CHAR 자료형과 VARCHAR2 자료형 차이점 비교 확인
SELECT LENGTH(CHARTYPE), LENGTH(VARCHARTYPE)
FROM COLUMN_LENGTH;

-- LENGTHB() 함수
-- LENGTHB('문자열리터럴' | 문자열이 기록된 컬럼명)
-- 기록된 문자의 바이트수를 리턴함

SELECT LENGTHB(CHARTYPE), LENGTHB(VARCHARTYPE)
FROM COLUMN_LENGTH;

-- INSTR() 함수
-- INSTR('문자열값' | 문자열이 기록된 컬럼명, '찾을문자'[, 찾을시작위치, 몇번째문자])

SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- 이메일 주소에서 '@' 문자 바로 뒤에 있는 'k' 분자의 위치를 조회함
-- 단, 뒤에서 부터 검색함
SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3)
FROM EMPLOYEE;

-- 함수 중첩 사용 가능함
-- 이메일 주소에서 '.' 바로 뒤 글자의 위치 조회
-- 단, '.' 문자 바로 앞글자부터 검색을 시작하도록 함
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') - 1)
FROM EMPLOYEE;


-- LPAD / RPAD('문자열값' | 컬럼명, 출력시킬 너비지정[, 남은영역에 채울문자])
-- 채울문자가 생략되면, 기본은 공백문자임.
SELECT EMAIL 원본, LENGTH(EMAIL) 원본길이,
        LPAD(EMAIL, 20, '*') 채우기결과,
        LENGTH(LPAD(EMAIL, 20, '*')) 결과길이
FROM EMPLOYEE;

SELECT EMAIL 원본, LENGTH(EMAIL) 원본길이,
        RPAD(EMAIL, 20, '*') 채우기결과,
        LENGTH(RPAD(EMAIL, 20, '*')) 결과길이
FROM EMPLOYEE;

-- LTRIM / RTRIM('문자열값 | 컬럼명[, '제거할문자들'])
-- 제거할 문자가 생략되면, 기본값은 공백문자임
SELECT LTRIM('   tech') FROM DUAL;-- tech
SELECT LTRIM('   tech', ' ') FROM DUAL; --tech
SELECT LTRIM('000123', '0') FROM DUAL; --123
SELECT LTRIM('123123Tech', '123') FROM DUAL; --Tech
SELECT LTRIM('123123Tech123', '123') FROM DUAL; --Tech123
SELECT LTRIM('xyxzyyyTech', 'xyz') FROM DUAL; --Tech
SELECT LTRIM('6372Tech', '0123456789') FROM DUAL; --Tech

SELECT RTRIM('tech   ') FROM DUAL; --tech
SELECT RTRIM('tech   ', ' ') FROM DUAL; --tech
SELECT RTRIM('123000', '0') FROM DUAL; --123
SELECT RTRIM('Tech123123', '123') FROM DUAL; --Tech
SELECT RTRIM('123Tech123', '123') FROM DUAL; --123Tech
SELECT RTRIM('Techxyxzyyy', 'xyz') FROM DUAL; --Tech
SELECT RTRIM('Tech6372', '0123456789') FROM DUAL; --Tech

-- TRIM(LEADING | TRALING | BOTH '제거할 문자' FROM '문자열값' | 컬럼명)
SELECT TRIM('  tech  ') FROM DUAL; --tech
SELECT TRIM('a' FROM 'aatechaaa') FROM DUAL; --tech
SELECT TRIM(LEADING '0' FROM '000123') FROM DUAL; --123
SELECT TRIM(TRAILING '1' FROM 'Tech1') FROM DUAL; --Tech
SELECT TRIM(BOTH '1' FROM '123Tech111') FROM DUAL; --23Tech
SELECT TRIM(LEADING FROM '  Tech  ') FROM DUAL; --Tech



-- SUBSTR('문자열값' | 컬럼명, 추출할 시작위치[, 추출할 글자갯수])
-- 추출할 시작위치 : 양수(앞에서부터의 위치), 음수(뒤에서부터의 위치)
-- 추출할 글자갯수가 생략되면, 마지막 끝 글자까지 추출을 의미함

SELECT SUBSTR('This is a test', 6, 2) FROM DUAL; --is
SELECT SUBSTR('This is a test', 6) FROM DUAL; --is a test
SELECT SUBSTR('이것은 연습입니다', 3, 4) FROM DUAL; --은 연습
SELECT SUBSTR('TechOnTheNet', 1, 4) FROM DUAL; --Tech
SELECT SUBSTR('TechOnTheNet', -3, 3) FROM DUAL; --Net
SELECT SUBSTR('TechOnTheNet', -6, 3) FROM DUAL; --The
SELECT SUBSTR('TechOnTheNet', -8, 2) FROM DUAL; --On

-- 직원들의 주민번호에서 생년, 생월, 생일을 각각 분리 조회
SELECT EMP_NO, 
        SUBSTR(EMP_NO, 1, 2) 생년,
        SUBSTR(EMP_NO, 3, 2) 생월,
        SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;

-- 날짜 데이터에도 적용할 수 있음
-- 직원들의 입사일에서 입사년도, 입사월, 입사일을 분리 조회
SELECT HIRE_DATE, 
        SUBSTR(HIRE_DATE, 1, 2) 입사년도,
        SUBSTR(HIRE_DATE, 4, 2) 입사월,
        SUBSTR(HIRE_DATE, 7, 2) 입사일
FROM EMPLOYEE;


-- SUBSTRB('문자열값' | 컬럼명, 추출할 바이트 위치, 추출할 바이트)
SELECT SUBSTR('ORACLE', 3, 2), SUBSTRB('ORACLE', 3, 2)
FROM DUAL;

SELECT SUBSTR('오라클', 2, 2), SUBSTRB('오라클', 4, 6)
FROM DUAL;

-- UPPER('문자열값' | 컬럼명) : 대문자로 바꾸는 함수
-- LOWER('문자열값' | 컬럼명) : 소문자로 바꾸는 함수
-- INITCAP('문자열값' | 컬럼명) : 첫글자만 대문자로 바꾸는 함수
SELECT 'ORACLE', UPPER('ORACLE'), UPPER('oracle'),
        LOWER('ORACLE'), LOWER('oracle'),
        INITCAP('ORACLE'), INITCAP('oracle')
FROM DUAL;

-- 함수의 중첩 사용 가능함
-- 함수 안에 값 사용 위치에 함수 사용함.
-- 안쪽 함수가 리턴하는 값을 바깥쪽 함수가 사용한다는 의미임.

-- 직원 정보에서 이름, 이이디 조회
-- 아이디는 이메일에서 아이디를 분리 추출하도록 함
SELECT EMP_NAME 이름, EMAIL 이메일,
        SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) 아이디
FROM EMPLOYEE;


-- 직원 테이블에서 사원명, 주민번호를 조회
-- 주민번호는 생년월일-성별 만 보이게 하고, 나머지는 '*'로 출력되게 함
-- 781125-1******
SELECT EMP_NAME 사원명, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민번호
FROM EMPLOYEE;

-- 숫자 처리 함수 ****************************************
-- ROUND, TRUNC, FLOOR, ABS, MOD

-- ROUND(숫자 | 숫자가 기록된 컬럼명 | 계산식, 반올림할 자릿수)
-- 버려지는 값이 5이상이면 자동 반올림됨
-- 자릿수가 양수이면, 소숫점 아래 자리를 의미함
-- 자릿수가 음수이면, 소숫점 왼쪽 정수부 자리를 의미함.

SELECT ROUND(125.315) FROM DUAL; -- 125
SELECT ROUND(125.315, 0) FROM DUAL; -- 125
SELECT ROUND(125.315, 1) FROM DUAL; -- 125.3
SELECT ROUND(125.315, -1) FROM DUAL; -- 130
SELECT ROUND(125.315, 3) FROM DUAL; -- 125.315
SELECT ROUND(-125.315, 2) FROM DUAL; -- -125.32



-- 직원 정보에서 사번, 이름, 급여, 보너스포인트, 보너스포인트가 적용된 연봉 조회
-- 연봉은 별칭 : 1년급여
-- 연봉은 천단위에서 반올림함
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT,
        ROUND((SALARY + (NVL(BONUS_PCT, 0) * SALARY)) * 12, -4) "1년급여"
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
-- 10자리까지 절삭함
SELECT AVG(SALARY), TRUNC(AVG(SALARY), -2), FLOOR(AVG(SALARY))
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

-- 입사일 - 오늘, 오늘 - 입사일 조회 : 별칭은 총근무일수
-- 근무일수는 정수로 처러. 모두 양수로 출력되게 함
SELECT HIRE_DATE,
        ABS(FLOOR(HIRE_DATE - SYSDATE)) 총근무일수,
        ABS(FLOOR(SYSDATE - HIRE_DATE)) 총근무일수
FROM EMPLOYEE;

-- MOD(나눌 값, 나눌 수)
-- 나누기한 나머지 구하는 함수
SELECT FLOOR(25 / 7) 몫, MOD(25, 7) 나머지
FROM DUAL;

-- 사번이 홀수인 직원들의 정보 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;