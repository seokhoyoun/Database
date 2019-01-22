-- 프로시저, 함수, 패키지, 커서, 트리거

-- 프로시저 (PROCEDURE)
-- PLSQL 구문을 저장하는 객체
-- 컴파일하여 실행할 수 있음 : 반복 사용가능해진다. 함수(메소드)의 형태를 가짐.

-- 프로시저 객체 생성
-- CREATE OR REPLACE PROCEDURE 프로시저이름(매개변수 모드 자료형,....)
-- PLSQL 구문작성
-- END; /

-- 프로시저 실행
-- EXEC[UTE] 프로시저이름(전달값,....)
-- 프로시저 삭제
-- DROP PROCEDUTE 프로시저이름

SELECT * FROM EMP_COPY;

-- 객체 만들기
CREATE OR REPLACE PROCEDURE DEL_ALL
IS
BEGIN
	DELETE FROM EMP_COPY
	COMMIT;
END;
/
-- 실행
EXECUTE DEL_ALL;
-- 확인
SELECT * FROM EMP_COPY;

-- 프로시저 관련 데이터 딕셔너리 조회
DESC USER_SOURCE;

SELECT NAME, TEXT FROM USER_SOURCE;
-- 이용할 샘플테이블 만들기
CREATE TABLE EMPCPY
AS
SELECT * FROM EMPLOYEE;
-- 직원이름 전달 받아서, 해당 직원의 정보 삭제하는 프로시저
-- 매개변수가 있는 프로시저 만들기
CREATE OR REPLACE PROCEDURE DEL_ENAME (VENAME IN EMPCPY.EMP_NAME%TYPE)
IS 
BEGIN
	DELETE FROM EMPCPY WHERE EMP_NAME LIKE VENAME;
	COMMIT;
END;
/
--프로시저 실행확인
EXEC DEL_ENAME('이%');
SELECT * FROM EMPCPY;

-- IN 모드 , OUT 모드 매개변수가 있는 프로시저만들기
-- 실행시 사번을 전달하면, 해당 사번의 직원이름, 급여 , 직급코드 받아서 출력처리
CREATE OR REPLACE PROCEDURE SEL_EMPID(VEMPID IN EMPLOYEE.EMP_ID%TYPE,
							VENAME	OUT EMPLOYEE.EMP_NAME%TYPE,
							VSAL	OUT EMPLOYEE.SALARY%TYPE,
							VJOB	OUT EMPLOYEE.JOB_ID%TYPE)
IS
BEGIN
	SELECT EMP_NAME, SALARY, JOB_ID
	INTO  VENAME, VSAL, VJOB
	FROM EMPLOYEE
	WHERE EMP_ID = VEMPID;
END;
/

-- 프로시저가 내보내는 값 받을 변수 선언하기 : 바인드 변수
VARIABLE VAR_ENAME VARCHAR2(20);
VARIABLE VAR_SAL NUMBER;
VARIABLE VAR_JOB CHAR(2);

EXEC SEL_EMPID('&사번', :VAR_ENAME, :VAR_SAL, :VAR_JOB);
-- 바인드 변수가 받은 값 확인
PRINT VAR_ENAME;
PRINT VAR_SAL;
PRINT VAR_JOB;

-- 실습
-- DEPARTMENT 테이블을 복사한 DEPT_COPY 만들고
-- 만약에 존재하면 테이블 삭제 후 생성한다.
-- 부서 번호를 전달받아, 해당 부서 삭제하는 프로시저  : DEL_DEPTID
DROP TABLE DEPT_COPY;

CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

CREATE OR REPLACE PROCEDURE DEL_DEPTID(VDID IN DEPARTMENT.DEPT_ID%TYPE)
IS
BEGIN
	DELETE FROM DEPT_COPY WHERE DEPT_ID = VDID;
	COMMIT;
END;
/

EXEC DEL_DEPTID('&부서번호');

SELECT * FROM DEPT_COPY;

-- 실습 : 직원이름 전달받아, 해당직원 정보 삭제하는 프로시저 : DEL_ENAME
-- EMP_COPY 테이블 사용 : 존재하면 삭제하고 새로 만듦

DROP TABLE EMP_COPY;

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE DEL_ENAME(VNAME IN EMPLOYEE.EMP_NAME%TYPE)
IS
BEGIN
	DELETE FROM EMP_COPY WHERE EMP_NAME = VNAME;
	COMMIT;
END;
/
EXEC DEL_ENAME('&직원이름');
SELECT * FROM EMP_COPY;

