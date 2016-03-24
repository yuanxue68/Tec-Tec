require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "associatons" do
    it { is_expected.to belong_to(:conversation) }
    it { is_expected.to belong_to(:user) } 
  end
  
  describe "validations" do
    it { is_expected.to validate_presence_of(:conversation_id) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:user_id)}
  end
end
