json.array! @announcements do |announcement|

    json.id announcement.id
    json.message announcement.message
    json.image announcement.announcement_image.image
    

end