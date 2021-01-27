# frozen_string_literal: true

class ProjectParticipant < ActiveRecord::Base
  belongs_to :project
  belongs_to :participant

  scope :approved, -> { where.not(approved_at: nil) }

  def approved
    approved?
  end

  def approved?
    approved_at.present?
  end

  def approved=(is_approved)
    update_attributes!(approved_at: is_approved ? Time.now : nil)
  end
end
