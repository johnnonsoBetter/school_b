

json.array! @behaviour_reports do |behaviour_report|

    json.id behaviour_report.id
    json.title behaviour_report.title
    json.description behaviour_report.description 
    json.behaviour_type behaviour_report.behaviour_type
   
    
    

end


json.set! :term_dates, @term_dates do |term_date|

    json.id term_date.id
    json.name term_date.name
    
end