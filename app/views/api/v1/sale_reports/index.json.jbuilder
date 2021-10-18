

json.array! @sale_reports do |sale_report|
    json.id sale_report.id
    json.total sale_report.total
    json.admin sale_report.admin
    json.created_at sale_report.created_at

    json.item_solds sale_report.item_solds do |item| 

        json.id item.id
        json.name item.item.name 
        json.quantity item.quantity

    end
   
end

