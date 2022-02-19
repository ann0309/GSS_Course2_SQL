--4.撈出每個分類借閱數量前三名書本及數量  
SELECT * FROM (
	SELECT 
		ROW_NUMBER() OVER (PARTITION BY bcl.BOOK_CLASS_NAME order BY  COUNT(bd.BOOK_ID) desc) AS seq,         --利用class name分群,依照book id數量(cnt)為他編上流水號(一群一組)
		bcl.BOOK_CLASS_NAME AS BookClass,
		bd.BOOK_ID AS BookId,
		bd.BOOK_NAME AS BookName,
		COUNT(bd.BOOK_ID) AS Cnt   --每一本書 的被借閱數
	FROM BOOK_DATA AS bd
	INNER JOIN BOOK_LEND_RECORD blr ON bd.BOOK_ID=blr.BOOK_ID
	INNER JOIN BOOK_CLASS bcl ON bd.BOOK_CLASS_ID=bcl.BOOK_CLASS_ID
	GROUP BY  bcl.BOOK_CLASS_NAME,bd.BOOK_ID,bd.BOOK_NAME,bcl.BOOK_CLASS_ID
)AS aaa
WHERE aaa.seq<=3   --取出seq流水號為1,2,3的資料







--SELECT * FROM BOOK_LEND_RECORD blr WHERE blr.BOOK_ID=411














--錯誤
SELECT ROW_NUMBER() OVER (PARTITION BY bcl.BOOK_CLASS_NAME order BY  COUNT(bd.BOOK_ID) desc) AS seq,
	   bcl.BOOK_CLASS_NAME AS 'book class',
	   bd.BOOK_ID,bd.BOOK_NAME,
	   bcl.BOOK_CLASS_ID, 
	   COUNT(bd.BOOK_ID) AS cnt
FROM BOOK_DATA bd
INNER JOIN
BOOK_LEND_RECORD blr
ON	bd.BOOK_ID=blr.BOOK_ID
INNER JOIN
BOOK_CLASS bcl
ON bd.BOOK_CLASS_ID=bcl.BOOK_CLASS_ID
--WHERE seq<=3
GROUP BY  bcl.BOOK_CLASS_NAME,bd.BOOK_ID,bd.BOOK_NAME,bcl.BOOK_CLASS_ID,bd.BOOK_CLASS_ID
--ORDER BY [book class],cnt DESC


