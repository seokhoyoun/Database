-- DAY2 수업내용

/*
오라클 자료형
 - NUMBER(정수, 실수숫자), VARCHAR2(가변길이 문자열),
   CHAR(고정길이 문자열), DATE(날짜, 시간), LONG(가변길이문자열)
   
 - NUMBER : 기본은 정수형임. 기본자릿수도 7임.
   NUMBER(자릿수) => NUMBER(12) : 정수를 최대 12자리까리 기록
   NUMBER(최대기록자릿수, 소숫점아래 자릿수) : 실수형 값을 기록
     => NUMBER(10, 2) : 실수형 값을 최대 10자리까지 기록
                        소숫점 아래 자릿수는 2째자리까지 기록가능
 - CHAR(지정자릿수) : 지정한 글자바이트 사이즈만큼의 글자를 기록함.
    CHAR(10) : 무조건 10바이트 기록함.
            만약, 5바이트만 기록하면 나머지 바이트는 공백문자로 채움.
 - VARCHAR2(최대기록글자바이트수) : 지정한 바이트사이즈 이하의 글자를 기록함
    VARCHAR2(15) : 최대 15바이트 이내의 글자로 기록함.
            10바이트 기록하면 그대로 10바이트가 글자크기임.
 - DATE : 날짜와 시간 처리용
    세기, 년, 월, 일, 시, 분, 초, 오전/오후, 요일 처리
    한국어일 때는 포맷이 YY/MM/DD 임
    영어일 때는 포맷이 DD/MON/YY 임
*/

-- 날짜 포맷 확인
SELECT SYSDATE
FROM DUAL;

-- 오라클 데이터베이스 환경설정 변수 값 확인하기
SELECT * 
FROM V$NLS_PARAMETERS;

-- 한글 바이트 크기 확인하기
SELECT LENGTH('오라클'), LENGTHB('오라클'), LENGTHB('가')
FROM DUAL;

-- 날짜 데이터 계산 가능함
SELECT SYSDATE + 100 FROM DUAL;  -- 오늘부터 100일 뒤의 날짜 조회
SELECT SYSDATE - 300 FROM DUAL;  -- 오늘 기준 300일 전의 날짜 조회

SELECT SYSDATE - HIRE_DATE  -- 오늘 - 입사일 : 날짜수(근무일수)
FROM EMPLOYEE;

SELECT SYSDATE + 120 / 24 FROM DUAL;
-- 지금부터 120시간 뒤의 날짜 조회

-- SELECT 문 **********************************************
-- DQL(Data Query Language)
-- 데이터베이스에 테이블의 형태로 기록된 데이터를 조회할 때 사용하는 구문임

-- 사용 1
-- 직원 테이블(EMPLOYEE)에서 사번(EMP_ID), 사원명(EMP_NAME), 
-- 전화번호(PHONE) 컬럼값 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE;

-- 사용 2
-- 직원 테이블에서 관리자 사번이 100인(팀장인 한선기 인) 직원 조회
SELECT *
FROM EMPLOYEE
WHERE MGR_ID = '100';


-- 사용 3
-- 직원 테이블에서 한선기 팀장(사번이 100인)의 관리를 받고 있는 직원 조회
-- 사번, 이름, 전화번호, 부서코드 조회
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_ID
FROM EMPLOYEE
WHERE MGR_ID = '100';

-- 사용 4
-- 직원 테이블과 부서 테이블(DEPARTMENT)에서 정보 조회
-- 사번, 이름, 급여, 부서명  조회
select emp_id, emp_name, salary, dept_name
from employee
join department using (dept_id)
where dept_id = '50'
order by emp_name asc;

-- SELECT 구문 형식 ***************************************
/*
기본구문
SELECT * | [DISTINCT] 조회할 컬럼명 | 계산식 [AS] 별칭(ALIAS)
FROM 조회에 사용할 테이블명;
*/

-- * : 모든 컬럼 (테이블이 가진 컬럼 전부 다)
SELECT * 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사번, 사원명, 급여 정보를 조회할 경우
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DISTINCT 컬럼명
-- 직원 테이블에 사용된 직급코드를 조회할 경우
SELECT JOB_ID
FROM EMPLOYEE;

SELECT DISTINCT JOB_ID
FROM EMPLOYEE;
-- DISTINCT 는 SELECT 절에 딱 1번만 사용할 수 있음

