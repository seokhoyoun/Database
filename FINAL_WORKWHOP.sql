-- FINAL WORKSHOP

--1. 4개 테이블에 포함된 데이터 건 수를 구하는 SQL 구문을 만드는 SQL 구문을 작성하시오.


SELECT (
(SELECT count(*)  FROM TB_BOOK) +  
(SELECT count(*)  FROM TB_BOOK_AUTHOR) +  
(SELECT count(*)  FROM TB_PUBLISHER) +  
(SELECT count(*)  FROM TB_WRITER) ) "전체 데이터 수" FROM DUAL; 

SELECT 'SELECT (' FROM DUAL UNION ALL
SELECT '(SELECT count(*)  FROM '||TABLE_NAME||') +  '  FROM USER_TABLES UNION ALL
SELECT ') TOTAL_COUNT FROM DUAL; ' FROM DUAL;

-- 2. 4개 테이블의 구조를 파악하려고 한다. 제시된 결과처럼 TABLE_NAME, COLUMN_NAME, DATA_TYPE,
--DATA_DEFAULT, NULLABLE, CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME 값을
--조회하는 SQL 구문을 작성하시오.
SELECT  C.TABLE_NAME,
        C.COLUMN_NAME,
        C.DATA_TYPE,
        C.DATA_DEFAULT,
        C.NULLABLE,
        UC.CONSTRAINT_NAME,
        UC.CONSTRAINT_TYPE,
        UC.R_CONSTRAINT_NAME
FROM COLS C
JOIN USER_CONSTRAINTS UC ON (C.TABLE_NAME = UC.TABLE_NAME)
ORDER BY 1,2;

SELECT * FROM USER_TABLES
WHERE TABLE_NAME LIKE 'TB%';

DESC USER_CONSTRAINTS;
--3. 도서명이 25자 이상인 책 번호와 도서명을 화면에 출력하는 SQL 문을 작성하시오.
SELECT  BOOK_NO, BOOK_NM
FROM    TB_BOOK
WHERE   LENGTH(BOOK_NM) >= 25;

--4. 휴대폰 번호가 ‘019’로 시작하는 김씨 성을 가진 작가를 이름순으로 정렬했을 때 가장 먼저 표시되는 작가
--이름과 사무실 전화번호, 집 전화번호, 휴대폰 전화번호를 표시하는 SQL 구문을 작성하시오.
SELECT *
FROM (
    SELECT  WRITER_NM 이름,
            OFFICE_TELNO 사무실,
            HOME_TELNO 집,
            MOBILE_NO 휴대폰
    FROM    TB_WRITER
    WHERE   MOBILE_NO LIKE '019%'
    AND     WRITER_NM LIKE '김%'
    )
WHERE ROWNUM = 1;
--5. 저작 형태가 “옮김”에 해당하는 작가들이 총 몇 명인지 계산하는 SQL 구문을 작성하시오. (결과 헤더는
--“작가(명)”으로 표시되도록 할 것)
SELECT  COUNT(WRITER_NO) "작가(명)"
FROM    TB_BOOK_AUTHOR 
WHERE   COMPOSE_TYPE = '옮김';

--6. 300권 이상 등록된 도서의 저작 형태 및 등록된 도서 수량을 표시하는 SQL 구문을 작성하시오.(저작
--형태가 등록되지 않은 경우는 제외할 것)

SELECT  COMPOSE_TYPE "저작 형태",
        COUNT(BOOK_NO)||'권' "도서 수량"
FROM    TB_BOOK_AUTHOR
WHERE   COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING  COUNT(BOOK_NO) >= 300;

--7. 가장 최근에 발간된 최신작 이름과 발행일자, 출판사 이름을 표시하는 SQL 구문을 작성하시오.
SELECT * FROM (
    SELECT  BOOK_NM,
            ISSUE_DATE,
            PUBLISHER_NM
    FROM    TB_BOOK
    ORDER BY 2 DESC
                )
WHERE ROWNUM = 1;

--8. 가장 많은 책을 쓴 작가 3명의 이름과 수량을 표시하되, 많이 쓴 순서대로 표시하는 SQL 구문을 작성하시오.
--단, 동명이인(同名異人) 작가는 없다고 가정한다. (결과 헤더는 “작가 이름”, “권 수”로 표시되도록 할
--것)
SELECT
    *
FROM    (
    SELECT  WRITER_NM "작가 이름",
            COUNT(BA.WRITER_NO) "권 수"
    FROM    TB_WRITER W
    JOIN    TB_BOOK_AUTHOR BA ON ( W.WRITER_NO = BA.WRITER_NO )
    GROUP BY WRITER_NM
    ORDER BY 2 DESC
        )
