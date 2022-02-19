--7. 請使用 PIVOT 語法列出 2016, 2017, 2018, 2019 各書籍類別的借閱數量比較 (動態分析所有年度)動態pivot
/*從book lend date中 select不重複的借閱年份(最後的column)，用這個table放到columnyear(n個年份)和cntuery兩個變數
再加上用第六題的語法
*/

--declare和select要一起執行
Declare @columnyear NVARCHAR(Max);    --放cnt欄位
Declare @cntquery NVARCHAR(Max);      --放n個年份
DECLARE @SqlStr NVARCHAR(MAX);

;WITH Y AS(   
	SELECT DISTINCT  CONVERT(NVARCHAR,YEAR(blr.LEND_DATE)) AS PvtIn 
	FROM BOOK_LEND_RECORD AS blr
)
SELECT 
	@columnyear= COALESCE( @columnyear + ',' , '')+ 'ISNULL('+QUOTENAME(Y.PvtIn)+',0) AS '+QUOTENAME('CNT'+Y.PvtIn),
	@cntquery= COALESCE(@cntquery + ',' , '' )+ QUOTENAME(PvtIn)
FROM Y

SELECT @columnyear
SELECT @cntquery


--產生出類別id,類別名稱,被借閱年份和類別每年被借閱數量
SELECT @SqlStr=
N'WITH source as(                               
SELECT bc.BOOK_CLASS_ID,  
	   bc.BOOK_CLASS_NAME ,
	   YEAR(blr.LEND_DATE) AS lend_year,
	   COUNT(blr.LEND_DATE) AS qty
FROM 
BOOK_LEND_RECORD AS blr 
INNER JOIN BOOK_DATA AS bd ON blr.BOOK_ID = bd.BOOK_ID
INNER JOIN BOOK_CLASS AS bc ON bd.BOOK_CLASS_ID = bc.BOOK_CLASS_ID
GROUP BY  bc.BOOK_CLASS_ID,bc.BOOK_CLASS_NAME ,YEAR(blr.LEND_DATE) 
)
SELECT BOOK_CLASS_ID AS ClassId,BOOK_CLASS_NAME AS ClassName,
'+@columnyear +
'FROM source
PIVOT(SUM(source.qty) FOR  source.lend_year
	IN ('+@cntquery +')    
)AS pvt'

EXEC sp_executesql @SqlStr    
