class ScoreReport < ApplicationRecord

  before_create :set_remark
  belongs_to :teacher
  belongs_to :student
  belongs_to :subject
  belongs_to :score_type


  private 

  def set_remark 

    percent = (score.to_f / max.to_f) * 100
    percentage = percent.to_i
    
    if percentage >= 90 && percentage <= 100 
      self.remark = "excellent"
    elsif percentage >= 70 && percentage <= 89 
      self.remark = "very good"
    elsif percentage >= 50 && percentage <= 69 
        self.remark = "good"
    elsif percentage >= 20 && percentage <= 49
      self.remark = "poor"
    elsif percentage >= 0 && percentage <= 19 
      self.remark = "very poor"
    end

  end
end
