
json.set! :announcements, @announcements do |announcement|

    json.id announcement.id
    json.image announcement.announcement_image.image
    json.message announcement.message

    
end

json.set! :term_dates, @term_dates do |term_date|

    json.id term_date.id
    json.name term_date.name
    
end



json.set! :students, @students  do |student|
    json.(student, :id, :first_name, :last_name)
end