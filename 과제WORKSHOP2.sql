--WORKSHOP2

--1
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE ASC;

--2
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

--3
SELECT PROFESSOR_NAME 교수이름
FROM TB_PROFESSOR
WHERE professor_ssn LIKE '_______1%'
ORDER BY SUBSTR(PROFESSOR_SSN,1,2) DESC, professor_name ASC;

--4
SELECT SUBSTR(PROFESSOR_NAME, 2) 이름
FROM TB_PROFESSOR;

--5
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE ADD_MONTHS(TO_DATE(1900+SUBSTR(STUDENT_SSN,1,2),'YYYY'),240) < ENTRANCE_DATE
ORDER BY STUDENT_NO ASC;

--5
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE ADD_MONTHS(TO_DATE(SUBSTR(STUDENT_SSN,1,2),'RR'),240) < ENTRANCE_DATE;

--6
SELECT TO_CHAR(TO_DATE('2020-12-25','YYYY-MM-DD'),'DAY')
FROM DUAL;

--7
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYY/MM/DD'),
       TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYY/MM/DD'),
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'),'YYYY/MM/DD'),
       TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'),'YYYY/MM/DD')
FROM DUAL;

--8
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT STUDENT_NO LIKE 'A%'
ORDER BY STUDENT_NO;

--9
SELECT ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10
SELECT DISTINCT DEPARTMENT_NO 학과번호, COUNT(DEPARTMENT_NO) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

--11
SELECT COUNT(*)
FROM TB_STUDENT
WHERE coach_professor_no IS NULL;

--12
SELECT SUBSTR(TERM_NO,1,4) 연도,ROUND(AVG(POINT),1) "연도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 연도;

--13
SELECT DEPARTMENT_NO 학과코드명, COUNT(DEPARTMENT_NO) "휴학생 수"
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

--13
SELECT DISTINCT DEPARTMENT_NO 학과코드, SUM(CASE ABSENCE_YN
                                                                             WHEN 'Y' THEN 1
                                                                             WHEN 'N' THEN 0
                                                                             END) 인원수
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;


--14
SELECT STUDENT_NAME 동일이름, COUNT(STUDENT_NAME) "동명인 수" 
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NAME) > 1
ORDER BY STUDENT_NAME;

--15 
SELECT  NVL(SUBSTR(TERM_NO,1,4),' ') 연도, NVL(SUBSTR(TERM_NO,5,2),' ') 학기, ROUND(AVG(POINT),1) 평점
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2)) ;               






































