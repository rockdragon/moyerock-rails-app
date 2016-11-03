require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  setup do
    @user = users(:michael)
    @micropost = Micropost.new(content: 'holy crap', user_id: @user.id)
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user id should be present' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
end
