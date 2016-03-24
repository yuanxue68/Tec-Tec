require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe "associations" do 
    it { is_expected.to belong_to(:sender) }
    it { is_expected.to belong_to(:recipient) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:sender_id) }
    it { is_expected.to validate_presence_of(:recipient_id) }
  end
end
