--1.
SELECT STUDENT_NO AS 학번,
       STUDENT_NAME AS 이름,
			 TO_CHAR(ENTRANCE_DATE, 'RRRR-MM-DD') AS 입학년도
FROM   TB_STUDENT
WHERE  DEPARTMENT_NO='002'
ORDER BY ENTRANCE_DATE;

--2.
SELECT PROFESSOR_NAME , 
       PROFESSOR_SSN
FROM   TB_PROFESSOR
WHERE  PROFESSOR_NAME NOT LIKE '___';

--3.
SELECT PROFESSOR_NAME AS 교수이름,
       TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER('19' || SUBSTR(PROFESSOR_SSN, 1, 2)) AS 나이
FROM   TB_PROFESSOR
WHERE  SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 2, 1;

--4.
SELECT SUBSTR(PROFESSOR_NAME, 2) AS 이름
FROM   TB_PROFESSOR;

--5.
SELECT  STUDENT_NO,
        STUDENT_NAME
FROM    TB_STUDENT
WHERE   TO_NUMBER(TO_CHAR(ENTRANCE_DATE, 'YYYY'))  - TO_NUMBER(TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 2), 'RR'), 'YYYY')) > 19
ORDER BY 1;



--6.
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'YYYYMMDD DAY') FROM DUAL;

--7.

SELECT TO_DATE('99/10/11', 'YY/MM/DD') FROM DUAL;
SELECT TO_DATE('49/10/11', 'YY/MM/DD') FROM DUAL;
SELECT TO_DATE('99/10/11', 'RR/MM/DD') FROM DUAL;
SELECT TO_DATE('49/10/11', 'RR/MM/DD') FROM DUAL;
/*
TO_DATE('99/10/11', 'YY/MM/DD') : 2099년 10월 11일
TO_DATE('49/10/11', 'YY/MM/DD') : 2049년 10월 11일
TO_DATE('99/10/11', 'RR/MM/DD') : 1999년 10월 11일
TO_DATE('49/10/11', 'RR/MM/DD') : 2049년 10월 11일
*/

--8.
SELECT STUDENT_NO,
       STUDENT_NAME
FROM   TB_STUDENT
WHERE  SUBSTR(STUDENT_NO, 1, 1) <> 'A'
ORDER BY 1
;

--9. 
SELECT ROUND(AVG(POINT), 1) AS 평점 
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A517178';

--10.
SELECT DEPARTMENT_NO AS 학과번호,
       COUNT(*) AS "학생수(명)"
FROM   TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11.
SELECT COUNT(*)
FROM   TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12.

SELECT SUBSTR(TERM_NO, 1 ,4) AS 년도,
       ROUND(AVG(POINT), 1) AS "년도 별 평점" 
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4);

--13.
SELECT DEPARTMENT_NO AS 학과코드명,
       SUM(CASE WHEN ABSENCE_YN ='Y' THEN 1 
			     ELSE 0 END) AS "휴학생 수"
FROM   TB_STUDENT
GROUP BY DEPARTMENT_NO
--ORDER BY 1
;

--14.
SELECT STUDENT_NAME AS 동일이름,
       COUNT(*)     AS "동명인 수"
FROM   TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

--15.
SELECT SUBSTR(TERM_NO, 1, 4) AS 년도,
       SUBSTR(TERM_NO, 5, 2) AS 학기,
			 ROUND(AVG(POINT), 1) AS 평점
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2));


