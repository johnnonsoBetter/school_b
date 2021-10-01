
json.array! @score_report_drafts do |score_report_draft|

    json.id score_report_draft.id
    json.max score_report_draft.max
    json.subject score_report_draft.subject.name 
    json.score_type score_report_draft.score_type.name 
    json.published score_report_draft.published
    json.created_at score_report_draft.created_at
end