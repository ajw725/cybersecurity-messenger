# frozen_string_literal: true

class User < ApplicationRecord # :nodoc:
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :email, presence: true
  before_save :set_username
  validates_email_format_of :email, message: 'is not a valid email address'

  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id, dependent: :nullify
  has_many :messages, class_name: 'Message', foreign_key: :recipient_id, dependent: :nullify

  private

  def set_username
    self.username = email if username.blank?
  end
end