--******************************************************
-- 함수 (FUNCTION)
-- 프로시저의 다른 점은 RETURN 사용함.
-- 사번을 전달받아, 그 직원의 보너를 계산해서 리턴하는 함수 만들기 : BONUS_CALC
-- 보너스는 급여의 2배로 계산처리한다.
CREATE OR REPLACE FUNCTION BONUS_CALC(VEMPID IN EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS 
	VSAL EMPLOYEE.SALARY%TYPE;
	RESULT NUMBER;
BEGIN
	SELECT SALARY 
	INTO VSAL
	FROM EMPLOYEE 
	WHERE EMP_ID = VEMPID;
	
	RESULT := VSAL * 2;
	RETURN RESULT;
END;
/

-- 실행전에 리턴값 받을 바인드 변수 선언
VARIABLE BONUS NUMBER;
EXEC :BONUS := BONUS_CALC('&사번');
PRINT BONUS;

-- ****************************************************
-- 패키지 (PACKAGE)
-- 프로시저의 함수를 따로 묶어서 관리하는 객체
-- 선언에 대한 HEAD의 구현에 대한 BODY를 각각 따로 작성해야함
-- 자바로 비교하면 HEAD는 INTERFACE로, BODY는 오버라이딩한 클래스 구현부라고 생각하면된다.

-- 패키지 선언 : HEAD 영역
CREATE OR REPLACE PACKAGE PMEMBER
IS
	-- 패키지에 속할 프로시저와 함수 선언함
	PROCEDURE DEL_DEPTNO(DELNO DEPT_COPY.DEPT_ID%TYPE);
	FUNCTION CAL_BONUS(VENAME EMPLOYEE.EMP_NAME%TYPE)
	RETURN NUMBER;
END;
/

-- 패키지 구현부 : BODY
-- 패키지 안에 선언된 프로시저와 함수의 내용 구현부
CREATE OR REPLACE PACKAGE BODY PMEMBER
IS
	-- 프로시저 구현 : 부서번호 전달받아 부서 삭제
	PROCEDURE DEL_DEPTNO(DELNO DEPT_COPY.DEPT_ID%TYPE)
	IS
	BEGIN
		DELETE FROM DEPT_COPY
		WHERE DEPT_ID = DELNO;
		COMMIT;
		DBMS_OUTPUT.PUT_LINE(DELNO ||'번 부서가 삭제되었습니다');
	END;
	-- 함수구현 : 사원명 입력받아 보너스 계산 리턴
	FUNCTION CAL_BONUS(VENAME EMPLOYEE.EMP_NAME%TYPE)
	RETURN NUMBER
	IS
		VSAL EMPLOYEE.SALARY%TYPE;
		RESULT NUMBER;
	BEGIN
		SELECT SALARY INTO VSAL
		FROM EMPLOYEE
		WHERE EMP_NAME = VENAME;
		RESULT := VSAL * 2;
		RETURN RESULT;
	END;	
END;
/

-- 실행확인
SET SERVEROUTPUT ON;
EXEC PMEMBER.DEL_DEPTNO('&부서번호');

-- 함수실행
VARIABLE BONUS NUMBER;
EXEC :BONUS := PMEMBER.CAL_BONUS('&사원명');
PRINT BONUS;

-- ***************************************************
-- 커서 (CURSOR)
-- SELECT 쿼리문의 실행결과 (RESULT SET)에 대한 결과형의 갯수가 여러개일때,
-- 결과형을 하나씩 다루고자 할 때 사용하는 객체임
-- 자바의 ArrayList의 Index(순번)의 비슷한 개념

-- 실습 : 커서로 테이블의 모든 내용을 조회하기
SET SERVEROUTPUT ON;
DECLARE
	V_DEPT DEPARTMENT%ROWTYPE;
	CURSOR C1 IS SELECT * FROM DEPARTMENT;
BEGIN
	DBMS_OUTPUT.PUT_LINE('부서번호	부서명		지역번호');
	DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
	OPEN C1;
	LOOP
		FETCH C1 INTO V_DEPT.DEPT_ID, V_DEPT.DEPT_NAME, V_DEPT.LOC_ID;
		EXIT WHEN C1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(V_DEPT.DEPT_ID||'	'||V_DEPT.DEPT_NAME||'		'||V_DEPT.LOC_ID);
	END LOOP;
	CLOSE C1;
END;
/

-- ******************************************************************
-- 트리거 (TRIGGER)
-- 특정 테이블에 DML이 수행되면, 자동으로 실행되는 이벤트 객체

-- 샘플 준비
SET SERVEROUTPUT ON;
-- 테이블 구조를 복사한 EMPCPY 테이블 만들기
DROP TABLE EMPCPY CASCADE CONSTRAINTS;

CREATE TABLE EMPCPY
AS
SELECT EMP_ID, EMP_NAME, DEPT_ID
FROM EMPLOYEE
WHERE 1 = 0;


-- 실습 : EMPCPY 테이블에 INSERT가 수행이되고 나면, 자동으로 실행되는 트리거 작성 : TR_WELCOME
-- 콘솔에 입사를 환영합니다 출력되게함

CREATE OR REPLACE TRIGGER TR_WELCOME
AFTER INSERT ON EMPCPY
BEGIN
	DBMS_OUTPUT.PUT_LINE('입사를 환영합니다.');
END;
/

-- 트리거 구동 : 자동 실행
INSERT INTO EMPCPY VALUES(777,'홍길동','90');
DELETE FROM EMPCPY WHERE EMP_ID = 777;
SELECT * FROM EMPCPY;

-- 실습 : 사원테이블(EMP03)에 입력되는 사원정보가 자동으로 급여 테이블(SALARY)에
--  해당 사원에 대한 급여정보 자동으로 기록되게 하는 트리거 작성 TR_SALARY
DROP TABLE EMP03;
CREATE TABLE EMP03(
	EMPNO NUMBER(4) PRIMARY KEY,
	ENAME VARCHAR2(15),
	SAL NUMBER(7, 2)
);

CREATE TABLE SALARY(
	NO NUMBER PRIMARY KEY,
	EMPNO NUMBER(4),
	SAL NUMBER(7,2)
	);
CREATE SEQUENCE SAL_SEQ
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

CREATE OR REPLACE TRIGGER TR_SALARY
AFTER INSERT ON EMP03
FOR EACH ROW
BEGIN
	INSERT INTO SALARY VALUES(SAL_SEQ.NEXTVAL, :NEW.EMPNO, :NEW.SAL);
END;
/

-- 확인
INSERT INTO EMP03 VALUES (8000, 'GREG', 3000 );
SELECT * FROM EMP03;
SELECT * FROM SALARY;

/*
1. 상품 테이블 만들기
2. 입고 테이블 만들기
3. 입고 테이블에 제품이 입고되면, 상품 테이블의 재고 수량이 자동으로 변경되게 함.
4. 입력, 수정, 삭제가 실행되면, 재고에 변화를 주도록 트리거 작성함.
*/

-- 1. 테이블 만들고, 샘플 데이터 기록
CREATE TABLE 상품 (
    상품코드  CHAR(4)  CONSTRAINT PK_상품  PRIMARY KEY,
    상품명  VARCHAR2(15) NOT NULL,
    제조사  VARCHAR2(15),
    소비자가격  NUMBER,
    재고수량  NUMBER  DEFAULT 0
);

INSERT INTO 상품 VALUES ('A001', '마우스', 'LG', 1000, DEFAULT);
INSERT INTO 상품 VALUES ('A002', '키보드', '삼성', 2000, 0);
INSERT INTO 상품 VALUES ('A003', '모니터', 'HP', 10000, DEFAULT);

COMMIT;

SELECT * FROM 상품;

CREATE TABLE 입고 (
    입고번호 NUMBER PRIMARY KEY,
    상품코드 CHAR(4)  REFERENCES 상품 (상품코드),
    입고일자 DATE,
    입고수량 NUMBER,
    입고단가 NUMBER,
    입고금액 NUMBER
);


-- 시퀀스 생성
CREATE SEQUENCE 입고_SEQ
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

-- 프로시저 생성 : 입고 테이블에 값 입력하는 프로시저
CREATE OR REPLACE PROCEDURE SP_PRO_INSERT(CODE CHAR,
        SU NUMBER, WON NUMBER)
IS
BEGIN
    INSERT INTO 입고
    VALUES (입고_SEQ.NEXTVAL, CODE, SYSDATE, SU, WON, SU * WON);
    COMMIT;
END;
/

-- 1. 입력 트리거
-- 입고 테이블에 상품이 입력되었을 때 상품 테이블의 재고수량이 증가되게 처리
CREATE OR REPLACE TRIGGER TR_PRODUCT_INSERT
AFTER INSERT ON 입고
FOR EACH ROW
BEGIN
    UPDATE 상품
    SET 재고수량 = 재고수량 + :NEW.입고수량
    WHERE 상품코드 = :NEW.상품코드;   
END;
/

-- 2. 수정 트리거
-- 입고 테이블의 상품의 재고정보가 변경되었을 때 재고수량 변경
-- 예를 들어, 입고된 상품의 수량이 15에서 10으로 변경하면, 
-- 상품 테이블의 재고수량이 25에서 20으로 변경되게 해야함
CREATE OR REPLACE TRIGGER TR_PRODUCT_UPDATE
AFTER UPDATE ON 입고
FOR EACH ROW
BEGIN
    UPDATE 상품
    SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
    WHERE 상품코드 = :OLD.상품코드;
END;
/

-- 삭제 트리거
-- 입고 테이블에서 행을 삭제하면, 삭제된 행의 수량만큼 상품 테이블의 재고수량을
-- 줄임
CREATE OR REPLACE TRIGGER TR_PRODUCT_DELETE
AFTER DELETE ON 입고
FOR EACH ROW
BEGIN
    UPDATE 상품
    SET 재고수량 = 재고수량 - :OLD.입고수량
    WHERE 상품코드 = :OLD.상품코드;    
END;
/

-- 프로시저를 사용하여 INSERT 실행
EXEC SP_PRO_INSERT('A002', 20, 3000);

SELECT * FROM 입고;
SELECT * FROM 상품;

EXEC SP_PRO_INSERT('A002', 10, 3000);

-- 수정 확인
UPDATE 입고
SET 입고수량 = 15
WHERE 입고번호 = 2;

SELECT * FROM 입고;
SELECT * FROM 상품;

-- 삭제 확인
DELETE FROM 입고
WHERE 입고번호 = 4;

SELECT * FROM 입고;
SELECT * FROM 상품;