WHERE ROWNUM <= 3;

--9. 작가 정보 테이블의 모든 등록일자 항목이 누락되어 있는 걸 발견하였다. 누락된 등록일자 값을 각 작가의
--‘최초 출판도서의 발행일과 동일한 날짜’로 변경시키는 SQL 구문을 작성하시오. (COMMIT 처리할 것)

CREATE VIEW VW_DATE
AS
SELECT	WRITER_NO "WRITER_NO",
		MIN(ISSUE_DATE) "REGIST_DATE"
FROM		TB_BOOK_AUTHOR
JOIN		TB_BOOK USING (BOOK_NO)
GROUP BY WRITER_NO
ORDER BY TO_NUMBER(WRITER_NO);

UPDATE	TB_WRITER W
SET	REGIST_DATE = (
				SELECT	REGIST_DATE
				FROM		VW_DATE V
				WHERE	W.WRITER_NO = V.WRITER_NO
				);
SELECT	* FROM TB_WRITER;
COMMIT;									
--10. 현재 도서저자 정보 테이블은 저서와 번역서를 구분 없이 관리하고 있다. 앞으로는 번역서는 따로 관리하려
--고 한다. 제시된 내용에 맞게 “TB_BOOK_ TRANSLATOR” 테이블을 생성하는 SQL 구문을 작성하시오.
--(Primary Key 제약 조건 이름은 “PK_BOOK_TRANSLATOR”로 하고, Reference 제약 조건 이름은
--“FK_BOOK_TRANSLATOR_01”, “FK_BOOK_TRANSLATOR_02”로 할 것) 그림참조!

CREATE TABLE TB_BOOK_TRANSLATOR 
(
BOOK_NO	VARCHAR2(10) NOT NULL,
WRITER_NO	VARCHAR2(10) NOT NULL,
TRANS_LANG VARCHAR2(60)
);

DESC TB_BOOK_TRANSLATOR;

ALTER TABLE TB_BOOK_TRANSLATOR
ADD CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY (BOOK_NO, WRITER_NO);

ALTER TABLE TB_BOOK_TRANSLATOR
ADD CONSTRAINT FK_BOOK_TRANSLATOR_01 FOREIGN KEY (BOOK_NO) REFERENCES TB_BOOK(BOOK_NO);
ALTER TABLE TB_BOOK_TRANSLATOR
ADD CONSTRAINT FK_BOOK_TRANSLATOR_02 FOREIGN KEY (WRITER_NO) REFERENCES TB_WRITER(WRITER_NO);

SELECT * FROM TB_BOOK_TRANSLATOR;

--INSERT INTO TB_BOOK_TRANSLATOR (BOOK_NO, WRITER_NO)
--(
--	SELECT	BA.BOOK_NO,
--			W.WRITER_NO
--	FROM		TB_WRITER W
--	JOIN		TB_BOOK_AUTHOR BA ON (W.WRITER_NO = BA.WRITER_NO)
--	
--);
--ROLLBACK;

--11. 도서 저작 형태(compose_type)가 '옮김', '역주', '편역', '공역'에 해당하는 데이터는
--도서 저자 정보 테이블에서 도서 역자 정보 테이블(TB_BOOK_ TRANSLATOR)로 옮기는 SQL
--구문을 작성하시오. 단, “TRANS_LANG” 컬럼은 NULL 상태로 두도록 한다. (이동된 데이터는 더
--이상 TB_BOOK_AUTHOR 테이블에 남아 있지 않도록 삭제할 것)

INSERT INTO TB_BOOK_TRANSLATOR(BOOK_NO, WRITER_NO)
(
SELECT BOOK_NO, WRITER_NO
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('옮김','역주','편역','공역')
);
SELECT * FROM TB_BOOK_TRANSLATOR;
ROLLBACK;
DELETE TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('옮김','역주','편역','공역');
SELECT * FROM TB_BOOK_AUTHOR;
--12. 2007년도에 출판된 번역서 이름과 번역자(역자)를 표시하는 SQL 구문을 작성하시오.
SELECT	BOOK_NM,
		WRITER_NM
FROM		TB_BOOK_TRANSLATOR T
JOIN		TB_BOOK B ON ( T.BOOK_NO = B.BOOK_NO )
JOIN		TB_WRITER W ON ( T.WRITER_NO = W.WRITER_NO )
WHERE	B.ISSUE_DATE BETWEEN '2007/01/01' AND '2007/12/30';
--13. 12번 결과를 활용하여 대상 번역서들의 출판일을 변경할 수 없도록 하는 뷰를 생성하는 SQL
--구문을 작성하시오. (뷰 이름은 “VW_BOOK_TRANSLATOR”로 하고 도서명, 번역자, 출판일이
--표시되도록 할 것)
CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR
AS
SELECT	BOOK_NM 도서명,
		WRITER_NM 번역자,
		ISSUE_DATE 출판일
