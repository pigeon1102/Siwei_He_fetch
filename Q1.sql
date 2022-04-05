-- What are the top 5 brands by receipts scanned for most recent month?

select b.name
from receipts r 
right join items i 
on r.receiptId = i.receiptId
left join brands b 
on b.barcode = i.barcode
where datediff(month,r.dataScanned,getdate()) == 0
group by b.brandId 
order by count(*) desc
limit 5