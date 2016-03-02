require "rails_helper"
require "spec_helper"
require 'byebug'

RSpec.describe ApplicationHelper, type: :helper do
  it "should return active" do
    controller.params[:action] = 'show'
    expect(helper.is_active?("show")).to eq("active")
  end
end

