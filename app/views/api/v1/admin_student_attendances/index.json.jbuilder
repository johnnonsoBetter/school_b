
json.set! :term_dates, @term_dates do |term_date|

    json.id term_date.id
    json.name term_date.name
    
end


json.set! :attendances, @attendances do |attendance|

    json.id attendance.id
    json.is_present attendance.is_present
    json.created_at attendance.created_at
   
    
    

end

