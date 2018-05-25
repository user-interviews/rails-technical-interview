# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :email, :first_name, :last_name
  validates :email, format: Emails::EMAIL_FORMAT_REGEX, uniqueness: true

  has_many :projects, dependent: :nullify
  has_many :user_remember_tokens, dependent: :destroy
end
