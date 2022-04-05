-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

select rewardsReceiptStatus, avg(totalSpend) as avg_spent
from receipts
where rewardsReceiptStatus = 'FINISHED' or rewardsReceiptStatus = 'REJECTEDted'
group by rewardsReceiptStatus
order by avg(totalSpend) desc


