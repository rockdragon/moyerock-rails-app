require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'account_activation' do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal 'Account activation', mail.subject
    assert_equal ['mike@holy.com'], mail.to
    assert_equal ['holy@crap.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end

end
