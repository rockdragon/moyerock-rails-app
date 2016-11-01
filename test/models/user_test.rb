require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @admin = User.new(name: 'Example User', email: 'user@example.com',
                      password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @admin.valid?
  end

  test 'name should be present' do
    @admin.name = ''
    assert_not @admin.valid?
  end

  test 'email should be present' do
    @admin.email = '     '
    assert_not @admin.valid?
  end

  test 'name should not be too long' do
    @admin.name = 'a' * 51
    assert_not @admin.valid?
  end

  test 'email should not be too long' do
    @admin.email = 'a' * 244 + '@example.com'
    assert_not @admin.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_email|
      @admin.email = invalid_email
      assert_not @admin.valid?, "#{invalid_email} should be invalid."
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @admin.dup
    duplicate_user.email = @admin.email.upcase
    @admin.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (nonblank)' do
    @admin.password = @admin.password_confirmation = ' ' * 6
    assert_not @admin.valid?
  end

  test 'password should be have a minimum length' do
    @admin.password = @admin.password_confirmation = 'a' * 5
    assert_not @admin.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @admin.authenticated?(:remember, '')
  end
end