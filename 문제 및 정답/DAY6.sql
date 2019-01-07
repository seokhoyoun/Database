-- DAY 6

/*
����(JOIN)
: ���� ���� ���̺��� �ϳ��� ū ���̺�� ��ģ ����� ���� �� �����
����Ŭ ���뱸���� ��� DBMS�� �������� ����ϴ� ǥ�ر����� ANSI ǥ�ر���
*/

-- ����Ŭ ���뱸������ JOIN ó��
-- ��ĥ ���̺���� FROM ���� , �� ������
-- ���̺��� ��ġ�� ���� �÷����� WHERE ���� �����

SELECT *
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID;

-- ����Ŭ ���뱸�������� ���νÿ� ���̺�� ��Ī ����� �� ����.
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- �����, �μ��� ��ȸ
SELECT EMP_NAME, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;


-- ANSI ǥ�ر��� 
-- ���� ó���� ���� ������ ������ FROM���� �ۼ���
-- ��� DBMS �� �������� ����ϴ� ǥ�� ������.
SELECT *
FROM EMPLOYEE
INNER JOIN DEPARTMENT USING (DEPT_ID);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
INNER JOIN DEPARTMENT USING (DEPT_ID);
-- USING (�÷���) : �� ���̺��� �÷����� ���� ���

-- ON : �� ���̺��� ������ �÷����� �ٸ� ��, (���� ���� ����ϰ� ����)
SELECT *
FROM DEPARTMENT
INNER JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- ����Ŭ ���뱸������
SELECT *
FROM DEPARTMENT, LOCATION
WHERE LOC_ID = LOCATION_ID;

-- ���(EMP_ID), �����(EMP_NAME), ���޸�(JOB_TITLE) ��ȸ
-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID;

-- ANSI ǥ�ر���
SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE
INNER JOIN JOB USING (JOB_ID);

-- USING �� ���� ���� �÷��� ���� ����� ���� ����
SELECT *
FROM EMPLOYEE2
INNER JOIN DEPARTMENT USING (DEPT_ID, LOC_ID);
-- 2���� �÷����� �ϳ��� ������ ����, ���� ���� ã�Ƽ� ������
-- '10A1' = '10A1' : ���ε�
-- '90A1' <> '90A3' : ���ξȵ�

-- ������ �⺻�� EQUAL JOIN ��. (EQU-JOIN �̶�� ��)
-- ����Ǵ� �÷��� ���� ��ġ�ϴ� ��鸸 ������ ��.
-- ����Ŭ, ANSI �� �� �⺻ ������ EQUAL AND INNER ������.

-- OUTER JOIN ****************
-- EQUAL JOIN �̸鼭, �� ���̺��� ������ �÷��� ���� ��ġ���� �ʴ� �൵
-- ���ο� ���Խ�Ŵ.

-- ��� ������ ������ ������ ����� ���Եǰ� �Ϸ���
-- ����Ŭ ���뱸��
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+);

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE
--LEFT OUTER JOIN DEPARTMENT USING (DEPT_ID);
LEFT JOIN DEPARTMENT USING (DEPT_ID);


-- �μ����� ��� �� ���ο� ���Եǰ� �Ϸ���
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID;

SELECT *
FROM EMPLOYEE
--RIGHT OUTER JOIN DEPARTMENT USING (DEPT_ID);
RIGHT JOIN DEPARTMENT USING (DEPT_ID);


-- ���� ���� ��� �ٿ� �μ� ���� ��� �� ���ο� ���Եǰ� �Ϸ���.
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+);
-- ����Ŭ ���뱸�������� FULL OUTER JOIN ǥ���� �� ����

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE
--FULL OUTER JOIN DEPARTMENT USING (DEPT_ID);
FULL JOIN DEPARTMENT USING (DEPT_ID);


-- NATURAL [INNER] JOIN
-- ������ ���̺��� �⺻Ű(PRIMARY KEY)�� ������ �÷��� ����ؼ� ���ε�.
SELECT *
FROM EMPLOYEE
--NATURAL INNER JOIN DEPARTMENT;
NATURAL JOIN DEPARTMENT;
-- DEPARTMENT �� �⺻Ű �÷��� DEPT_ID �� ����ؼ� ���ε�


-- NON EQUAL JOIN ************
-- �����ϴ� �÷��� ���� ��ġ�ϴ� ����� �����ϴ� ��찡 �ƴ� ����.

-- CROSS JOIN
-- �� ���̺��� ������ �÷��� ���� ��쿡 �����.
SELECT *
FROM LOCATION, COUNTRY;

