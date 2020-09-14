# frozen_string_literal: true

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = Message.new(subject: 'hello', body: 'world')
  end

  test 'invalid without subject' do
    @message.subject = ' '
    assert_not(@message.valid?, 'message must have subject')
  end

  test 'invalid without body' do
    @message.body = ' '
    assert_not(@message.valid?, 'message must have body')
  end

  test 'valid with both' do
    assert(@message.valid?, 'message is valid with subject and body')
  end
end
