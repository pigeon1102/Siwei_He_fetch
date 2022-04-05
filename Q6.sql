-- Which brand has the most transactions among users who were created within the past 6 months

with rank_transac as
(select b.name, rank() over (partition by b.brandId
                             order by count(b.brandId) desc) rnk 
from receipts r 
right join items i 
on r.receiptId = i.receiptId
left join brands b  
on i.barcode = b.barcode
left join users u 
on r.usersId = u.usersId
where datediff(month,u.createdDate,getdate()) <= 6)

select b.name as brand 
from rank_transac
where rnk = 1


