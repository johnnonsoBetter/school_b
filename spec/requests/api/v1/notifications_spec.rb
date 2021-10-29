require 'rails_helper'



RSpec.describe "Api::V1::Notifications", type: :request do
  describe "POST" do
    @notifications_url = 'api/v1/notifications'

    @notifications_params =  {endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PODQmuTBXcF-Y63qOvgeGja", expirationTime:nil ,keys:{p256dh: "BD2G1LyFRbbs-h0IqjfveymT6gvGnj53WgPegl9OUImd46JNsKggeM0IwPDB2X__kWiGrHP9B5I1Lgg07i8ZiKs",auth: "qp9nluZcAppD0LjPVJfSuw"}}


    

    subject {  post '/api/v1/notifications', params: {endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PODQmuTBXcF-Y63qOvgeGja", expirationTime:nil ,keys:{p256dh: "BD2G1LyFRbbs-h0IqjfveymT6gvGnj53WgPegl9OUImd46JNsKggeM0IwPDB2X__kWiGrHP9B5I1Lgg07i8ZiKs",auth: "qp9nluZcAppD0LjPVJfSuw"}}} 

    context "when new webpush notifications has been created " do 

       it "increment web_push_notification by 1" do
          expect{subject}.to change{WebPushNotification.count}.by(1)
        end

    end

     
  end

end
