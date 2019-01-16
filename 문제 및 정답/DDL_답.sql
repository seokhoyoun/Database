[DDL]

--------------------------------------------------------------------------
--1.  �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. 
-- ������ ���� ���̺��� �ۼ��Ͻÿ�.
--------------------------------------------------------------------------
CREATE TABLE TB_CATEGORY (
       NAME   VARCHAR2(10),
			 USE_YN CHAR(1) DEFAULT 'Y'
);

SELECT * FROM TB_CATEGORY;

--------------------------------------------------------------------------
--2. ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�
--------------------------------------------------------------------------
CREATE TABLE TB_CLASS_TYPE (
       NO    VARCHAR2(5)  CONSTRAINTS PK1_NO PRIMARY KEY,
			 NAME  VARCHAR2(10)
);

SELECT * FROM TB_CLASS_TYPE;

--------------------------------------------------------------------------
--3.  TB_CATEGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
--(KEY �̸��� �������� �ʾƵ� ������.
-- ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸��� ������ �˾Ƽ� ������ �̸��� ����Ѵ�.)
--------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
ADD ( CONSTRAINTS PK1_NAME PRIMARY KEY (NAME) );

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TB_CATEGORY';

--------------------------------------------------------------------------
--4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�
--------------------------------------------------------------------------
ALTER TABLE TB_CLASS_TYPE
MODIFY ( NAME NOT NULL );

--------------------------------------------------------------------------
--5.  �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
-- NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
--------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
MODIFY ( NAME VARCHAR2(20) );

ALTER TABLE TB_CLASS_TYPE
MODIFY ( NO VARCHAR2(10) )
MODIFY ( NAME VARCHAR2(20) );

--------------------------------------------------------------------------
--6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ� ���� ���·� �����Ѵ�.
--(ex. CATEGORY_NAME)
--------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;


--------------------------------------------------------------------------
--7. TB_CATEGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
-- Primary Key �� �̸��� "PK_ + �÷��̸�" ���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
--------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
RENAME CONSTRAINTS PK1_NAME TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINTS PK1_NO TO PK_CLASS_TYPE_NAME;

--------------------------------------------------------------------------
--8. ������ ���� INSERT ���� �����Ѵ�.
--------------------------------------------------------------------------
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��', 'Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ', 'Y');
COMMIT;

SELECT* FROM TB_CATEGORY;

--------------------------------------------------------------------------
--9. TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ�
--������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸���
--FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )
--------------------------------------------------------------------------
ALTER TABLE TB_DEPARTMENT
MODIFY ( CONSTRAINTS FK_DEPARTMENT_CATEGORY CATEGORY 
                        REFERENCES TB_CATEGORY (CATEGORY_NAME));

--------------------------------------------------------------------------
--10.  �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� �Ѵ�.
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
--------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS
SELECT STUDENT_NO AS "�й�",
       STUDENT_NAME AS "�л��̸�",
			 STUDENT_ADDRESS AS "�ּ�"
FROM  TB_STUDENT
;

SELECT * FROM VW_�л��Ϲ�����;

--------------------------------------------------------------------------
--11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�.
--�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
--�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� 
--(��, �� VIEW �� �ܼ� SELECT ���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
--------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_�������
AS
SELECT STUDENT_NAME AS "�л��̸�",
       C.DEPARTMENT_NAME AS "�а��̸�",
			 PROFESSOR_NAME AS "���������̸�"
FROM   TB_STUDENT A
LEFT JOIN   TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN   TB_DEPARTMENT C ON (A.DEPARTMENT_NO = C.DEPARTMENT_NO)
ORDER BY 2;

SELECT * FROM VW_�������;

--------------------------------------------------------------------------
--12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
--------------------------------------------------------------------------
CREATE OR REPLACE VIEW VM_�а����л���
AS
SELECT DEPARTMENT_NAME,
			 COUNT(*) AS STUDENT_COUNT
FROM   TB_STUDENT
JOIN   TB_DEPARTMENT USING (DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME;

SELECT * FROM VM_�а����л���;

--------------------------------------------------------------------------
--13.
--------------------------------------------------------------------------
UPDATE VW_�л��Ϲ�����
SET �л��̸� = '���ƶ�'
WHERE �й� = 'A213046';

--SELECT * FROM VW_�л��Ϲ����� WHERE �й� = 'A213046';

--------------------------------------------------------------------------
--14.
--------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS
SELECT STUDENT_NO AS "�й�",
       STUDENT_NAME AS "�л��̸�",
			 STUDENT_ADDRESS AS "�ּ�"
FROM   TB_STUDENT
WITH READ ONLY;

--SELECT * FROM VW_�л��Ϲ�����;

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


