json.array! @students do |student|

    json.id student.id
    json.first_name student.first_name
    json.last_name student.last_name
    json.full_name student.full_name
    json.total_debt student.total_debt
    json.classroom student.classroom.name

end