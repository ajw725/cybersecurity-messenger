# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'username should be required' do
    @user.username = ' '
    assert_not(@user.valid?, 'user should be invalid without username')
  end

  test 'email should be required' do
    @user.email = ' '
    assert_not(@user.valid?, 'user should be invalid without email')
  end

  test 'email should have valid format' do
    @user.email = 'bademail'
    assert_not(@user.valid?, 'user email address must have valid format')
  end

  test 'it should be valid with username and email' do
    assert(@user.valid?, 'user should be valid')
  end
end
