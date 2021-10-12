json.array! @stock_repair_reports do |stock_repair_report|
    json.id stock_repair_report.id
    json.created_at stock_repair_report.created_at
    json.quantity stock_repair_report.quantity
    json.item stock_repair_report.item
    json.admin stock_repair_report.admin
end