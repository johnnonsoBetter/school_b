


json.array! @attendances do |attendance|

    json.id attendance.id
    json.is_present attendance.is_present
    json.created_at attendance.created_at
   
    
    

end

