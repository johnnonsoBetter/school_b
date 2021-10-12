json.array! @sale_reports do |sale_report|
    json.id sale_report.id
    json.total sale_report.total
    json.admin sale_report.admin
end