require 'rails_helper'

RSpec.describe "Api::V1::AdminStudentAttendances", type: :request do
  before do 
    sch = build :school, id: 44
    
    class1 = create :classroom, name: "ss1", school: sch
    stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
    
    term_date = create :term_date, id: 1, name: "1st term 2021/2021", start_date: Date.new(2021, 5, 4), end_date: Date.new(2021, 8, 11)
    term_date = create :term_date, id: 3, name: "2nd term 2021/2021", start_date: Date.new(2021, 9, 4), end_date: Date.new(2021, 12, 11)

    teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch 
    @admin = create :admin, email: "mak3er@gmail.com", password: "password", school: sch

    create :attendance, student: stud1, classroom: class1, is_present: true, created_at: Date.new(2021, 5, 4)
    create :attendance, student: stud1, classroom: class1, is_present: true, created_at: Date.new(2021, 6, 4)
    create :attendance, student: stud1, classroom: class1, is_present: true, created_at: Date.new(2021, 10, 4)
    create :attendance, student: stud1, classroom: class1, is_present: false, created_at: Date.new(2021, 11, 4)
   
    

    @login_url = '/api/v1/auth/sign_in'
    @admin_student_attendances_url = '/api/v1/admin_student_attendances'

    @admin_params = {
      email: @admin.email,
      password: @admin.password
    }

  end

  context "when admin is not authenticated" do
    it "return http status unauthorized" do
      
      get @admin_student_attendances_url
      expect(response).to have_http_status(:unauthorized)  
    end
    
  end

  context "when admin is authenticated " do
    
    before do 
      post @login_url, params: @admin_params
      
      @headers = {
        'access-token' => response.headers['access-token'],
        'client' => response.headers['client'],
        'uid' => response.headers['uid']
      }

     
     
    end

    context "when term id params does not exists" do
      
      before do 

        get @admin_student_attendances_url, headers: @headers, params: {student_id: 34}
        @json_body = JSON.parse(response.body)
        
        
      end

      it "returns proper json response of the first attendance report of stud1" do
        expect(@json_body['attendances'].first).to include({
          
          'is_present' => true

        })  
      end 

      it "returns proper json response of the last attendance report of stud1" do
        expect(@json_body['attendances'].last).to include({
          
          'is_present' => false

        })  
      end 

    end


    context "when term id params exists" do
      
      before do 

        get @admin_student_attendances_url, headers: @headers, params: {student_id: 34, term_id: 1}
        @json_body = JSON.parse(response.body)
        
        
      end

      it "returns proper json response of the first attendance report of stud1" do
        expect(@json_body['attendances'].first).to include({
          
          'is_present' => true

        })  
      end 

      it "returns proper json response of the last attendance report of stud1" do
        expect(@json_body['attendances'].last).to include({
          
          'is_present' => true

        })  
      end 

    end

   
    

  end
end
