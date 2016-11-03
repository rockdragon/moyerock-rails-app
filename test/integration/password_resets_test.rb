require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  setup do
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test "password resets" do

  end
end
