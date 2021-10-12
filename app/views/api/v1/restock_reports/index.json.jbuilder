json.array! @restock_reports do |restock_report|
    json.id restock_report.id
    json.created_at restock_report.created_at
    json.quantity restock_report.quantity
    json.item restock_report.item.name
    json.admin restock_report.admin
end