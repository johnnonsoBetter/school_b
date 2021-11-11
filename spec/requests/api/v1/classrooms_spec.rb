require 'rails_helper'

RSpec.describe "Api::V1::Classrooms", type: :request do
 
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @classroom_params = {classroom: {name: "school a"}}

      @login_url = '/api/v1/auth/sign_in'
      @classroom_url = '/api/v1/classrooms'
  
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
        
        post @classroom_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @classroom_url, headers: @headers, params: @classroom_params } 

      context "when new classroom report has been created" do
        it "increment classroom report by 1" do
          expect{subject}.to change{Classroom.count}.by(1)
        end

        it "returns http status created " do
          subject
          expect(response).to have_http_status(:created)
        end
        
      end

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end

      context "when new classroom failed to be created" do


        it "increment classroom report by 1" do
          expect{post @classroom_url, headers: @headers, params: {classroom: {name: ""}}}.to_not change{Classroom.count}
        end

        it "returns htpp status code unprocessable entity" do
          post @classroom_url, headers: @headers, params: {classroom: {name: ""}}
          expect(response).to have_http_status(:unprocessable_entity)
          
        end

      end
 
    end
    

  end



  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      create :classroom, name: "js1", school: sch
      create :classroom, name: "js2", school: sch
      create :classroom, name: "js3", school: sch
     
      @login_url = '/api/v1/auth/sign_in'
      @classroom_url = '/api/v1/classrooms'
  
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
        
        get @classroom_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @classroom_url, headers: @headers } 


      it "returns proper json first classroom response" do
        subject
        json_body = JSON.parse(response.body)
        expect(json_body.first).to include({
          "name" => "js1"
        })  
        
      end

      it "returns proper json last classroom response" do
        subject
        json_body = JSON.parse(response.body)
        expect(json_body.last).to include({
          "name" => "js3"
        })  
        
      end
      

      

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



  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      create :classroom, name: "js1", school: sch
      create :classroom, name: "js2", school: sch
      c3 = create :classroom, id: 3, name: "js3", school: sch

      stud1 = create :student, classroom: c3, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch
      stud2 = create :student, classroom: c3, email: "chi2@gmail.com", password: "password", first_name: "muna", last_name: "p", middle_name: "obi", school: sch

      @teacher1 = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher 1", first_name: "teacher", middle_name: "k", last_name: "1"
      @teacher2 = create :teacher, email: "t@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher 2", first_name: "teacher", middle_name: "k", last_name: "2"
      @teacher3 = create :teacher, email: "teac@mail.com", password: "password", school: sch, permitted: false, full_name: "teacher 3"

      sub = create :subject, name: "maths", teacher: @teacher1, classroom: c3 
      sub2 = create :subject, name: "eng", teacher: @teacher2, classroom: c3

     
      @login_url = '/api/v1/auth/sign_in'
      @classroom_url = '/api/v1/classrooms/3'
  
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
        
        get @classroom_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is not permitted " do

      it "returns https status code 401 unauthorized" do
        @admin.permitted = false
        @admin.save 
        get @classroom_url, headers: @headers
        expect(response).to have_http_status(:unauthorized)  
      end
      
      
    end

    context "when admin is authenticated " do

      subject {  get @classroom_url, headers: @headers } 

      before do 
        subject
        @json_body = JSON.parse(response.body)

      end


      it "returns proper json first classroom student response" do
        
        expect(@json_body['students'].first).to include({
          "full_name" => "chima paul joy"
        })  
        
      end

      it "returns proper json last classroom student response" do
        
        expect(@json_body['students'].last).to include({
          "full_name" => "muna obi p"
        })  
        
      end

      it "returns proper json first classroom subject response" do
        
        expect(@json_body['subjects'].first).to include({
          "name" => "js3 maths"
        })  
        
      end

      it "returns proper json last classroom subject response" do
        
        expect(@json_body['subjects'].last).to include({
          "name" => "js3 eng"
        })  
        
      end

      it "returns proper json first classroom teacher that is permitted response" do
        
        expect(@json_body['teachers'].first).to include({
          "full_name" => "teacher k 1"
        })  
        
      end

      it "returns proper json response of the classroom name" do

        expect(@json_body["name"]).to eq("js3")
        
      end
      

      it "returns proper json last classroom teacher that is permitted response" do
        
        expect(@json_body['teachers'].last).to include({
          "full_name" => "teacher k 2"
        })  
        
      end

      
 
    end
    

  end

end
