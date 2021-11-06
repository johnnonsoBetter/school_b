
json.set! :announcements, @announcements do |announcement|

    json.id announcement.id
    json.image announcement.announcement_image.image
    json.message announcement.message
    json.expiration announcement.expiration
    
end



json.set! :students, @students  do |student|
    json.(student, :id, :first_name, :last_name)
end