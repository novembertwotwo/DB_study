select info.REST_ID,info.REST_NAME,info.FOOD_TYPE,info.FAVORITES,ADDRESS,Round(avg(REVIEW_SCORE),2) as score
from REST_REVIEW review
join REST_INFO info
on info.REST_ID = review.REST_ID
group by review.REST_ID
having info.ADDRESS like "서울%"
order by score desc, FAVORITES desc


