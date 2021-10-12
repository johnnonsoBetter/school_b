json.array! @bills do |bill|

    json.id bill.id
    json.paid bill.paid
    json.balance bill.balance
    json.bill_report bill.bill_report

    json.payment_histories bill.payment_histories do |payment_history|
        json.amount payment_history.amount 
        json.created_at payment_history.created_at
        
    end
    
end

