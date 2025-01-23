select a.TITLE,b.BOARD_ID,b.REPLY_ID,b.WRITER_ID,b.CONTENTS,DATE_FORMAT(b.CREATED_DATE,"%Y-%m-%d") as CREATED_DATE
from USED_GOODS_BOARD a
join USED_GOODS_REPLY b
on a.BOARD_ID = b.BOARD_ID
where Year(a.CREATED_DATE) = 2022 && Month(a.CREATED_DATE) = 10
order by CREATED_DATE ,TITLE
