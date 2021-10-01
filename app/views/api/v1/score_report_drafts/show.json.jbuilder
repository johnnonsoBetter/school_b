
json.score_report_draft do 

    json.id @score_report_draft.id
    json.max @score_report_draft.max
    json.subject @score_report_draft.subject.name 
    json.score_type @score_report_draft.score_type.name 
    json.published @score_report_draft.published
    json.created_at @score_report_draft.created_at
    
end

json.student_score_report_drafts @student_score_report_drafts do |student_score_report_draft|

   
    json.id student_score_report_draft.id
    json.full_name student_score_report_draft.student.full_name
    json.score student_score_report_draft.score
end
