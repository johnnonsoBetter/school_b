

json.bill do 
  
    json.id @bill.id 
    json.payment_completed @bill.payment_completed
    json.amount @bill.bill_report.amount 
    json.title @bill.bill_report.title

end


json.payment_histories @bill.payment_histories do |payment_history| 

    json.(payment_history, :id, :amount)
end