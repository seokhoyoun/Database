[DDL]

--------------------------------------------------------------------------
--1.  계열 정보를 저장한 카테고리 테이블을 만들려고 한다. 
-- 다음과 같은 테이블을 작성하시오.
--------------------------------------------------------------------------
CREATE TABLE TB_CATEGORY (
       NAME   VARCHAR2(10),
			 USE_YN CHAR(1) DEFAULT 'Y'
);

SELECT * FROM TB_CATEGORY;

--------------------------------------------------------------------------
--2. 과목 구분을 저장한 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오
--------------------------------------------------------------------------
CREATE TABLE TB_CLASS_TYPE (
       NO    VARCHAR2(5)  CONSTRAINTS PK1_NO PRIMARY KEY,
			 NAME  VARCHAR2(10)
);

SELECT * FROM TB_CLASS_TYPE;

--------------------------------------------------------------------------
--3.  TB_CATEGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
--(KEY 이름을 생성하지 않아도 무방함.
-- 만일 KEY 이를 지정하고자 한다면 이름은 본인이 알아서 적당한 이름을 사용한다.)
--------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
ADD ( CONSTRAINTS PK1_NAME PRIMARY KEY (NAME) );

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TB_CATEGORY';

--------------------------------------------------------------------------
--4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오
--------------------------------------------------------------------------
ALTER TABLE TB_CLASS_TYPE
MODIFY ( NAME NOT NULL );

--------------------------------------------------------------------------
--5.  두 테이블에서 컬럼 명이 NO 인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
-- NAME 인 것은 마찬가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.
--------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
MODIFY ( NAME VARCHAR2(20) );

ALTER TABLE TB_CLASS_TYPE
MODIFY ( NO VARCHAR2(10) )
MODIFY ( NAME VARCHAR2(20) );

--------------------------------------------------------------------------
--6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외핚 테이블 이름이 앞에 붙은 형태로 변경한다.
--(ex. CATEGORY_NAME)
--------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;


--------------------------------------------------------------------------
--7. TB_CATEGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 변경하시오.
-- Primary Key 의 이름은 "PK_ + 컬럼이름" 으로 지정하시오. (ex. PK_CATEGORY_NAME )
--------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
RENAME CONSTRAINTS PK1_NAME TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINTS PK1_NO TO PK_CLASS_TYPE_NAME;

--------------------------------------------------------------------------
--8. 다음과 같은 INSERT 문을 수행한다.
--------------------------------------------------------------------------
INSERT INTO TB_CATEGORY VALUES ('공학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('의학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('예체능', 'Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회', 'Y');
COMMIT;

SELECT* FROM TB_CATEGORY;

--------------------------------------------------------------------------
--9. TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모
--값으로 참조하도록 FOREIGN KEY 를 지정하시오. 이 때 KEY 이름은
--FK_테이블이름_컬럼이름으로 지정한다. (ex. FK_DEPARTMENT_CATEGORY )
--------------------------------------------------------------------------
ALTER TABLE TB_DEPARTMENT
MODIFY ( CONSTRAINTS FK_DEPARTMENT_CATEGORY CATEGORY 
                        REFERENCES TB_CATEGORY (CATEGORY_NAME));

--------------------------------------------------------------------------
--10.  춘 기술대학교 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW 를 만들고자 한다.
--아래 내용을 참고하여 적절한 SQL 문을 작성하시오.
--------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_학생일반정보
AS
SELECT STUDENT_NO AS "학번",
       STUDENT_NAME AS "학생이름",
			 STUDENT_ADDRESS AS "주소"
FROM  TB_STUDENT
;

SELECT * FROM VW_학생일반정보;

--------------------------------------------------------------------------
--11. 춘 기술대학교는 1 년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다.
--이를 위해 사용할 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 만드시오.
--이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 
--(단, 이 VIEW 는 단순 SELECT 만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)
--------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_지도면담
AS
SELECT STUDENT_NAME AS "학생이름",
       C.DEPARTMENT_NAME AS "학과이름",
			 PROFESSOR_NAME AS "지도교수이름"
FROM   TB_STUDENT A
LEFT JOIN   TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN   TB_DEPARTMENT C ON (A.DEPARTMENT_NO = C.DEPARTMENT_NO)
ORDER BY 2;

SELECT * FROM VW_지도면담;

--------------------------------------------------------------------------
--12. 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW 를 작성해 보자.
--------------------------------------------------------------------------
CREATE OR REPLACE VIEW VM_학과별학생수
AS
SELECT DEPARTMENT_NAME,
			 COUNT(*) AS STUDENT_COUNT
FROM   TB_STUDENT
JOIN   TB_DEPARTMENT USING (DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME;

SELECT * FROM VM_학과별학생수;

--------------------------------------------------------------------------
--13.
--------------------------------------------------------------------------
UPDATE VW_학생일반정보
SET 학생이름 = '서아람'
WHERE 학번 = 'A213046';

--SELECT * FROM VW_학생일반정보 WHERE 학번 = 'A213046';

--------------------------------------------------------------------------
--14.
--------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_학생일반정보
AS
SELECT STUDENT_NO AS "학번",
       STUDENT_NAME AS "학생이름",
			 STUDENT_ADDRESS AS "주소"
FROM   TB_STUDENT
WITH READ ONLY;

--SELECT * FROM VW_학생일반정보;

--------------------------------------------------------------------------
--15.
--------------------------------------------------------------------------
SELECT CLASS_NO,
       DEPARTMENT_NAME,
       CNT
FROM (
			SELECT CLASS_NO,
						 COUNT(*) AS CNT
			FROM   TB_GRADE
			WHERE  SUBSTR(TERM_NO, 1, 4) BETWEEN '2006' AND '2009'
			GROUP BY CLASS_NO
			ORDER BY 2 DESC
)
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE ROWNUM <= 3
ORDER BY 3 DESC, 1;


