# require 'rails_helper'

# RSpec.describe "Api::V1::MultipleAttendanceCreators", type: :request do
#   describe "POST " do
   
#       before do 
#         @sch = build :school, id: 44
#         create :classroom, name: "js1", school: @sch
#         create :classroom, name: "js2", school: @sch
#         @teacher = create :teacher, id: 9, email: "teacher@mail.com", password: "password", school: @sch, permitted: true
    
#         @c3 = create :classroom, id: 3, name: "js3", school: @sch, class_teacher_id: 9
#         c4 = create :classroom, id: 6, name: "ss3", school: @sch, class_teacher_id: 8
  
#         @stud1 = create :student, classroom: @c3, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: @sch
#         stud2 = create :student, classroom: @c3, email: "chi2@gmail.com", password: "password", first_name: "muna", last_name: "p", middle_name: "obi", school: @sch
#         stud2 = create :student, classroom: c4, email: "chika2@gmail.com", password: "password", first_name: "sdf", last_name: "p", middle_name: "beat", school: @sch
  
  
#         @login_url = '/api/v1/teacher_auth/sign_in'
#         @multiple_attendance_creators_url = '/api/v1/multiple_attendance_creators'
    
#         @teacher_params = {
#           email: @teacher.email,
#           password: @teacher.password
#         }
  
#         post @login_url, params: @teacher_params
          
#           @headers = {
#             'access-token' => response.headers['access-token'],
#             'client' => response.headers['client'],
#             'uid' => response.headers['uid']
#           }
  
#       end
  
#       context "when teacher is not authenticated" do
#         it "return http status unauthorized" do
          
#           post @multiple_attendance_creators_url
#           expect(response).to have_http_status(:unauthorized)  
#         end
        
#       end
  
#       context "when teacher is not permitted " do
  
#         it "returns https status code 401 unauthorized" do
#           @teacher.permitted = false
#           @teacher.save 
#           post @multiple_attendance_creators_url, headers: @headers
#           expect(response).to have_http_status(:unauthorized)  
#         end
        
        
#       end


#       context "if attendance records already exists for that day" do

#         subject {  post @multiple_attendance_creators_url, headers: @headers, params: {classroom_id: 3}} 

#         before do 
#           create :attendance, classroom: @c3, student: @stud1, created_at: DateTime.now
#         end

       

#         it "do not change the Attendance count" do
          
#           expect{subject}.to_not change{Attendance.count}
#         end

#         it "returns http status :ok" do
          
#           subject
#           expect(response).to have_http_status(:ok)
#         end

#         it "returns proper first attendance json response" do

#           subject
#           json_body = JSON.parse(response.body)

#           expect(json_body.first).to include({
#             'is_present' => true
#           })

#           expect(json_body.first['student']).to include({
#             'full_name' => 'chima paul joy'
#           })
          
#         end

#         it "returns proper last attendance json response" do

#           subject
#           json_body = JSON.parse(response.body)

#           expect(json_body.last).to include({
#             'is_present' => true
#           })

#           expect(json_body.last['student']).to include({
#             'full_name' => 'chima paul joy'
#           })
          
#         end
        

#       end
  
#       context "when teacher is authenticated " do

       

        

#         context "when new attendance has been created " do

#           subject {  post @multiple_attendance_creators_url, headers: @headers, params: {classroom_id: 3}} 
#           it "increment the attendance by 2" do
#             expect{subject}.to change{Attendance.count}.by(2)
#           end
          
#           it "return http_status :created" do
#             subject
#             expect(response).to have_http_status(:created)
#           end

#           it "returns proper first attendance json response" do

#             subject
#             json_body = JSON.parse(response.body)

#             expect(json_body.first).to include({
#               'is_present' => true
#             })

#             expect(json_body.first['student']).to include({
#               'full_name' => 'chima paul joy'
#             })
            
#           end

#           it "returns proper last attendance json response" do

#             subject
#             json_body = JSON.parse(response.body)

#             expect(json_body.last).to include({
#               'is_present' => true
#             })

#             expect(json_body.last['student']).to include({
#               'full_name' => 'muna obi p'
#             })
            
#           end


          
#         end


       

#         context "creation day is non school day" do

#           subject {  post @multiple_attendance_creators_url, headers: @headers, params: {classroom_id: 3}} 

#           it "do not change the Attendance count" do
#             @sch.no_attendance = true 
#             @sch.save
#             expect{subject}.to_not change{Attendance.count}
#           end

#           it "returns http status :unprocessable_entity" do
#             @sch.no_attendance = true 
#             @sch.save
#             subject
#             expect(response).to have_http_status(:unprocessable_entity)
#           end
          

#         end


#         context "when user trying to create the attendance is not a class teacher of that class" do

#           subject {  post @multiple_attendance_creators_url, headers: @headers, params: {classroom_id: 6}} 

#           it "do not change the Attendance count" do
           
#             expect{subject}.to_not change{Attendance.count}
#           end

#           it "returns http status :unauthorized" do
            
#             subject
#             expect(response).to have_http_status(:unauthorized)
#           end
          
         
          

#         end

        
        

#       end
      
  
#   end
# end
