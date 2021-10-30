require 'rails_helper'

RSpec.describe WebPushNotification, type: :model do
  it { should validate_presence_of(:p256dh_key) }
  it { should validate_presence_of(:auth_key) }
  it { should validate_presence_of(:endpoint) }
  it { should belong_to(:guidance) } 
end