SELECT *
FROM LOCATION
CROSS JOIN COUNTRY;  -- 5�� * 5�� => 25��

-- NON-EQU JOIN
-- �����ϴ� ���̺��� �÷����� ������ �ؼ� ������ ���� ����
SELECT *
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN
-- ���� ���̺��� �� �� �����ϴ� ���
-- ���� ���̺� ���� �ٸ� �÷��� �ܺ� ����Ű(F)�� ����ϰ� �ִ� ��쿡 �������� ������
SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

SELECT *
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- ���� �̸��� �� ������ ������ �̸� ��ȸ
SELECT E.EMP_NAME �����̸�, M.EMP_NAME �������̸� 
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

-- N���� ���̺� ����
-- ���̺��� ����(RELATIONSHIP)�� ����ؼ� ������ ���ؾ� ��
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID);



--JOIN ��������
--
--1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('2020/12/25', 'RRRR/MM/DD'), 'DAY')
FROM DUAL;
 
--2. �ֹι�ȣ�� 60��� ���̸鼭 ������ �����̰�, ���� �达�� �������� 
--�����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_ID = D.DEPT_ID
AND E.JOB_ID = J.JOB_ID
AND EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '��%';

-- ANSI ǥ�ر���
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '��%';

--3. ���� ���̰� ���� ������ ���, �����, ����, �μ���, ���޸��� ��ȸ�Ͻÿ�.

-- ������ �ּҰ� ��ȸ
SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) ����
FROM EMPLOYEE;

-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) ����, 
        DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) = 30;

-- ANSI ǥ�ر���
SELECT EMP_ID, EMP_NAME, 
        MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) ����, 
        DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12)) = 30;


--4. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID 
AND EMP_NAME LIKE '%��%';

-- ANSI ǥ�ر���
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NAME LIKE '%��%';

--5. �ؿܿ������� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, JOB_TITLE, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND DEPT_NAME LIKE '�ؿܿ���%'
ORDER BY 4;

-- ANSI ǥ�ر���
SELECT EMP_NAME, JOB_TITLE, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME LIKE '�ؿܿ���%'
ORDER BY 4;

--6. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND BONUS_PCT IS NOT NULL
AND BONUS_PCT <> 0.0;

-- ANSI ǥ�ر���
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL
AND BONUS_PCT <> 0.0;

--7. �μ��ڵ尡 20�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��


-- ANSI ǥ�ر���


--8. ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
--�����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
--������ ���ʽ�����Ʈ�� �����Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, JOB_TITLE, SALARY, 
        (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 ����
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID 
AND (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 > MIN_SAL;

-- ANSI ǥ�ر���
SELECT EMP_NAME, JOB_TITLE, SALARY, 
        (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 ����
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 > MIN_SAL;

--9. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
--�����(emp_name), �μ���(dept_name), ������(loc_describe), ������(country_name)�� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID
AND L.COUNTRY_ID IN ('KO', 'JP');

-- ANSI ǥ�ر���
SELECT EMP_NAME, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID)
WHERE COUNTRY_ID IN ('KO', 'JP');

--10. ���� �μ��� �ٹ��ϴ� �������� �����, �μ��ڵ�, �����̸��� ��ȸ�Ͻÿ�.
--self join ���

-- ����Ŭ ���뱸��
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�,
        C.EMP_NAME �����̸�, C.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E, EMPLOYEE C
WHERE E.EMP_NAME <> C.EMP_NAME
AND E.DEPT_ID = C.DEPT_ID
ORDER BY E.EMP_NAME;

-- ANSI ǥ�ر���
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�,
        C.EMP_NAME �����̸�, C.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E
JOIN EMPLOYEE C ON (E.DEPT_ID = C.DEPT_ID)
WHERE E.EMP_NAME <> C.EMP_NAME
ORDER BY E.EMP_NAME;

--11. ���ʽ�����Ʈ�� ���� ������ �߿��� �����ڵ尡 J4�� J7�� �������� 
-- �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
--��, join�� IN ����� ��

-- ����Ŭ ���뱸��
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID 
AND E.JOB_ID IN ('J4', 'J7')
AND BONUS_PCT IS NULL;

-- ANSI ǥ�ر���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID IN ('J4', 'J7')
AND BONUS_PCT IS NULL;


--12. ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ') ��ȥ����,
        COUNT(*) ������
FROM EMPLOYEE
GROUP BY DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ')
ORDER BY 1;












