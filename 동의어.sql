-- 동의어 (SYNONYM)
/*
데이터 베이스에서 다른 사용자가 가진 객체에 대한 줄임말
여러 사용자가 테이블을 공유 할 경우, 다른 사용자가 테이블에 접근할 때
사용자명 테이블명으로 표현한다.
이때 동의어를 사용하면 간단하게 기술할 수 있게 된다.

동의어 생성 방법

CREATE SYNONYM 줄임말 FOR 사용자이름.객체명
*/

-- 예) 테이블명 줄임말 만들기
CREATE SYNONYM EP FOR EMPLOYEE;

SELECT * FROM EMPLOYEE;
SELECT * FROM EP;

-- 예
SELECT * FROM SCOTT.EMP;

CREATE SYNONYM SE FOR SCOTT.EMP;

SELECT * FROM SE;

-- 예
SELECT * FROM SYS.DUAL;

CREATE SYNONYM D FOR SYS.DUAL;

SELECT * FROM D;

SELECT 25+3
FROM D;

-- 동의어는 모든 사용자를 대상으로 하는 공개(PUBLIC) 동의어
-- 개별 사용자를 대상으로 하는 비공개 동의어
-- 공개 동의어는 반드시 SYSTEM 관리자 계정에서 생성해야 함.
/*
생성 형식
CREATE PUBLIC SYNONYM 줄임말 (동의어 이름)
FOR 사용자이름.객체명
*/

-- 동의어 삭제
-- DROP SYNONYM 동의어이름(줄임말);
DROP SYNONYM D;
-- 공개동의어 삭제일 경우 관리자 계정에서
-- DROP PUBLIC SYNONYM 동의어이름
