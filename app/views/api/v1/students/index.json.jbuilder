json.array! @students do |student|

    json.id student.id
    json.full_name student.full_name
    json.total_debt student.total_debt

end