# frozen_string_literal: true

# a private message between users. subject and body are encrypted in database.
class Message < ApplicationRecord
  encrypts :subject, :body

  belongs_to :sender, class_name: 'User', optional: true # in case user is deleted
  belongs_to :recipient, class_name: 'User', optional: true # in case user is deleted

  validates :subject, :body, presence: true
  validate :check_recipient, on: :create

  private

  def check_recipient
    return if recipient_id

    errors.add :recipient_id, 'is required'
  end
end
