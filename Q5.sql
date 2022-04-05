-- Which brand has the most spend among users who were created within the past 6 months?

with rank_spent as
(select b.name, rank() over (partition by b.brandId
                             order by sum(r.totalSpent) desc) rnk 
from receipts r 
right join items i 
on r.receiptId = i.receiptId
left join brands b 
on b.barcode = i.barcode
left join users u 
on r.usersId = u.usersId
where datediff(month,u.createdDate,getdate()) <= 6)

select b.name as brand 
from rank_spent
where rnk = 1
