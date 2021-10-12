json.array! @debt_recovered_reports do |debt_recovered_report|

    json.id debt_recovered_report.id
    json.amount debt_recovered_report.amount
    json.admin debt_recovered_report.admin
    json.bill debt_recovered_report.bill
    json.bill_report debt_recovered_report.bill.bill_report
end

