json.set! :subject , @subject.name
json.set! :classroom , @subject.classroom.name

json.set! :teacher do 
    json.set! :full_name, @subject.teacher.full_name
    json.set! :id, @subject.teacher.id

end

json.set! :students, @students do |student|

    json.id student.id
    json.full_name student.full_name
    
end

