--7. �Шϥ� PIVOT �y�k�C�X 2016, 2017, 2018, 2019 �U���y���O���ɾ\�ƶq��� (�ʺA���R�Ҧ��~��)�ʺApivot
/*�qbook lend date�� select�����ƪ��ɾ\�~��(�̫᪺column)�A�γo��table���columnyear(n�Ӧ~��)�Mcntuery����ܼ�
�A�[�W�βĤ��D���y�k
*/

--declare�Mselect�n�@�_����
Declare @columnyear NVARCHAR(Max);    --��cnt���
Declare @cntquery NVARCHAR(Max);      --��n�Ӧ~��
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


--���ͥX���Oid,���O�W��,�Q�ɾ\�~���M���O�C�~�Q�ɾ\�ƶq
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
