json.array! @attendances do |attendance|

    json.id attendance.id
    json.is_present attendance.is_present

    json.student  do 

        json.(attendance.student, :image, :full_name)
    
    end
    

end