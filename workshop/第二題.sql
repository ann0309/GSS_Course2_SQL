--2. 列出最受歡迎的書前五名(借閱數量最多前五名) 
--如果第五名和第六名數量相同，使用Top會把第六筆也取出來
SELECT TOP 5 WITH TIES BLR.BOOK_ID AS BOOKID, 
	   BD.BOOK_NAME AS BOOKNAME,
	   COUNT(BLR.LEND_DATE) AS QTY
FROM BOOK_LEND_RECORD AS BLR	
INNER JOIN
BOOK_DATA BD ON BLR.BOOK_ID = BD.BOOK_ID
GROUP BY BLR.BOOK_ID,BD.BOOK_NAME
ORDER BY QTY DESC                          --利用qty大到小排序後取出5筆

SELECT TOP 5 BLR.BOOK_ID AS BOOKID, 
	   BD.BOOK_NAME AS BOOKNAME,
	   COUNT(BLR.LEND_DATE) AS QTY
FROM BOOK_LEND_RECORD AS BLR	
INNER JOIN
BOOK_DATA BD ON BLR.BOOK_ID = BD.BOOK_ID
GROUP BY BLR.BOOK_ID,BD.BOOK_NAME
ORDER BY QTY DESC                          --利用qty大到小排序後取出5筆














/*錯誤
SELECT TOP 5  blr.BOOK_ID AS BookId, 
	   bd.BOOK_NAME AS BookName,
	   COUNT(blr.LEND_DATE) AS QTY
FROM BOOK_LEND_RECORD AS blr	
INNER JOIN
BOOK_DATA bd ON blr.BOOK_ID = bd.BOOK_ID
GROUP BY blr.BOOK_ID,bd.BOOK_NAME
ORDER BY QTY DESC                          --利用qty大到小排序後取出5筆*/