SELECT DISTINCT JOB_ID, DISTINCT DEPT_ID
FROM EMPLOYEE;  -- ERROR

SELECT DISTINCT JOB_ID, DEPT_ID
FROM EMPLOYEE;

-- SELECT 절에 계산식을 사용할 수도 있음
SELECT 23 + 31 / 5
FROM DUAL;  -- DUMMY(더미) 테이블

-- 직원 테이블에서 사번, 사원명, 급여, 1년치 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- 직원 테이블에서 사번, 사원명, 급여, 보너스포인트, 
-- 보너스포인트가 적용된 연봉 조회
-- 계산식 : (급여 + (급여 * 보너스포인트)) * 12
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT,
       (SALARY + (SALARY * BONUS_PCT)) * 12
FROM EMPLOYEE;
-- 계산값에 NULL 이 있으면, 결과도 NULL 이 됨.

-- 계산식에 함수 사용할 수 있음
-- 컬럼의 값이 NULL 인 경우에 다른 값으로 바꾸는 함수 
-- NVL(컬럼명, 바꿀값)
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT,
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12
FROM EMPLOYEE;

-- SELECT 절에 나열된 컬럼명 또는 계산식 뒤에 별칭(ALIAS) 사용할 수도 있음
-- 별칭에 반드시 "별칭"로 묶어야 하는 경우 : 별칭에 공백이나 숫자, 기호문자 사용
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY AS "급여(원)",
        SALARY * 12 AS "1년급여", BONUS_PCT "보너스 포인트",
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "보너스포인트적용연봉"
FROM EMPLOYEE;

-- SELECT 절에 리터럴(LITERAL : 값)을 사용할 수도 있음
SELECT EMP_ID 사번, EMP_NAME 이름, '재직' 상태
FROM EMPLOYEE;

/*
WHERE 절 사용
3 : SELECT 컬럼명 별칭,   ...... 
1 : FROM 테이블명
2 : WHERE 컬럼명 비교연산자 비교값

- 반드시 FROM 절 다음에 사용해야 함
- 조건절임 : 테이블에서 조건과 일치하는 값을 가진 행들을 골라냄
- 비교연산자 : > (크냐, 초과), < (작으냐, 미만), >= (크거나 같으냐, 이상),
           <= (작거나 같으냐, 이하), = (같으냐, 일치하는),
           !=, <>, ^= (일치하지 않는, 같지 않은)
- 논리연산자 : AND(&& 와 같음), OR(|| 와 같음), NOT(! 와 같음)           
*/

-- 부서코드가 '90'인 직원들만 조회할 경우
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- 직급코드가 'J7'인 직원들만 조회할 경우
SELECT *
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

-- 급여가 4백만을 초과하는 직원들만 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY > 4000000;


-- 급여가 2백만이상 4백만이하인 직원의 정보 조회
-- 사번, 이름, 급여, 직급코드, 부서코드 조회, 별칭 처리
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, 
        JOB_ID 직급코드, DEPT_ID 부서코드
FROM EMPLOYEE
--WHERE SALARY >= 2000000 AND SALARY <= 4000000;
WHERE SALARY BETWEEN 2000000 AND 4000000;

-- 날짜 데이터에도 컬럼명 BETWEEN 작은값 AND 큰값 적용할 수 있음
-- 입사일이 1995년 1월 1일부터 2000년 12월 31일 사이에 입사한
-- 직원의 사번, 이름, 입사일, 부서코드 조회, 별칭 처리

-- 날짜데이터 표기시에는 데이터베이스가 정한 날짜 포맷에 맞춰서
-- '날짜형식' 묶어서 표기해야 함
SELECT SYSDATE FROM DUAL; -- '18/12/31' 표현하면 됨

SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드
FROM EMPLOYEE
--WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';
WHERE HIRE_DATE BETWEEN '95/01/01' AND '00/12/31';

-- 부서코드가 '90'이면서, 급여가 2백만을 초과하는 직원 조회
-- 90번 부서에 소속된 직원중에서 급여를 2백만보다 많이 받는 직원 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '90' AND SALARY > 2000000;

-- 부서코드가 90 또는 20 인 직원 조회
-- 20번, 90번 부서에 소속된 직원 조회
SELECT * 
FROM EMPLOYEE
--WHERE DEPT_ID = '20' OR DEPT_ID = '90';
WHERE DEPT_ID IN ('20', '90');

