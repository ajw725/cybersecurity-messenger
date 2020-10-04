# frozen_string_literal: true

# a private message between users. subject and body are encrypted in database.
class Message < ApplicationRecord
  class InvalidRecipientError < StandardError; end

  encrypts :subject, :body

  attr_accessor :recipient_username

  belongs_to :sender, class_name: 'User', optional: true # in case user is deleted
  belongs_to :recipient, class_name: 'User', optional: true # in case user is deleted

  validates :subject, :body, presence: true
  validate :check_recipient, on: :create
  validate :self_message
  before_create :set_recipient

  private

  def check_recipient
    return if recipient_id || recipient_username

    errors.add :recipient_id, 'is required'
  end

  def set_recipient
    raise InvalidRecipientError, 'Recipient not found' unless recipient_id || recipient_username

    recip = User.find_by(username: recipient_username)
    raise InvalidRecipientError, 'RecipientNotFound' unless recip

    self.recipient_id = recip.id
  end

  def self_message
    return unless sender && recipient_username && sender.username == recipient_username

    errors.add :base, 'You cannot send messages to yourself.'
  end
end
