json.student do 

    json.id @student.id
    json.email @student.email
    json.first_name @student.first_name
    json.middle_name @student.middle_name
    json.last_name @student.last_name
    json.full_name @student.full_name
    json.state @student.state
    json.lga @student.lga 
    json.date_of_birth @student.date_of_birth
    json.date_of_admission @student.date_of_admission
    json.religion @student.religion
    json.gender @student.gender 
    json.admission_no @student.admission_no
    json.address @student.address
    json.classroom @student.classroom.name
    json.classroom_id @student.classroom.id
    json.image @student.image
    
end
