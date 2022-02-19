--3. 以一季列出2019年每一季書籍借閱書量 (請考慮未來需求調整對程式的變動幅度) 		
--日期篩選 between and			
SELECT COUNT(LEND_DATE) AS CNT,
	CASE 	
		WHEN LEND_DATE>='2019/01/01' AND LEND_DATE<='2019/03/30' THEN '2019/01~2019/03'
		WHEN LEND_DATE>='2019/04/01' AND LEND_DATE<='2019/06/30' THEN '2019/04~2019/06'
		WHEN LEND_DATE>='2019/07/01' AND LEND_DATE<='2019/09/30' THEN '2019/07~2019/09'  
		WHEN LEND_DATE>='2019/10/01' AND LEND_DATE<='2019/12/31' THEN '2019/10~2019/12'
	END	AS QUARTER_YEAR
FROM BOOK_LEND_RECORD
WHERE YEAR(LEND_DATE)=2019
GROUP BY 
	CASE 	
		WHEN LEND_DATE>='2019/01/01' AND LEND_DATE<='2019/03/30' THEN '2019/01~2019/03'
		WHEN LEND_DATE>='2019/04/01' AND LEND_DATE<='2019/06/30' THEN '2019/04~2019/06'
		WHEN LEND_DATE>='2019/07/01' AND LEND_DATE<='2019/09/30' THEN '2019/07~2019/09'  
		WHEN LEND_DATE>='2019/10/01' AND LEND_DATE<='2019/12/31' THEN '2019/10~2019/12'
	END
