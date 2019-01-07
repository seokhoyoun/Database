--WORKSHOP4

-- 16
SELECT      CLASS_NO,
                CLASS_NAME,
                AVG(POINT)
FROM        TB_CLASS A
JOIN          TB_GRADE USING (CLASS_NO)
RIGHT JOIN  TB_DEPARTMENT D ON (A.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE       D.DEPARTMENT_NAME = '환경조경학과'  AND A.CLASS_TYPE LIKE '전공%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

--17
SELECT  STUDENT_NAME, STUDENT_ADDRESS            
FROM    TB_STUDENT
JOIN    TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE   DEPARTMENT_NAME IN (SELECT DEPARTMENT_NAME
                                                FROM TB_STUDENT
                                                JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                                                WHERE STUDENT_NAME = '최경희'    );
                                                
--18
SELECT  
FROM    

