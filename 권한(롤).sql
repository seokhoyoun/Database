-- 데이터베이스 롤 - 권한제어
/*
사용자마다 일일이 권한을 부여하는것은 번거로움
오라클에서는 간편하게 권한을 부여하는 방법으로 롤(ROLE)을 제공한다.

- 여러개의 권한을 묶어놓은것
- 사용자 권한을 보다 간편하고 효율적으로 부여할 수 있게 됨.
- 다수의 사용자에게 공통으로 필요한 권한들을 롤이 하나의 그룹으로 묶어두고,
-사용자마다 특정 롤에 대한 권한을 구분해서 부여할 수 있도록 한다.

- 사용자 구룹별로 권한 수정이 필요한 경우도, 롤만 수정하면 부여된 그룹에 자동 반영된다.
 일일이 사용자마다 하나씩 권한 수정을 하지않아도 된다.
 
 - 롤을 활성화 / 비활성화하여 일시적으로 권한을 부여했다 철회했다 할 수도 있다.
 
 -- 철회 종류
	* 사전 정의된 ROLE (데이터베이스가 제공하는 롤)
	* 사용자가 정의한 ROLE
	
- 사전 정의된 ROLE
	: 오라클에서 기본으로 제공되는 롤
	
	* CONNECT ROLE : 사용자가 데이터베이스에 접속할 수 있도록 시스템 권한 8가지를 묶어 놓았음.
(CREATE SESSION, ALTER SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM, CREATE SEQUENCE, CREATE CLUSTER, CREATE DATABASE LINK)
	* RESOURCE ROLE : 사용자가 객체를 생성 할 수 있도록 하는 권한을 묶어 놓았음
(CREATE CLUSTERM CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE, CREATE TRIGGER)
	* DBA ROLE : 사용자가 소유한 데이터베이스 객체를 관리하고, 사용자 계정 만들고 편집하고 제거할 수 있는 모든 권한을 가짐.
				시스템 권한을 부여하는 가장 강력한 롤이다. 
- 롤을 이용한 권한 부여하기
	: 일반적으로 사용자 생성할 때, CONNECT ROLE 과 RESOURCE ROLE을 많이 사용한다.
- GRANT 롤이름,롤이름,.... TO 사용자계정

*/

-- 롤 관련 딕셔너리
-- 롤을 확인하기 위한 데이터 딕셔너리의 종류는 아주 많다.
-- 관리자가 사용자에게 부여한 롤 정보 확인
SELECT * FROM DICT
WHERE TABLE_NAME LIKE '%ROLE%'; -- 9개의 테이블 존재확인 (관리자계정)

-- 현재 사용자 (student)에게 부여된 롤 확인해보기
SELECT * FROM USER_ROLE_PRIVS;

-- ROLE_SYS_PRIVS : 롤에 부여된 시스템 권한 정보
-- ROLE_TAB_PRIVS : 롤에 부여된 테이블 관련 권한 정보
-- USER_ROLE_PRIVS : 접근 가능한 롤 정보
-- USER_TAB_PRIVS_MADE : 해당 사용자가 만든 객체 권한 롤 정보 
-- USER_TAB_PRIVS_RECD : 사용자에게 부여한 객체 권한 정보
-- USER_COL_PRIVS_MADE : 해당 사용자가 만든 컬럼 객체 권한 롤 정보
-- USER_COL_PRIVS_RECD : 사용자에게 부여한 특정 컬럼 관련 객체 권한 롤 정보

/*
사용자 롤 정의 형식
	: 롤 생성은 반드시 DBA 권한이 있는 사용자만 생성할 수 있다.
	
CREATE ROLE 롤이름; -- 1. 롤 객체만들기	
GRANT 권한종류 TO 롤이름 -- 2. 생성된 롤 객체에 저장된 권한 추가.
GRANT 롤이름 TO 사용자명; -- 3. 사용자에게 롤 이용한 권한 부여하기
*/

