require 'rails_helper'

RSpec.describe ScoreReport, type: :model do

  

  describe "#Validations" do

  it { should belong_to(:teacher) } 
  it { should belong_to(:subject) } 
  it { should belong_to(:student) } 
  it { should belong_to(:score_type) }

  

  context "when score report is created" do

    let(:sch){build :school, id: 44}
    let(:class1){create :classroom, name: "ss1", school: sch}
    let(:student){create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch}
    let(:score_type){create :score_type, name: "homework", school: sch}
    let(:teacher){create :teacher, email: "teacher@mail.com", password: "password", school: sch}
    let(:subject){create :subject, name: "english", classroom: class1, teacher: teacher}
    let(:score_report){create :score_report, max: 60, score: 40, student: student, subject: subject, teacher: teacher, score_type: score_type}


    it "set the remark to good if score is 35 " do

   
      new_score_report = create :score_report, max: 60, score: 35, student: student, subject: subject, teacher: teacher, score_type: score_type
      the_score_report = ScoreReport.find(new_score_report.id)
      expect(the_score_report.remark).to eq("good")  
      
    end

    it "set the remark to very poor if score is 10 " do

      new_score_report = create :score_report, max: 60, score: 10, student: student, subject: subject, teacher: teacher, score_type: score_type
      the_score_report = ScoreReport.find(new_score_report.id)
      expect(the_score_report.remark).to eq("very poor")  
      
    end

    it "set the remark to very good if score is 45 " do

      new_score_report = create :score_report, max: 60, score: 45, student: student, subject: subject, teacher: teacher, score_type: score_type
      the_score_report = ScoreReport.find(new_score_report.id)
      expect(the_score_report.remark).to eq("very good")  
      
    end

    it "set the remark to excellent if score is 55 " do

      new_score_report = create :score_report, max: 60, score: 55, student: student, subject: subject, teacher: teacher, score_type: score_type
      the_score_report = ScoreReport.find(new_score_report.id)
      expect(the_score_report.remark).to eq("excellent")  
      
    end

    it "set the remark to poor if score is 25 " do

      new_score_report = create :score_report, max: 60, score: 25, student: student, subject: subject, teacher: teacher, score_type: score_type
      the_score_report = ScoreReport.find(new_score_report.id)
      expect(the_score_report.remark).to eq("poor")  
      
    end
    
    
    
  end
  


    
  end
  
end
