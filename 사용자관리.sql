-- 사용자(USER) 관리
-- 사용자 계정(접속 아이디)과 암호 설정, 권한 부여

/*
오라클 데이터베이스를 설치하면, 기본적으로 제공되는 계정이 있음
    SYS | SYSTEM
    HR : 샘플 계정임, 처음에는 잠겨있음
    SCOTT : 교육용 샘플 계정임. 버전에 따라 없을 수도 있음. 11G 에는 없음
    
데이터베이스 관리자 (DBA)
 - 사용자에게 DB 관련 객체(테이블, 뷰, 시퀀스, 인덱스 등)에 대한 권한을 부여함
 - 여러 사용자가 공유하는 데이터베이스에 보안 설정함
 - DB에 접근하는 사용자마다 서로 다른 권한과 롤을 부여함
 
권한 : 사용자가 특정 테이블에 접근할 수 있도록 하거나,
    허용되는 테이블에 SQL문(SELECT/INSERT/UPDATE/DELETE)을 
    사용할 수 있도록 제한을 두는 것
    
    * 시스템 권한 : DBA 가 가지고 있는 권한
        CREATE USER (사용자 계정 만들기)
        DROP USER (사용자 계정 삭제)
        DROP ANY TABLE (임의의 테이블 삭제)
        QUERY REWRITE (함수 기반 인덱스 생성)
        BACKUP ANY TABLE (테이블 백업)
        
    * DBA 가 사용자에게 부여하는 권한
        CREATE SESSION (DB에 접속)
        CREATE TABLE (테이블 생성)
        CREATE VIEW (뷰 생성)
        CREATE SEQUENCE (시퀀스 생성)
        CREATE PROCEDURE (프로시저 생성)
        
    * 객체 권한 : 객체를 조작할 수 있는 권한
*/

-- 사용자 계정 만들기
-- 데이터베이스에 접근할 수 있는 아이디와 암호 만들기
-- 형식
/*
CREATE USER 아이디 IDENTIFIED BY 암호;
아이디와 암호는 대소문자 구분함
*/

-- system 계정에서
CREATE USER user01 IDENTIFIED BY pass01;

-- 로그인하면 에러남 : DB에 접속하는 권한(CREATE SESSION)이 없음

-- 권한 부여하기 : GRANT 명령어 사용
-- GRANT 권한종류 TO 사용자아이디 [WITH ADMIN OPTION];
-- 사용자아이디 대신에 PUBLIC 을 사용하면 모든 사용자에게 권한을 준다는 의미임

-- system 계정에서
GRANT CREATE SESSION TO user01;

-- system 계정에서 user01 에게 create table 하는 권한을 부여함
GRANT CREATE TABLE TO user01;

-- 테이블 만들기 하면 에러남 : 테이블 스페이스를 할당받아야 함

-- 테이블 스페이스 (TableSpace)
-- 테이블, 뷰, 그 밖의 데이터베이스 객체들이 저장되는 디스크 상의 장소
-- 관리자로 부터 할당을 받아야 함

-- system 계정에서 확인
SELECT USERNAME, DEFAULT_TABLESPACE
FROM DBA_USERS
WHERE USERNAME = 'USER01';

-- 테이블 스페이스 할당
ALTER USER USER01
QUOTA 2M ON SYSTEM;

-- [연습] ----------------------------------------------------------------
	사용자명 : USER007
	암 호 : PASS007
	테이블스페이스 : 3M
	권 한 : DB 연결, 테이블 생성 허용함
	=> 실행 확인해 봄
	------------------------------------------------------------------------
CREATE USER USER007 IDENTIFIED BY PASS007;

GRANT CREATE SESSION, CREATE TABLE TO USER007;

ALTER USER USER007
QUOTA 3M ON SYSTEM;



--------------------------------------------------------------------------


