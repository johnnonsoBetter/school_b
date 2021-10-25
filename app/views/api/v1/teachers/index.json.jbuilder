json.array! @teachers do |teacher|

    json.id teacher.id
    json.full_name teacher.full_name
    json.permitted teacher.permitted

end