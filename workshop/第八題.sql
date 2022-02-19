--8. �Ьd�ߥX���|(USER_ID =0002)���ɮѬ����A�䤤�]�t�ѥ�ID�B�ʮѤ��(yyyy/mm/dd)�B�ɾ\���(yyyy/mm/dd)�B���y���O(id-name)�B�ɾ\�H(id-cname(ename))�B���A(id-name)�B�ʮѪ��B												
SELECT bd.book_id AS  '�ѥ�ID',
	   CONVERT(VARCHAR,  bd.BOOK_BOUGHT_DATE, 111)  AS '�ʮѤ��',
	   CONVERT(varchar,  blr.LEND_DATE, 111)  AS '�ɾ\���',
	   bcl.BOOK_CLASS_NAME AS '���y���O',
	   CONCAT(m.USER_ID,'-', m.USER_CNAME,'(',m.USER_ENAME,')') AS '�ɾ\�H',
	   CASE bd.BOOK_STATUS 
	   WHEN 'A' THEN 'A-�i�H�ɥX'
	   WHEN 'B' THEN 'B-�w�ɥX'
	   WHEN 'C' THEN 'C-���i�ɥX'
	   END AS '���A',
	   CONCAT(FORMAT(bd.BOOK_AMOUNT , 'N0'),'��') AS '�ʮѪ��B'   --�T��@�J
FROM BOOK_CODE AS bco
INNER JOIN BOOK_DATA AS bd ON bco.CODE_ID=bd.BOOK_STATUS 
INNER JOIN BOOK_CLASS AS bcl ON bd.BOOK_CLASS_ID=bcl.BOOK_CLASS_ID
INNER JOIN BOOK_LEND_RECORD AS blr ON bd.BOOK_ID=blr.BOOK_ID
INNER JOIN MEMBER_M M ON m.USER_ID=blr.KEEPER_ID
WHERE m.USER_ID ='0002'