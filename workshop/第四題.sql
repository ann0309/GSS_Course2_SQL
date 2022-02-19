--4.���X�C�Ӥ����ɾ\�ƶq�e�T�W�ѥ��μƶq  
SELECT * FROM (
	SELECT 
		ROW_NUMBER() OVER (PARTITION BY bcl.BOOK_CLASS_NAME order BY  COUNT(bd.BOOK_ID) desc) AS seq,         --�Q��class name���s,�̷�book id�ƶq(cnt)���L�s�W�y����(�@�s�@��)
		bcl.BOOK_CLASS_NAME AS BookClass,
		bd.BOOK_ID AS BookId,
		bd.BOOK_NAME AS BookName,
		COUNT(bd.BOOK_ID) AS Cnt   --�C�@���� ���Q�ɾ\��
	FROM BOOK_DATA AS bd
	INNER JOIN BOOK_LEND_RECORD blr ON bd.BOOK_ID=blr.BOOK_ID
	INNER JOIN BOOK_CLASS bcl ON bd.BOOK_CLASS_ID=bcl.BOOK_CLASS_ID
	GROUP BY  bcl.BOOK_CLASS_NAME,bd.BOOK_ID,bd.BOOK_NAME,bcl.BOOK_CLASS_ID
)AS aaa
WHERE aaa.seq<=3   --���Xseq�y������1,2,3�����







--SELECT * FROM BOOK_LEND_RECORD blr WHERE blr.BOOK_ID=411














--���~
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


