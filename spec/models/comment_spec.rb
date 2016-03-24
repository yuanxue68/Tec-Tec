require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :auction }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :auction }
    it { is_expected.to validate_presence_of :user }
  end
end
