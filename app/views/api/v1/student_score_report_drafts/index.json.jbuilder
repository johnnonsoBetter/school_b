
json.array! @student_score_report_drafts do |student_score_report_draft|

    json.id student_score_report_draft.id
    json.score student_score_report_draft.score 
    json.created_at student_score_report_draft.created_at
end