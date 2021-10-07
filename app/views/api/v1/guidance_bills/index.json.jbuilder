json.array! @bills do |bill|

    json.id bill.id
    json.title bill.bill_report.title
    json.amount bill.bill_report.amount
    json.payment_completed bill.payment_completed
    json.created_at bill.created_at
    

end
