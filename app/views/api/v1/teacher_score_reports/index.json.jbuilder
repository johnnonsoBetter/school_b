
json.array! @score_reports do |score_report|

    json.id score_report.id
    json.max score_report.max
    json.score score_report.score 
    json.remark score_report.remark 
    json.student score_report.student.full_name
    json.score_type score_report.score_type.name 

end
