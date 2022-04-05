-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

With top5_recent_month as
(select b.name
from receipts r 
right join items i 
on r.receiptId = i.receiptId
left join brands b 
on b.barcode = i.barcode
where  datediff(month,r.dataScanned,getdate()) = 0
group by b.brandId order by count(*) desc
limit 5),

brand_rank as 
(select b.name, 
date_format(r.dataScanned, "%Y%M") as year_month, 
rank() over (partition by date_format(r.dataScanned, "%Y%M") 
	     orderby count(*) desc) rnk
from receipts r 
right join items i 
on r.receiptId = i.receiptId
left join brands b 
on b.barcode = i.barcode
group by b.name, date_format(r.dataScanned, "%Y%M")
order by date_format(r.dataScanned, "%Y%M") desc, rnk)

select name, year_month, rnk 
from brand_rank
where name in (select * from top5_recent_month)t 
and datediff(month,year_month,getdate()) = 1
