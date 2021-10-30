require 'rails_helper'



RSpec.describe "Api::V1::Notifications", type: :request do
  describe "POST" do

    before do 
      sch = build :school, id: 44
      
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
      score_t1 = create :score_type, name: "homework", school: sch
  
      @guidance = create :guidance, email: "mak3er@gmail.com", password: "password"
      @guidance2 = create :guidance, email: "shdfgdgfisf@gmail.com", password: "password"

      @guidance.students << stud1
      @guidance.students << stud3
      @guidance2.students << stud2
  


      @login_url = '/api/v1/guidance_auth/sign_in'
      @guidance_score_reports_url = '/api/v1/guidance_score_reports'
  
      @guidance_params = {
        email: @guidance.email,
        password: @guidance.password
      }

      @notifications_url = '/api/v1/notifications'

      @notifications_params =  {subscription: {endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PODQmuTBXcF-Y63qOvgeGja", expirationTime:nil ,keys:{p256dh: "BD2G1LyFRbbs-h0IqjfveymT6gvGnj53WgPegl9OUImd46JNsKggeM0IwPDB2X__kWiGrHP9B5I1Lgg07i8ZiKs",auth: "qp9nluZcAppD0LjPVJfSuw"}}}

      post @login_url, params: @guidance_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

      
     
    end


    
    context "when guidance is not authenticated" do
      it "return http status unauthorized" do
        
        post '/api/v1/notifications', params: @notifications_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    subject {  post '/api/v1/notifications', 
      params: @notifications_params,
      headers: @headers
    } 

    context "when new webpush notifications has been created " do 

       it "increment web_push_notification count by 1" do
          expect{subject}.to change{WebPushNotification.count}.by(1)
        end

        it "returns http status created" do
          subject
          expect(response).to have_http_status(:created)
          
        end
        
    end


    context "when webpush notification already exist" do
      subject {  post '/api/v1/notifications', 
        params: {subscription: {endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PODQmuTBXcF-Y63qOvgeGja", expirationTime:nil ,keys:{p256dh: "BD2G1LyFRbbs-h0IqjfveymT6gvGnj53WgPegl9OUImd46JNsKggeM0IwPDB2X__kWiGrHP9B5I1Lgg07i8ZiKs",auth: "qp9nluZcAppD0LjPVJfSuw"}}},
        headers: @headers
      } 

      before do 
        create :web_push_notification, guidance: @guidance, endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PODQmuTBXcF-Y63qOvgeGja", auth_key: "qp9nluZcAppD0LjPVJfSuw", p256dh_key: "BD2G1LyFRbbs-h0IqjfveymT6gvGnj53WgPegl9OUImd46JNsKggeM0IwPDB2X__kWiGrHP9B5I1Lgg07i8ZiKs"
      end
      it "do not increment webpushnotification count" do
        expect{subject}.to_not change{WebPushNotification.count}
      end

      it "https status to be no content" do
        subject
        expect(response).to have_http_status(:no_content)
      end
      
      
    end
    

     
  end

end
