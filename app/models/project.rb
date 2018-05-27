# frozen_string_literal: true

class Project < ActiveRecord::Base
  validates_presence_of(
    :compensation_amount,
    :internal_name,
    :interview_type,
    :public_title,
    :requested_participants,
  )
  validates_presence_of :user, on: :create

  belongs_to :user, required: false

  has_many :project_accesses, dependent: :destroy

  enum interview_type: {
    in_person: 1,
    remote: 2,
  }

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
end
