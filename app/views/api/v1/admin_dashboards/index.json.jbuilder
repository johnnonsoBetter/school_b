

json.set! :teachers, @teachers do |teacher|

    json.id teacher.id
    json.full_name teacher.full_name
    
end


json.set! :classrooms, @classrooms do |classroom|

    json.id classroom.id
    json.name classroom.name
    
end

json.set! :score_types, @score_types do |score_type|

    json.id score_type.id
    json.name score_type.name
    
end


json.set! :announcements, @announcements do |announcement|

    json.id announcement.id
    json.image announcement.announcement_image.image
    json.message announcement.message
    json.expiration announcement.expiration
    
end


json.set! :term_dates, @term_dates do |term_date|

    json.id term_date.id
    json.name term_date.name
    
end
json.set! :debt_recovered_reports, @debt_recovered_reports do |debt_recovered_report|

    json.id debt_recovered_report.id
    json.amount debt_recovered_report.amount
    json.admin debt_recovered_report.admin
    json.bill debt_recovered_report.bill
    json.bill_report debt_recovered_report.bill.bill_report
    json.student debt_recovered_report.bill.student
    json.created_at debt_recovered_report.created_at
end




# json.set! :total_students,  @total_students
# json.set! :total_classrooms,  @classrooms.size
# json.set! :total_teachers,  @teachers.size
# json.set! :total_debts,  @total_debts
# json.set! :total_recovered_reports,  @total_debts_recovered