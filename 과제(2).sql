SELECT DEPARTMENT_NAME "학과 명",
       CATEGORY "계열"
FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME || '의 정원은 '|| CAPACITY || '명 입니다.' AS "학과별 정원"
FROM TB_DEPARTMENT;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' AND STUDENT_SSN LIKE '_______2%' AND absence_yn = 'Y';

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME DESC;

SELECT DEPARTMENT_NAME, CATEGORY
FROM tb_department
WHERE capacity BETWEEN 20 AND 30;

SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

SELECT CLASS_NO
FROM TB_CLASS
WHERE preattending_class_no IS NOT NULL;

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY ASC;

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE (ENTRANCE_DATE BETWEEN '02/01/01' AND '02/12/31') 
AND (absence_yn = 'N' ) AND STUDENT_ADDRESS LIKE '전주%';

