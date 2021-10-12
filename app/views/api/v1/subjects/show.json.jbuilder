json.set! :subject , @subject.name

json.set! :classroom do 
    json.set! :name, @subject.classroom.name
    json.set! :id, @subject.classroom.id

end

json.set! :teacher do 
    json.set! :full_name, @subject.teacher.full_name
    json.set! :id, @subject.teacher.id

end

json.set! :students, @students do |student|

    json.id student.id
    json.full_name student.full_name
    json.total_debt student.total_debt
end

