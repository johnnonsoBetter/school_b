json.set! :teacher do
    json.set! :full_name, @teacher.full_name
  end

json.set! :score_report_drafts, @score_report_drafts do |score_report_draft|

    json.id score_report_draft.id
    json.max score_report_draft.max
    json.subject score_report_draft.subject.name 
    json.score_type score_report_draft.score_type.name 
    json.published score_report_draft.published
    json.created_at score_report_draft.created_at
end

json.set! :subjects, @teacher.subjects do |subject|

    json.id subject.id
    json.name subject.name
    
end