FROM		TB_BOOK_TRANSLATOR T
JOIN		TB_BOOK B ON ( T.BOOK_NO = B.BOOK_NO )
JOIN		TB_WRITER W ON ( T.WRITER_NO = W.WRITER_NO )
WITH READ ONLY;

SELECT * FROM VW_BOOK_TRANSLATOR;
--14. 새로운 출판사(춘 출판사)와 거래 계약을 맺게 되었다. 제시된 다음 정보를 입력하는 SQL
--구문을 작성하시오.(COMMIT 처리할 것) 그림참조!
INSERT INTO TB_PUBLISHER
VALUES ('춘 출판사','02-6710-3737',DEFAULT);

SELECT * FROM TB_PUBLISHER;
--15. 동명이인(同名異人) 작가의 이름을 찾으려고 한다. 이름과 동명이인 숫자를 표시하는 SQL 구문을
--작성하시오.
SELECT	WRITER_NM, COUNT(WRITER_NO)
FROM		TB_WRITER
GROUP BY WRITER_NM
HAVING	COUNT(WRITER_NO) >= 2;
--16. 도서의 저자 정보 중 저작 형태(compose_type)가 누락된 데이터들이 적지 않게 존재한다. 해당 컬럼이
--NULL인 경우 '지음'으로 변경하는 SQL 구문을 작성하시오.(COMMIT 처리할 것)
SELECT *
FROM COLS
WHERE TABLE_NAME = 'TB_BOOK_AUTHOR';

UPDATE TB_BOOK_AUTHOR
SET	COMPOSE_TYPE = '지음'
WHERE	COMPOSE_TYPE IS NULL;

SELECT * FROM TB_BOOK_AUTHOR;
COMMIT;

--17. 서울지역 작가 모임을 개최하려고 한다. 사무실이 서울이고, 사무실 전화 번호 국번이 3자리인 작가의
--이름과 사무실 전화 번호를 표시하는 SQL 구문을 작성하시오.

SELECT	WRITER_NM,OFFICE_TELNO
FROM		TB_WRITER
WHERE	OFFICE_TELNO LIKE '02%'
AND		OFFICE_TELNO LIKE '__-___-%';

--18. 2006년 1월 기준으로 등록된 지 31년 이상 된 작가 이름을 이름순으로 표시하는 SQL 구문을 작성하시오.

SELECT	WRITER_NM, MONTHS_BETWEEN( '2006/01/01', REGIST_DATE)/12
FROM		TB_WRITER
WHERE	MONTHS_BETWEEN('2006/01/01', REGIST_DATE)/12 >= 31
ORDER BY	1;

--19. 요즘 들어 다시금 인기를 얻고 있는 '황금가지' 출판사를 위한 기획전을 열려고 한다. '황금가지'
--출판사에서 발행한 도서 중 재고 수량이 10권 미만인 도서명과 가격, 재고상태를 표시하는 SQL 구문을
--작성하시오. 재고 수량이 5권 미만인 도서는 ‘추가주문필요’로, 나머지는 ‘소량보유’로 표시하고,
--재고수량이 많은 순, 도서명 순으로 표시되도록 한다.

SELECT BOOK_NM 도서명, PRICE 가격,
		CASE 
		WHEN STOCK_QTY < 5 THEN '추가주문필요'
		ELSE '소량보유'
		END AS 재고상태
FROM	 TB_BOOK
WHERE PUBLISHER_NM = '황금가지'
AND	STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, 1;

--20. '아타트롤' 도서 작가와 역자를 표시하는 SQL 구문을 작성하시오. (결과 헤더는
--‘도서명’,’저자’,’역자’로 표시할 것)

SELECT 	BOOK_NM,
		WRITER_NM
FROM		TB_BOOK_AUTHOR
JOIN		TB_BOOK USING (BOOK_NO)
JOIN		TB_WRITER USING (WRITER_NO)
WHERE	BOOK_NM = '아타트롤';

--21. 현재 기준으로 최초 발행일로부터 만 30년이 경과되고, 재고 수량이 90권 이상인 도서에 대해 도서명, 재고
--수량, 원래 가격, 20% 인하 가격을 표시하는 SQL 구문을 작성하시오. (결과 헤더는 “도서명”, “재고
--수량”, “가격(Org)”, “가격(New)”로 표시할 것. 재고 수량이 많은 순, 할인 가격이 높은 순, 도서명
--순으로 표시되도록 할 것)
