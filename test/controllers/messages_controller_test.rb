# frozen_string_literal: true

require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    host! 'andrewsapp.local'

    user1 = users(:one)
    user1.confirm
    user2 = users(:two)
    sender = users(:sender)
    @message1 = Message.create!(sender: sender, recipient: user1, subject: 'hello', body: 'message')
    @message2 = Message.create!(sender: sender, recipient: user2, subject: 'private', body: 'message')
    @message3 = Message.create!(sender: user1, recipient: user2, subject: 'sent', body: 'sent')
    @message4 = Message.create!(sender: user2, recipient: sender, subject: 'abc', body: 'def')

    sign_in user1
  end

  test 'received messages scoped to current user' do
    get '/messages'
    assert_select('p', 'hello', 'message to this user should be displayed')
    assert_select('p', { text: 'private', count: 0 }, 'message to other user should not be displayed')
  end

  test 'sent messages scoped to current user' do
    get '/messages'
    assert_select('p', 'sent', 'message from this user should be displayed')
    assert_select('p', { text: 'abc', count: 0 }, 'message from other user should not be displayed')
  end
end
