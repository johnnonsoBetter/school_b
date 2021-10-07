
json.array! @student_score_report_drafts do |student_score_report_draft|

    json.id student_score_report_draft.id
    json.score student_score_report_draft.score 
    json.full_name student_score_report_draft.student.full_name
end