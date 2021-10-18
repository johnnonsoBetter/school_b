json.set! :name, @classroom.name

json.set! :students, @classroom.students do |student|

    json.id student.id
    json.full_name student.full_name
    json.total_debt student.total_debt
    
end

json.set! :subjects, @classroom.subjects do |subject|

    json.id subject.id
    json.name subject.name
    
end


json.set! :teachers, @teachers.to_a do |teacher|

    json.id teacher.id
    json.full_name teacher.full_name
    
end