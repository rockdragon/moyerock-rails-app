require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  setup do
    ActionMailer::Base.deliveries.clear
  end

  test 'invalid user information should not get by singup' do
    assert_no_difference 'User.count' do
      post users_path, params: {
          user: {name: '',
                 email: 'user@invalid',
                 password: 'foo',
                 password_confirmation: 'bar'}
      }
    end
  end

  test 'valid user information should get by singup' do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: {
          user: {name: 'mr.horrible',
                 email: 'trash@valid.com',
                 password: '123456',
                 password_confirmation: '123456'}
      }
    end

    assert_equal 1, ActionMailer::Base.deliveries.size

    user = assigns(:user)
    assert_not user.activated?

    log_in_as(user)
    assert_not is_logged_in?

    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?

    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    #assert_template 'user_mailer/account_activation'
  end

end
