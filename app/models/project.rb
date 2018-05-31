# frozen_string_literal: true

class Project < ActiveRecord::Base
  validates_presence_of(
    :compensation_amount,
    :internal_name,
    :interview_type,
    :public_title,
    :requested_participants,
  )

  has_many :project_accesses, dependent: :nullify
  has_many :users, through: :project_accesses

  enum interview_type: {
    in_person: 1,
    remote: 2,
  }

  scope :for_account, ->(user_id) do
    joins('JOINS project_accesses ON user_id = user_id')
  end

  def charged=(toggle)
    self.charged_at = toggle ? Time.zone.now : nil
  end

  def charged?
    charged_at.present?
  end

  def launched=(toggle)
    self.launched_at = toggle ? Time.zone.now : nil
  end

  def launched?
    launched_at.present?
  end

  def owner
    project_accesses.owners.first&.user
  end

  def owner=(new_owner)
    project_accesses.where(owner: true).destroy_all
    project_accesses.build(owner: true, user: new_owner) if new_owner
  end

  def owner?(user)
    project_accesses.where(owner: true).detect { |a| a.user_id == user.id }.present?
  end
end
