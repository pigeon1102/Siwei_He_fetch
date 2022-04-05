-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?


select rewardsReceiptStatus, sum(purchasedItemCount) as total_item
from receipts r 
Right join items i on r.receiptId = i.receiptId
where rewardsReceiptStatus = 'FINISHED' or rewardsReceiptStatus = 'REJECTED'
group by rewardsReceiptStatus
order by sum(purchasedItemCount) desc
