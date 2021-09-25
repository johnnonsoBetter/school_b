

json.array! @students  do |student|
    json.(student, :id, :first_name, :last_name)
end