< 사용자 관리 >
 : 사용자 계정과 암호 설정, 권한 부여

 - 오라클 데이터베이스를 설치하면, 기본적으로 제공되는 계정은
	SYS
	SYSTEM
	SCOTT (교육용 샘플 계정임 : 버전에 따라 잠겨 있을 수 있음)
	HR (샘플 계정임 : 처음에는 잠겨 있음, 11g에 없음)

 - 보안을 위한 데이터베이스 관리자
	: 사용자가 데이터베이스의 객체(테이블, 뷰 등)에 대한 특정 권한을
	가질 수 있게 함.
	다수의 사용자가 공유하는 데이터베이스 정보에 대한 보안 설정함.
	데이터베이스에 접근하는 사용자마다 서로 다른 권한과 롤을 부여함.

 - 권한 : 사용자가 특정 테이블에 접근할 수 있도록 하거나, 
	해당 테이블에 SQL(SELECT/INSERT/UPDATE/DELETE)문을
	사용할 수 있도록 제한을 두는 것

	* 시스템 권한 : 데이터베이스 관리자가 가지고 있는 권한
		CREATE USER (사용자 계정 만들기)
		DROP USER (사용자 계정 삭제)
		DROP ANY TABLE (임의의 테이블 삭제)
		QUERY REWRITE (함수 기반 인덱스 생성)
		BACKUP ANY TABLE (테이블 백업)

	* 시스템 관리자가 사용자에게 부여하는 권한
		CREATE SESSION (데이터베이스에 접속)
		CREATE TABLE (테이블 생성)
		CREATE VIEW (뷰 생성)
		CREATE SEQUENCE (시퀀스 생성)
		CREATE PROCEDURE (함수 생성)

	* 객체 권한 : 객체를 조작할 수 있는 권한

 - 사용자 계정 생성
	: 데이터베이스에 접근할 수 있는 아이디(이름)과 암호 만듦
	[형식]
	CREATE USER 사용자이름
	IDENTIFIED BY 암호;
	
	[실습] --------------------------------------------------------------
	1. system 계정으로 로그인
	SQL> CONN system/암호

	2. 로그인된 계정 확인
	SQL> SHOW USER

	3. 새로운 사용자 계정과 암호 만듦
	SQL> CREATE USER USER01 IDENTIFIED BY PASS01;

	4. 사용자 계정으로 로그인해 봄
	SQL> CONN USER01/PASS01
	-- 에러 발생함 : 사용자에게 권한을 부여하지 않았기 때문임.

 - 권한 부여하기 : GRANT 명령어 사용함
	[형식]
	GRANT 권한종류 
	TO 사용자이름 
	[WITH ADMIN OPTION];

	* 사용자이름 대신 PUBLIC을 기술하면 
	모든 사용자에게 해당 시스템권한이 부여됨

	[실습] 로그인 권한 부여하기 -----------------------------------------
	1. system 게정에서
	SQL> GRANT CREATE SESSION TO USER01;

	2. USER01 로그인함
	SQL> CONN USER01/PASS01
	SQL> SHOW USER

	[실습] 테이블 생성 권한 부여하기 ----------------------------------
	1. USER01 계정에서
	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));
	-- 권한 불충분 에러 발생

	2. system 계정으로 로그인함
	SQL> CONN system/암호
	SQL> SHOW USER

	3. CREATE TABLE 권한 부여함
	SQL> GRANT CREATE TABLE TO USER01;

	4. USER01로 로그인 후, 테이블 다시 생성함
	SQL> CONN USER01/PASS01;
	SQL> SHOW USER

	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));

	5. CREATE TABLE 권한을 주었는데도 테이블이 생성되지 않음
	=> 디폴트 테이블스페이스인 USERS 에 쿼터(QUOTA)를 설정하지
	   않았기 때문임.

 - 테이블스페이스(Tablespace)
	: 테이블, 뷰, 그 밖의 데이터베이스 객체들이 저장되는 디스크상의
	장소
	오라클 설치시 scott 계정의 데이터를 저장하기 위한 USERS 라는
	테이블스페이스가 있음.

	[실습] 새로 생성한 USER01 사용자의 테이블스페이스를 확인하려면
	1. system 계정으로 연결된 상태에서
	SQL> CONN system/암호
	SQL> SHOW USER

	SQL> SELECT USERNAME, DEFAULT_TABLESPACE
		FROM DBA_USERS
		WHERE USERNAME = 'USER01';
	-- 테이블스페이스가 USERS 인 것 확인.

	2. 테이블스페이스 쿼터 할당
	: USER01 사용자가 사용할 테이블스페이스 영역을 할당함
	=> QUOTA 절 사용함. ( 10M, 5M, UNLIMITED 등)
	SQL> ALTER USER USER01
		QUOTA 2M ON SYSTEM;

	3. USER01 로 다시 연결함
	SQL> CONN USER01/PASS01
	SQL> SHOW USER

	4. 테이블 생성함
	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));

	5. 테이블 생성 확인함
	SQL> DESC EMP01;

	[연습] ----------------------------------------------------------------
	사용자명 : USER007
	암 호 : PASS007
	테이블스페이스 : 3M
	권 한 : DB 연결, 테이블 생성 허용함
	=> 실행 확인해 봄
	------------------------------------------------------------------------

 - WITH ADMIN OPTION
	: 사용자에게 시스템 권한을 부여할 때 사용함
	권한을 부여받은 사용자는 다른 사용자에게 권한을 지정할 수 있음
	[형식]
	GRANT CREATE SESSION TO 사용자명
	WITH ADMIN OPTION;

 - 객체 권한 : 테이블이나 뷰, 시퀀스, 함수 등 각 객체별로 DML문을 사용할
	수 있는 권한을 설정하는 것
	[형식]
	GRANT 권한종류 [(컬럼명)] | ALL
	ON 객체명 | ROLE 이름 | PUBLIC
	TO 사용자이름;

	* 권한 종류	설정 객체
	ALTER	:	TABLE, SEQUENCE
	DELETE	:	TABLE, VIEW
	EXECUTE	:	PROCEDURE
	INDEX	:	TABLE
	INSERT	:	TABLE, VIEW
	REFERENCES : 	TABLE
	SELECT	:	TABLE, VIEW, SEQUENCE
	UPDATE	:	TABLE, VIEW


	[실습] -----------------------------------------------------
	: 다른 사용자가 가진 테이블을 조회하고자 한다면
	1. USER01 로 연결
	SQL> CONN USER01/PASS01
	SQL> SHOW USER

	2. USER007 사용자가 USER01이 가진 EMP01 테이블을 
	SELECT 하려면
	SQL> GRANT SELECT 
		ON EMP01
		TO USER007;

	3. USER007 로그인
	SQL> CONN USER007/PASS007
	SQL> SHOW USER

	4. 테이블 접근 확인
	SQL> SELECT * FROM USER01.EMP01;


 - 사용자에게 부여된 권한 조회하기
	: 사용자 권한과 관련된 데이터 딕셔너리

	- 자신에게 부여된 사용자 권한을 알고자 할 때
		* USER_TAB_PRIVS_RECD
	=> SELECT * FROM USER_TAB_PRIVS_RECD;

	- 현재 사용자가 다른 사용자에게 부여한 권한 정보 제공
		* USER_TAB_PRIVS_MADE
	=> SELECT * FROM USER_TAB_PRIVS_MADE;

 - 권한 철회
	: REVOKE 명령어 사용
	[형식]
	REVOKE 권한종류 | ALL
	ON 객체명
	FROM [사용자이름 | ROLE 이름 | PUBLIC];

	[실습] ------------------------------------------------------------
	1. USER01 로그인

	2. 해당 사용자가 설정한 권한 확인
	SQL> SELECT * FROM USER_TAB_PRIVS_MADE;

	3. SELECT 권한 해제함
	SQL> REVOKE SELECT ON EMP01 FROM USER007;

	4. 데이터 딕셔너리에서 삭제 확인함
	SQL> SELECT * FROM USER_TAB_PRIVS_MADE;

 - WITH GRANT OPTION 
	: 사용자가 해당 객체에 접근할 수 있는 권한을 부여 받으면서
	그 권한을 다른 사용자에게 다시 부여할 수 있음

	[실습] -----------------------------------------------------------------
	1. USER01 계정에서
	SQL> GRANT SELECT ON USER01.EMP01 TO USER007
		WITH GRANT OPTION;

	2. USER007 로 로그인
	SQL> GRANT SELECT ON USER01.EMP01 TO STUDENT;
	-- 다른 사용자에게 부여받은 권한을 다시 부여 확인.	





