# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    host! 'andrewsapp.local'
  end

  test '#index' do
    get '/'
    # i don't know why this is 200 instead of 302
    assert_response :success
    assert_select 'h1', 'Welcome'
  end
end
