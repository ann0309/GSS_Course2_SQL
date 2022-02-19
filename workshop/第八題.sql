--8. 請查詢出李四(USER_ID =0002)的借書紀錄，其中包含書本ID、購書日期(yyyy/mm/dd)、借閱日期(yyyy/mm/dd)、書籍類別(id-name)、借閱人(id-cname(ename))、狀態(id-name)、購書金額												
SELECT bd.book_id AS  '書本ID',
	   CONVERT(VARCHAR,  bd.BOOK_BOUGHT_DATE, 111)  AS '購書日期',
	   CONVERT(varchar,  blr.LEND_DATE, 111)  AS '借閱日期',
	   bcl.BOOK_CLASS_NAME AS '書籍類別',
	   CONCAT(m.USER_ID,'-', m.USER_CNAME,'(',m.USER_ENAME,')') AS '借閱人',
	   CASE bd.BOOK_STATUS 
	   WHEN 'A' THEN 'A-可以借出'
	   WHEN 'B' THEN 'B-已借出'
	   WHEN 'C' THEN 'C-不可借出'
	   END AS '狀態',
	   CONCAT(FORMAT(bd.BOOK_AMOUNT , 'N0'),'元') AS '購書金額'   --三位一撇
FROM BOOK_CODE AS bco
INNER JOIN BOOK_DATA AS bd ON bco.CODE_ID=bd.BOOK_STATUS 
INNER JOIN BOOK_CLASS AS bcl ON bd.BOOK_CLASS_ID=bcl.BOOK_CLASS_ID
INNER JOIN BOOK_LEND_RECORD AS blr ON bd.BOOK_ID=blr.BOOK_ID
INNER JOIN MEMBER_M M ON m.USER_ID=blr.KEEPER_ID
WHERE m.USER_ID ='0002'