-- 연결 연산자 : || (자바의 문자열합치기하는 + 와 같은 의미의 연산자임)
-- SELECT 절에서 조회한 컬럼값들을 하나로 합치거나, 컬럼값과 리터럴을 합칠 경우
SELECT EMP_NAME || ' 직원의 급여는 ' || SALARY || ' 원입니다.' AS 급여정보
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- 2000년 1월 1일 이후에 입사한 직원 중에서
-- 기혼인 직원의 이름, 입사일, 직급코드, 부서코드, 급여, 결혼여부 조회, 별칭 처리
-- 급여값 뒤에는 '(원)' 리터럴 붙여줌
-- 결혼여부 는 리터럴을 채움 : '기혼' 이 출력되게 적용함
SELECT EMP_NAME 이름, HIRE_DATE 입사일, JOB_ID 직급코드, 
        DEPT_ID 부서코드, 
        SALARY || ' (원)' 급여, '기혼' 결혼여부
FROM EMPLOYEE
WHERE HIRE_DATE >= '00/01/01' AND MARRIAGE = 'Y';

-- 급여를 2백만보다 적게 받거나, 4백만보다 많이 받는 직원 조회
-- 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY < 2000000 OR SALARY > 4000000;
--WHERE NOT (SALARY >= 2000000 AND SALARY <= 4000000);
--WHERE SALARY NOT BETWEEN 2000000 AND 4000000;
WHERE NOT SALARY BETWEEN 2000000 AND 4000000;

-- LIKE 연산자
-- 문자열값에 패턴을 제시해서, 패턴과 일치하는 값을 골라낼 때 사용하는 연산자임
-- 문자열 패턴에 와일드카드 문자 사용함
--     : %(0개 이상의 문자들), _(문자한자리)

-- 성이 '김'씨인 직원의 정보 조회
-- 사번, 이름, 주민번호, 전화번호 조회, 별칭 처리
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, 
        PHONE 전화번호
FROM EMPLOYEE
WHERE EMP_NAME LIKE '김%';

-- 이름에 '해' 자가 포함된 직원 정보 조회
-- 이름, 주민번호, 전화번호, 결혼유무 조회, 별칭 처리
SELECT EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호, MARRIAGE 결혼유무
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%해%';

-- 전화번호의 국번(4번째값)이 '9'로 시작하는 직원 정보 조회
-- 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- 성별이 여자인 직원 조회
-- 사번, 이름, 주민번호, 전화번호 조회
-- 성별 판단 : 주민번호 8번째 문자가 1이면 남자, 2이면 여자임.
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2%';

-- 남자 직원 명단 조회
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호
FROM EMPLOYEE
--WHERE EMP_NO NOT LIKE '_______2%';
--WHERE NOT EMP_NO LIKE '_______2%';
WHERE EMP_NO LIKE '_______1%';

-- 기록된 문자에 '_'나 '%' 가 문자로 기록되어 있는 경우
-- 와일드카드 문자와 기록된 문자를 구분해야 하는 경우
-- ESCAPE 옵션 사용함

-- 이메일에서 기록된 '_' 문자 앞 글자가 3글자인 이메일 정보 조회
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '___\_%' ESCAPE '\';
WHERE EMAIL LIKE '___#_%' ESCAPE '#';


-- IS NULL / IS NOT NULL
-- 관리자도 없고, 부서도 배정받지 못한 직원 조회
SELECT *
FROM EMPLOYEE
WHERE MGR_ID IS NULL AND DEPT_ID IS NULL;

-- 관리자는 없는데, 부서는 배정받은 직원 조회
SELECT *
FROM EMPLOYEE
WHERE MGR_ID IS NULL AND DEPT_ID IS NOT NULL;

-- 부서와 직급 둘 다 배정받지 못한 직원 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND JOB_ID IS NULL;

-- 보너스포인트가 없는 직원 조회
SELECT *
FROM EMPLOYEE
WHERE BONUS_PCT IS NULL;

-- 부서배치는 받지 않았는데, 보너스포인트는 받는 직원 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;

-- 연산자 우선순위 예
-- 부서코드가 20 또는 90인 직원 중에서 급여를 3백만보다 많이 받는 직원 조회
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
--WHERE DEPT_ID = '20' OR DEPT_ID = '90' AND SALARY > 3000000;
--WHERE (DEPT_ID = '20' OR DEPT_ID = '90') AND SALARY > 3000000;
WHERE DEPT_ID IN ('20', '90') AND SALARY > 3000000;