json.(@bill, :id, :title, :description, :total_amount, :payment_completed)
json.payment_histories @bill.payment_histories do |payment_history| 

    json.(payment_history, :id, :amount)
end