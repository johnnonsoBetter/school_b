
json.array! @bill_reports do |bill_report|

    json.id bill_report.id
    json.title bill_report.title
    json.amount bill_report.amount
    json.admin bill_report.admin.full_name
    json.created_at bill_report.created_at
    

end