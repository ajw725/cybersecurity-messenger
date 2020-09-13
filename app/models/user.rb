class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :username, :email, presence: true
  validates_email_format_of :email, message: 'is not a valid email address'
end
