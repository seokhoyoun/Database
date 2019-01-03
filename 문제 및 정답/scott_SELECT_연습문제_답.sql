-- SCOTT_SELECT_��������_��.sql


-- DEPT ���̺�� ���� ��� �����͸� ��ȸ
SELECT *
FROM DEPT;

-- EMP ���̺�� ���� ���(EMPNO), ����̸�(ENAME)�� ��ȸ
SELECT EMPNO, ENAME
FROM EMP;

-- EMP ���̺�� ���� �����, �޿�, ���� ��ȸ
SELECT ENAME, SAL, SAL * 12
FROM EMP;

-- EMP ���̺�� ���� �����, �޿�, ����, Ŀ�̼�, ����, Ŀ�̼��� ���Ե� ���� ��ȸ
SELECT ENAME, SAL, JOB, NVL(COMM, 0),
       SAL * 12, SAL * 12 + NVL(COMM, 0)
FROM EMP;       


-- emp ���̺� ���� �μ��ڵ� �� ��ȸ
select deptno
from emp;

-- emp ���̺� ���� �μ��ڵ� �� ��ȸ, �� �ߺ��� ���� �Ѱ��� ��µǰ� ��.
select distinct deptno
from emp;

-- emp ���̺��� ���� ���� ��ȸ
select job 
from emp;

-- emp ���̺� ���� ���� �����͸� �Ѱ����� ��ȸ
select distinct job
from emp;

-- WHERE �� 

-- �޿��� 3000 �̻��� �޴� ������ ���� ��ȸ
select *
from emp
where sal >= 3000;

-- �μ��ڵ尡 10�� ������ �̸�, ����, �޿� ��ȸ
select ename, job, sal
from emp
where deptno = 10;

-- �񱳰��� ����, ���ڿ�, ��¥ �������� ���� �ݵ�� '��' �� ǥ����.
-- ������ �̸��� 'ford'�� ������ ���� ��ȸ
select *
from emp
where ename = 'FORD';

-- �Ի����� 1980�� ���Ŀ� �Ի��� �������� ���� ��ȸ
SELECT *
FROM EMP
WHERE HIREDATE >= '81/01/01';

-- �μ��ڵ尡 10�̸鼭, ������ 'MANAGER'�� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO = 10 AND JOB = 'MANAGER';


-- �μ��ڵ尡 10 �̰ų�, ������ 'MANAGER'�� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO = 10 OR JOB = 'MANAGER';

-- ������ 'MANAGER'�� �ƴ� �������� ���� ��ȸ
SELECT *
FROM EMP
--WHERE JOB != 'MANAGER';
--WHERE JOB <> 'MANAGER';
--WHERE JOB ^= 'MANAGER';
WHERE NOT JOB = 'MANAGER';

-- �޿��� 2000 �̻� 3000 ������ �޿��� �޴� ������ ��ȸ
SELECT ENAME, SAL
FROM EMP
--WHERE SAL >= 2000 AND SAL <= 3000;
WHERE SAL BETWEEN 2000 AND 3000;


--2000 �̸� 3000 �ʰ��� ������ �޿��� �޴� ���� ��ȸ
SELECT ENAME, SAL
FROM EMP
--WHERE SAL < 2000 OR SAL > 3000;
--WHERE NOT (SAL >= 2000 AND SAL <= 3000);
WHERE NOT SAL BETWEEN 2000 AND 3000;


-- Ŀ�̼��� 300 �Ǵ� 500 �Ǵ� 1400�� ���� ��ȸ
SELECT *
FROM EMP
--WHERE COMM = 300 OR COMM = 500 OR COMM = 1400;
WHERE COMM IN (300, 500, 1400);


-- �����ȣ�� 7521 �Ǵ� 7654 �Ǵ� 7844�� ������� �޿� ��ȸ
SELECT EMPNO, SAL
FROM EMP
--WHERE EMPNO =7521 OR EMPNO = 7654 OR EMPNO = 7844;
WHERE EMPNO IN (7521, 7654, 7844);

-- ����� 7521, 7654, 7844 �� �ƴ� ���� ��ȸ
SELECT EMPNO, SAL
FROM EMP
--WHERE EMPNO <> 7521 AND EMPNO != 7654 AND EMPNO ^= 7844;
--WHERE EMPNO NOT IN (7521, 7654, 7844);
WHERE NOT EMPNO IN (7521, 7654, 7844);


-- 1980�� 1�� 1�� ���� ���� 1980�� 12�� 31�� ���̿� �Ի��� ���� ��ȸ
-- 1980�⵵�� �Ի��� ���� ��ȸ
SELECT *
FROM EMP
WHERE HIREDATE BETWEEN '1980/01/01' AND '1980/12/31';

-- 1980���� �ƴ� �ؿ� �Ի��� ���� ��ȸ
SELECT *
FROM EMP
WHERE HIREDATE NOT BETWEEN '1980/01/01' AND '1980/12/31';

-- ��� �̸��� 'F'�� �����ϴ� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE 'F%';

-- ��� �̸��� 'J'�� ����ȭ�� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE 'J%';

-- �̸��� 'A'�� ���Ե� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '%A%';

-- �̸��� ������ ���ڰ� 'N'���� ������ ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '%N';


-- �̸��� �ι�° ���ڰ� 'A'�� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '_A%';

-- �̸��� ����° ���ڰ� 'A'�� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '__A%';


-- ����� '_' ���� �� ���ڰ� �� ������ ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '__\_%' ESCAPE '\';

-- ����� ������ ���ڰ� '%P'�� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '%#%P' ESCAPE '#';

-- �̸��� 'A'�� ���� ���� ���� ��ȸ
SELECT *
FROM EMP
--WHERE ENAME NOT LIKE '%A%';
WHERE NOT ENAME LIKE '%A%';


