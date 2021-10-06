require 'rails_helper'

RSpec.describe "Api::V1::Subjects", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher 1"
      @classroom = create :classroom, id: 3, name: "js3", school: sch

      @subject_params = {subject: {name: "english", teacher_id: @teacher.id, classroom_id: @classroom.id }}

      @login_url = '/api/v1/auth/sign_in'
      @subject_url = '/api/v1/subjects'
  
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
        
        post @subject_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @subject_url, headers: @headers, params: @subject_params } 

      context "when new subject report has been created" do
        it "increment subject report by 1" do
          expect{subject}.to change{Subject.count}.by(1)
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
      

      context "when new subject failed to be created" do


        it "increment subject report by 1" do
          expect{          post @subject_url, headers: @headers, params: {subject: {name: "english", teacher_id: @teacher.id }}
        }.to_not change{Subject.count}
        end

        it "returns htpp status code unprocessable entity" do
          post @subject_url, headers: @headers, params: {subject: {name: "english", teacher_id: @teacher.id }}
          expect(response).to have_http_status(:unprocessable_entity)
          
        end

      end
 
    end
    

  end




  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      sch2 = create :school, id: 32
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher 1"
      @teacher2 = create :teacher, email: "teachdfsdfer@mail.com", password: "password", school: sch2, permitted: true, full_name: "teacher 2"
      @teacher3 = create :teacher, email: "teachdfdssfsdfer@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher 3"
      @classroom = create :classroom, id: 3, name: "js1", school: sch
      @classroom2 = create :classroom, name: "js2", school: sch
      @classroom3 = create :classroom, name: "js3", school: sch
      @classroom4 = create :classroom, name: "js2", school: sch2


      create :subject, name: "english", classroom: @classroom, teacher: @teacher
      create :subject, name: "social", classroom: @classroom, teacher: @teacher
      create :subject, name: "physics js1", classroom: @classroom, teacher: @teacher

      
      create :subject, name: "physics", classroom: @classroom3, teacher: @teacher3
      create :subject, name: "mathematics", classroom: @classroom2, teacher: @teacher

      create :subject, name: "english", classroom: @classroom4, teacher: @teacher2
      create :subject, name: "mathematics", classroom: @classroom4, teacher: @teacher2
     
     
      @login_url = '/api/v1/auth/sign_in'
      @subject_url = '/api/v1/subjects'
  
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
        
        get @subject_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @subject_url, headers: @headers } 


      it "returns proper json first subject response" do
        subject
        json_body = JSON.parse(response.body)
        expect(json_body.first).to include({
          "name" => "english"
        })  
        
      end

      it "returns proper json last subject response" do
        subject
        json_body = JSON.parse(response.body)
        expect(json_body.last).to include({
          "name" => "mathematics"
        })  
        
      end

      it "returns proper json length of total subjects" do
        subject
        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq(5)
        
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

      @teacher1 = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher 1"
      
      sub = create :subject, id: 3, name: "mathematics", teacher: @teacher1, classroom: c3 
      
      @login_url = '/api/v1/auth/sign_in'
      @subject_url = '/api/v1/subjects/3'
  
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
        
        get @subject_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is not permitted " do

      it "returns https status code 401 unauthorized" do
        @admin.permitted = false
        @admin.save 
        get @subject_url, headers: @headers
        expect(response).to have_http_status(:unauthorized)  
      end
      
      
    end

    context "when admin is authenticated " do

      subject {  get @subject_url, headers: @headers } 

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



      it "returns proper json teacher response" do
        
        expect(@json_body['teacher']).to include({
          "full_name" => "teacher 1"
        })  
        
      end

      it "returns proper json response of the subject name" do

        expect(@json_body["subject"]).to eq("mathematics")
        
      end

      it "returns proper json response of the subject name" do

        expect(@json_body["classroom"]).to eq("js3")
        
      end
      

     

      
 
    end
    

  end


end
