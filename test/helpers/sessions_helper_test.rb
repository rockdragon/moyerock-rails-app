require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  setup do
    @admin = users(:michael)
    remember(@admin)
  end

  test 'current_user returns right user when session is nil' do
    assert_equal @admin, current_user
    assert is_logged_in?
  end

  test 'current_user returns nil when remember digest is wrong' do
    @admin.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end