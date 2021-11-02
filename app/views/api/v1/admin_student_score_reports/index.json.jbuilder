
json.set! :score_reports, @score_reports do |score_report|

    json.id score_report.id
    json.max score_report.max
    json.score score_report.score 
    json.remark score_report.remark
    json.subject score_report.subject.name 
    json.teacher score_report.teacher.name
    json.score_type score_report.score_type.name 

end



json.set! :term_dates, TermDate.all do |term_date|

    json.id term_date.id
    json.name term_date.name
    
end

json.set! :score_types, @score_types do |score_type|

    json.id score_type.id
    json.name score_type.name
    
end
