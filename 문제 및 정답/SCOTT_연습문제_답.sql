-- SCOTT �Լ� �������� 


-- COMM �� ���� NULL�� �ƴ� ���� ��ȸ
SELECT ENAME, JOB, COMM
FROM EMP
WHERE COMM IS NOT NULL;

-- Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
SELECT ENAME, JOB, COMM
FROM EMP
WHERE COMM IS NULL;

-- �����ڰ� ���� ���� ���� ��ȸ
SELECT * 
FROM EMP
WHERE MGR IS NULL;

-- �޿��� ���� �޴� ���� ������ ��ȸ
SELECT EMPNO, ENAME, JOB, COMM, SAL
FROM EMP
ORDER BY SAL DESC;

-- �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
SELECT EMPNO, ENAME, COMM, SAL
FROM EMP
ORDER BY 4 DESC, 3 DESC;

-- EMP ���̺��� �����ȣ, �����,����, �Ի��� ��ȸ
-- �� �Ի����� �������� ���� ó����.
SELECT EMPNO �����ȣ, ENAME �����, JOB ����, 
       HIREDATE �Ի���
FROM EMP
ORDER BY HIREDATE;       

-- EMP ���̺�� ���� �����ȣ, ����� ��ȸ
-- �����ȣ ���� �������� ����
SELECT EMPNO, ENAME
FROM EMP
ORDER BY 1 DESC;

-- ���, �Ի���, �����, �޿� ��ȸ
-- �μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��ϼ����� ó��
SELECT EMPNO, HIREDATE, ENAME, SAL
FROM EMP
ORDER BY DEPTNO, HIREDATE DESC;

/***** �Լ� *****/

-- �ý������� ���� ���� ��¥�� ���� ������ ����� �� ��
SELECT SYSDATE
FROM DUAL;   

-- EMP ���̺�� ���� ���, �����, �޿� ��ȸ
-- ��, �޿��� 100���� ������ ���� ��� ó����.
-- �޿� ���� �������� ������.
SELECT EMPNO ���, ENAME �����, ROUND(SAL, -2) �޿�
FROM EMP
ORDER BY SAL DESC;


-- EMP ���̺�� ���� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT EMPNO, ENAME
FROM EMP
WHERE MOD(EMPNO, 2) = 1;


/* ���� ó�� �Լ�*/  

-- EMP ���̺�� ���� �����, �Ի��� ��ȸ
-- ��, �Ի����� �⵵�� ���� �и� �����ؼ� ���
SELECT ENAME, 
       SUBSTR(HIREDATE, 1, 2) || '�� ' || 
       SUBSTR(HIREDATE, 4, 2) || '��' AS �Ի���
FROM EMP;

-- EMP ���̺�� ���� 9���� �Ի��� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE SUBSTR(HIREDATE, 4, 2) = '09';

-- EMP ���̺�� ���� '81'�⵵�� �Ի��� ���� ��ȸ
SELECT *
FROM EMP
WHERE SUBSTR(HIREDATE, 1, 2) = '81';

-- EMP ���̺�� ���� �̸��� 'E'�� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '%E';

-- SUBSTR( ) �Լ� ���
SELECT *
FROM EMP
WHERE SUBSTR(ENAME, -1, 1) = 'E';


-- emp ���̺�� ���� �̸��� ����° ���ڰ� 'R'�� ������ ���� ��ȸ
-- LIKE �����ڸ� ���
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

-- SUBSTR() �Լ� ���
SELECT *
FROM EMP
WHERE SUBSTR(ENAME, 3 , 1) = 'R';


/************ ��¥ ó�� �Լ� **************/

-- �Ի��Ϸ� ���� 40�� �Ǵ� ��¥ ��ȸ
SELECT ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 480) AS "40�� �Ǵ� ��"
FROM EMP;      

-- �Ի��Ϸ� ���� 33�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE ADD_MONTHS(HIREDATE, 396) < SYSDATE;


-- ���� ��¥���� �⵵�� ����
SELECT EXTRACT(YEAR FROM SYSDATE),
       EXTRACT(MONTH FROM SYSDATE),
       EXTRACT(DAY FROM SYSDATE) 
FROM DUAL;





   



