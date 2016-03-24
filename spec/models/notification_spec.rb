require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:notified_by)}
    it { is_expected.to belong_to(:user)}
    it { is_expected.to belong_to(:auction)}
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:notice_type) }
  end
end
