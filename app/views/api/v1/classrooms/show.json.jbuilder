json.set! :name, @classroom.name

json.set! :students, @classroom.students do |student|

    json.id student.id
    json.full_name student.full_name
    
end

json.set! :subjects, @classroom.subjects do |subject|

    json.id subject.id
    json.name subject.name
    
end


json.set! :teachers, @teachers do |teacher|

    json.id teacher.id
    json.full_name teacher.full_name
    
end