require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

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
      follow_redirect!
    end
    assert_template 'users/show'
  end

end
