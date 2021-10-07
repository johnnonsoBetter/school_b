require 'rails_helper'

RSpec.describe "Api::V1::Debtors", type: :request do
  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true, full_name: "bose peter"
      
      class1 = create :classroom, id: 1, name: "ss1", school: sch
      class2 = create :classroom, id: 2, name: "ss2", school: sch
      
      stud1 = create :student, id: 1, classroom: class1, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch, total_debt: 300
      stud2 = create :student, id: 2, classroom: class2, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal", total_debt: 4000
      stud3 = create :student, id: 3, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna", total_debt: 0



      @login_url = '/api/v1/auth/sign_in'
      @debtor_report_url = '/api/v1/debtors'
  
      @admin_params = {
        email: @admin.email,
        password: @admin.password
      }

      post @login_url, params: @admin_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

    end

    context "when admin is not authenticated" do
      it "return http status unauthorized" do
        
        get @debtor_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @debtor_report_url, headers: @headers} 

      

      it "returns proper json response of first debtor" do

        subject
        json_body = JSON.parse(response.body)

        expect(json_body.first).to include({
          'first_name' => 'chima',
          'total_debt' => 300,
          'last_name' => 'joy'
        })  
        
      end


      it "returns proper json response of last debtor" do

        subject
        json_body = JSON.parse(response.body)

        expect(json_body.last).to include({
          'first_name' => 'ani',
          'total_debt' => 4000,
          'last_name' => 'micheal'
        })  
        
      end


      # it "returns proper json response of last debtor" do

      #   subject
      #   json_body = JSON.parse(response.body)

      #   expect(json_body.last).to include({
      #     'title' => 'lecture fee',
      #     'amount' => 9000,
      #     'admin' => 'bose peter'
      #   })  
        
      # end
      

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end
      

     
 
    end
    

  end
end
