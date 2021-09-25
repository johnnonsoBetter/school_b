json.array! @bills do |bill|

    json.id bill.id
    json.title bill.title
    json.description bill.description 
    json.total_amount bill.total_amount
   
    json.payment_completed bill.payment_completed
    json.created_at bill.created_at
    

end
