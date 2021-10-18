json.array! @expense_reports do |expense_report|

    json.id expense_report.id
    json.title expense_report.title 
    json.amount expense_report.amount
    json.admin expense_report.admin
    json.created_at expense_report.created_at
end