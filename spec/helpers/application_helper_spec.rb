require "rails_helper"
require "spec_helper"
require 'byebug'

RSpec.describe ApplicationHelper, type: :helper do
  it "should return active" do
    controller.params[:action] = 'show'
    controller.params[:controller] = 'auctions'
    expect(helper.is_active?('auctions', :action, "show")).to eq("active")
  end
end

