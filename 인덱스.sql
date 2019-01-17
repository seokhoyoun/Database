-- 인덱스 (INDEX)

-- SELECT 문의 처리속도를 빠르게 하기 위해서 테이블의 컬럼값을 키워드로 하여
-- 생성하는 객체임
-- 인덱스는 내부 구조가 이진트리(B*트리) 형식으로 구성됨.
-- 컬럼에 인덱스를 설정하면 이를 위한 이진트리가 구성되어야 하기 때문에
-- 인덱스를 생성하기 위한 시간도 필요하고, 별도의 저장 공간도 필요함.
-- 반드시 좋은 것은 아님
-- 인덱스 생성 후에 DML 작업을 수행하면, 인덱스가 사용된 컬럼값이 변경되므로
-- 이진트리 내부 구조 역시 새로 구성되어야 함. DML 작업이 무거워지게 됨

-- 장점
-- 1. 검색 속도가 빨라짐
-- 2. 시스템의 디스크 입출력 부하를 줄여서 성능을 좋게 함

-- 단점
-- 1. 인덱스를 위한 추가적인 저장 공간이 필요함
-- 2. 인덱스를 생성하는 데 시간이 걸림
-- 3. 데이터의 변경 작업, DML 이 자주 일어날 경우 오히려 성능이 떨어짐

-- 구조
-- 값이 기록된 컬럼(키워드 : 검색에 사용되는 단어)과 값이 기록된 행위치(ROWID)로
-- 구성됨
-- 키워드는 정렬이 된 상태로 구성됨

-- 인덱스 생성 구문
/*
CREATE [UNIQUE] INDEX 인덱스이름
ON 테이블명 (키워드로 쓸 컬럼명);

* 인덱스 객체의 종류
1. 고유 인덱스 (UNIQUE INDEX) : 기본
2. 비고유 인덱스 (NONUNIQUE INDEX)
3. 단일 인덱스 (SINGLE INDEX) : 키워드로 지정하는 컬럼이 1개
4. 결합 인덱스 (COMPOSITE INDEX) : 키워드 컬럼이 여러 개
5. 함수 기반 인덱스 (FUNCTION BASED INDEX) : 키워드가 함수식임.

*/

-- UNIQUE INDEX
-- 중복값이 없는 컬럼에 적용할 수 있음
-- PRIMARY KEY 제약조건을 설정하면, 자동으로 해당 컬럼에 UNIQUE INDEX 생성됨
CREATE UNIQUE INDEX IDX_DNM
ON DEPARTMENT (DEPT_NAME);


-- NONUNIQUE INDEX
-- 같은 값이 여러 번 기록된 컬럼에 적용하는 인덱스
-- 일반 컬럼에 사용함
-- 주로 디스크 입출력에 대한 성능 향상을 위한 목적으로 생성함
CREATE INDEX IDX_JID
ON EMPLOYEE (JOB_ID);

-- 인덱스 생성/사용 테스트
CREATE UNIQUE INDEX IDX_ENM
ON EMPLOYEE (EMP_NAME);
-- UNIQUE INDEX 에 사용된 컬럼은 자동으로 UNIQUE 제약조건 기능을 수행함

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES ('333', '871225-1234567', '심하균');  -- 에러

-- UNIQUE INDEX 는 같은 값이 여러번 기록된 컬럼을 키워드로 설정할 수 없음
CREATE UNIQUE INDEX IDX_DID
ON EMPLOYEE (DEPT_ID);  -- ERROR


-- 인덱스 삭제
-- DROP INDEX 인덱스이름;
DROP INDEX IDX_JID;

-- 테이블이 삭제되면, 관련된 인덱스도 자동으로 함께 삭제됨

-- 인덱스 관련 데이터 딕셔너리 : USER_INDEXES, USER_IND_COLUMNS
DESC USER_INDEXES;
DESC USER_IND_COLUMNS;

SELECT INDEX_NAME, COLUMN_NAME, INDEX_TYPE, UNIQUENESS
FROM USER_INDEXES
JOIN USER_IND_COLUMNS USING (INDEX_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMPLOYEE';

-- 검색 속도 비교해 보기
-- EMPLOYEE 테이블의 모든 정보를 서브쿼리로 복사한 EMPL01, EMPL02
-- 테이블을 만듦
CREATE TABLE EMPL01
AS
SELECT * FROM EMPLOYEE;

CREATE TABLE EMPL02
AS
SELECT * FROM EMPLOYEE;

-- EMPL01 테이블의 EMP_ID 컬럼에 대한 UNIQUE INDEX 만들기
CREATE UNIQUE INDEX IDX_EID
ON EMPL01 (EMP_ID);

-- 인덱스의 사용
-- SELECT 문 실행시 자동 사용됨.
-- EMPL01 과 EMPL02 의 검색 속도 비교해 봄
SELECT * FROM EMPL01
WHERE EMP_ID = '141';  -- 0.003 초

SELECT * FROM EMPL02
WHERE EMP_ID = '141';  -- 0.005 초

-- 결합 인덱스
-- 두 개 이상의 컬럼을 묶어서 키워드로 지정하는 경우
CREATE TABLE DEPT01
AS
SELECT * FROM DEPARTMENT;

-- 부서번호와 부서명을 결합하여 인덱스 생성하기
CREATE INDEX IDX_DEPT01_COMP
ON DEPT01 (DEPT_ID, DEPT_NAME);

-- 데이터 딕셔너리 확인
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'DEPT01';

 -- 함수 기반 인덱스
 -- SELECT 절이나 WHERE 절에 산술계산식이나 함수식이 사용된 경우
 -- 계산식은 인덱스 적용을 받지 않음.
 -- 그런데 계산식으로 검색하는 경우가 빈번하다면, 
 -- 수식이나 함수식을 인덱스로 설정할 수 있음
 CREATE TABLE EMP01
 AS
 SELECT * FROM EMPLOYEE;
 
 CREATE INDEX IDX_EMP01_SALCALC
 ON EMP01 ((SALARY + (NVL(BONUS_PCT, 0) * SALARY)) * 12);
 
-- 딕셔너리 확인
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMP01';






