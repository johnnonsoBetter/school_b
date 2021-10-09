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

json.set! :score_types, @score_types do |score_type|

    json.id score_type.id
    json.name score_type.name
    
end

json.set! :term_dates, @term_dates do |term_date|

    json.id term_date.id
    json.name term_date.name
    
end

json.set! :classrooms, @classrooms.to_a do |classroom|

    json.id classroom.id
    json.name classroom.name
end