<데이터베이스 ROLE - 권한 제어>
 : 사용자마다 일일이 권한을 부여하는 것은 번거로움
   오라클에서는 간편하게 권한을 부여할 수 있는 방법으로 ROLE 을 제공함.

 - 롤(ROLE)
	: 사용자에게 보다 간편하게 권한을 부여할 수 있도록 여러 개의
	권한을 묶어 놓은 것.
	=> 사용자 권한 관리를 보다 간편하고 효율적으로 할 수 있게함.

	* 다수의 사용자에게 공통적으로 필요한 권한들을 롤에 하나의
	그룹으로 묶어 두고, 사용자에게는 특정 롤에 대한 권한을 부여할 수
	있도록 함.

	* 사용자에게 부여한 권한을 수정하고자 할 때도 일일이 사용자마다
	권한 수정을 하지 않고 롤만 수정하면 그 롤에 대한 권한을 부여받은
	사용자들의 권한이 자동 수정됨.

	* 롤을 활성화하거나 비활성화하여 일시적으로 권한을 부여했다 철회
	했다 할 수도 있음.

 - 롤의 종류
	* 사전 정의된 ROLE 
	* 사용자가 정의한 ROLE

 - 사전 정의된 ROLE
	: 오라클 설치시 시스템에서 기본적으로 제공됨.
	- CONNECT ROLE
	 : 사용자가 데이터베이스에 접속할 수 있도록
	  시스템 권한 8가지를 묶어 놓았음.
	  CREATE SESSION, ALTER SESSION,
	  CREATE TABLE, CREATE VIEW,
	  CREATE SYNONYM, CREATE SEQUENCE,
	  CREATE CLUSTER, CREATE DATABASE LINK

	- RESOURCE ROLE
	 : 사용자가 객체를 생성할 수 있도록 하는 권한을 묶어 놓았음.
	  CREATE CLUSTER, CREATE PROCEDURE,
	  CREATE SEQUENCE, CREATE TABLE,
	  CREATE TRIGGER

	- DBA ROLE
	 : 사용자가 소유한 데이터베이스 객체를 관리하고
	  사용자 계정을 만들고 편집하고 제거할 수 있는 모든 권한을 가짐
	  시스템 권한을 부여하는 강력한 롤임.

 - 롤 부여하기
	: 새로운 사용자를 생성할 때 CONNECT 롤과 RESOURCE 롤을
	일반적으로 부여함.

	[실습] ---------------------------------------------------------------
	1. system 으로 로그인

	2. 새 사용자 생성함
	SQL> CREATE USER USER33
		IDENTIFIED BY PASS33;

	-- 로그인 시도 에러 확인
	SQL> conn USER33/PASS33 

	3. 권한 부여함
	SQL> GRANT CONNECT, RESOURCE TO USER33;

	4. 로그인해 봄.
	SQL> conn USER33/PASS33


 - 롤 관련 데이터 딕셔너리
	: 롤을 확인하기 위한 데이터 딕셔너리가 아주 많음.

	=> 사용자들에게 부여된 롤 확인해 보기
	-- system 계정에서 확인
	SQL> SELECT * FROM DICT
		WHERE TABLE_NAME LIKE '%ROLE%';

	=> 현재 사용자에게 부여된 롤 데이터 딕셔너리
		: USER_ROLE_PRIVS
	SQL> CONN USER33/PASS33
	SQL> SELECT * FROM USER_ROLE_PRIVS;

	* ROLE_SYS_PRIVS (롤에 부여된 시스템 권한 정보)
	* ROLE_TAB_PRIVS (롤에 부여된 테이블 관련 권한 정보)
	* USER_ROLE_PRIVS (접근 가능한 롤 정보)
	* USER_TAB_PRIVS_MADE (해당 사용자 소유의 객체 권한 정보)
	* USER_TAB_PRIVS_RECD (사용자에게 부여한 객체 권한 정보)
	* USER_COL_PRIVS_MADE (사용자 소유의 객체 중 컬럼 객체 권한 정보)
	* USER_COL_PRIVS_RECD (사용자에게 부여한 특정 컬럼에 대한 객체 권한 정보)

 - 사용자 롤 정의
	: CREATE ROLE 명령으로 롤을 생성함
	롤 생성은 반드시 DBA 권한이 있는 사용자만 할 수 있음

	[형식]
	CREATE ROLE 롤이름;	-- 1. 롤 생성
	GRANT 권한종류 TO 롤이름;	-- 2. 생성된 롤에 권한 추가
	GRANT 롤이름 TO 사용자이름;	-- 3. 사용자에게 롤 부여

	[실습 1] ------------------------------------------------------------------
	1. system 로그인하고, 롤 생성
	SQL> CONN system/암호
	SQL> CREATE ROLE MYROLE;

	2. 생성된 롤에 시스템 권한 부여해 보기
	SQL> GRANT CREATE SESSION, CREATE TABLE,
		CREATE VIEW TO MYROLE;

	3. 사용자 생성하고, 롤 부여해 봄
	SQL> CREATE USER MYMY
		IDENTIFIED BY PASS;
	SQL> GRANT MYROLE TO MYMY;

	4. 로그인해 봄
	SQL> CONN MYMY/PASS

	5. 현재 사용자에게 부여된 롤 확인해 봄
	SQL> SELECT * FROM USER_ROLE_PRIVS;
	----------------------------------------------------------------------------


	[연습] --------------------------------------------------------------------
	로그인 : system
	롤이름 : MYROLE02
	롤에 부여할 객체 권한 : STUDENT.EMPLOYEE 테이블에 대한 SELECT 
	롤 부여할 사용자 : MYMY
	=> MYMY 로그인해서 EMPLOYEE 테이블에 대한 SELECT 실행 확인
	----------------------------------------------------------------------------

- 롤 회수
	REVOKE ROLE 롤이름 FROM 사용자이름;

	[실습] -------------------------------------------------------------------
	1. 사용자 MYMY 로그인
	SQL> CONN MYMY/PASS

	2. 현재 사용자에게 부여된 롤 권한 확인
	SQL> SELECT * FROM USER_ROLL_PRIVS;

	3. system 으로 로그인하고, 롤 회수함
	SQL> CONN system/암호
	SQL> REVOKE MYROLE02 FROM MYMY;

	4. MYMY 로 다시 로그인해서 롤 삭제 확인함
	SQL> CONN MYMY/PASS
	SQL> SELECT * FROM USER_ROLL_PRIVS;

	5. system 계정에서 MYROLE02 제거함
	SQL> DROP ROLE MYROLE02;
	SQL> SELECT * FROM USER_ROLE_PRIVS;



- 롤 제거
	-- system 계정에서
	DROP ROLE 롤이름;
    
	