json.array! @bills do |bill|

    json.id bill.id
    json.title bill.bill_report.title
    json.amount bill.bill_report.amount
    json.payment_completed bill.payment_completed
    json.created_at bill.created_at

    json.payment_histories bill.payment_histories do |payment_history| 
        json.id payment_history.id
        json.amount payment_history.amount 
        json.created_at payment_history.created_at
    end
    

end
