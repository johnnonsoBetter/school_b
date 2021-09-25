require 'rails_helper'

RSpec.describe "Api::V1::GuidanceBills", type: :request do
  describe "GET /index" do
    
    before do 
      sch = build :school, id: 44
      
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
      
      @guidance = create :guidance, email: "mak3er@gmail.com", password: "password"
      @guidance2 = create :guidance, email: "shdfgdgfisf@gmail.com", password: "password"

      create :bill, title: "school fee", description: "school fee for 2nd term", total_amount: 700, payment_completed: true, student: stud1
      create :bill, title: "school fee", description: "school fee for 3nd term", total_amount: 900, payment_completed: true, student: stud2
      create :bill, title: "exam fee", description: "exam fee for 3nd term", total_amount: 1500, payment_completed: false, student: stud1
      create :bill, title: "test fee", description: "test fee for 3nd term", total_amount: 500, payment_completed: true, student: stud2

     

      @guidance.students << stud1
      @guidance.students << stud3
      @guidance2.students << stud2
  


      @login_url = '/api/v1/guidance_auth/sign_in'
      @guidance_bills_url = '/api/v1/guidance_bills'
  
      @guidance_params = {
        email: @guidance.email,
        password: @guidance.password
      }

      
     
    end

    context "when guidance is not authenticated" do
      it "return http status unauthorized" do
        
        get @guidance_bills_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when guidance is authenticated " do
      
      before do 
        post @login_url, params: @guidance_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

      end


      context "when student id exists " do
        
        before do 

          get @guidance_bills_url, headers: @headers, params: {student_id: 34}
          @json_body = JSON.parse(response.body)
          
          
        end


        it "returns proper json response of the first bill  of stud1" do
          expect(@json_body.first).to include({
            "title"  => "school fee",
            "description" => "school fee for 2nd term",
            "total_amount" => 700,
            "payment_completed" => true
          })  
        end

        it "returns proper json response of the last bill  of stud1" do
          expect(@json_body.last).to include({
            "title"  => "exam fee",
            "description" => "exam fee for 3nd term",
            "total_amount" => 1500,
            "payment_completed" => false
          })  
        end

      end
      


      

      
    end
    
    

  end
end
