--6. 請使用 PIVOT 語法列出2016, 2017, 2018, 2019 各書籍類別的借閱數量比較
--先產生bookclass id, class name,year圖表, 再用pivot

;WITH source as(                               --來源資料表
SELECT bc.BOOK_CLASS_ID,
	   bc.BOOK_CLASS_NAME ,
	   YEAR(blr.LEND_DATE) AS lend_year,
	   COUNT(blr.LEND_DATE) AS qty
FROM BOOK_LEND_RECORD AS blr 
INNER JOIN BOOK_DATA AS bd ON blr.BOOK_ID = bd.BOOK_ID
INNER JOIN BOOK_CLASS AS bc ON bd.BOOK_CLASS_ID = bc.BOOK_CLASS_ID
GROUP BY  bc.BOOK_CLASS_ID,bc.BOOK_CLASS_NAME ,YEAR(blr.LEND_DATE) 
)
SELECT BOOK_CLASS_ID AS ClassId,BOOK_CLASS_NAME AS ClassName,
	ISNULL([2016],0) AS CNT2016,
	ISNULL([2017],0) AS CNT2017,
	ISNULL([2018],0) AS CNT2018,
	ISNULL([2019],0) AS CNT2019
FROM source
PIVOT(SUM(source.qty) FOR  source.lend_year
	IN ([2016],[2017],[2018],[2019]) 
)AS pvt
