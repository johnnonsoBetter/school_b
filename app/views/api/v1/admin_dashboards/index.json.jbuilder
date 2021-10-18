

json.set! :teachers, @teachers do |teacher|

    json.id teacher.id
    json.full_name teacher.full_name
    
end


json.set! :classrooms, @classrooms do |classroom|

    json.id classroom.id
    json.name classroom.name
    
end

json.set! :score_types, @score_types do |score_type|

    json.id score_type.id
    json.name score_type.name
    
end


json.set! :term_dates, @term_dates do |term_date|

    json.id term_date.id
    json.name term_date.name
    
end
