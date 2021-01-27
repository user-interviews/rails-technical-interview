# frozen_string_literal: true

class Participant < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email, :password
  validates :email, format: /.*@.*/, uniqueness: :case_insensitive
  validates :password, length: { in: 6..128 }

  has_many :project_participants, dependent: :nullify
  has_many :projects, through: :project_participants

  def full_name
    first_name + " " + last_name
  end

  def email=(email)
    update_attribute(:email, email&.downcase&.strip)
  end
end
