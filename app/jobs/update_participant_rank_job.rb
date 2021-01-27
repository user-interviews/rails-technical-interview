# frozen_string_literal: true

class UpdateParticipantRankJob
  def self.perform
    # This method goes through each participant and updates their rank.
    # Participants get 1 point for each project they participated in
    # and 10 points for each unique user that they have applied to a project for.

    Participant.all.each do |p|
      user_ids = []
      p.projects.each do |proj|
        user_ids << proj.user.id
      end

      # Don't update if there are zero things to count
      unless user_ids.size + p.projects.count
        p.assign_attributes(rank: p.projects.count * user_ids.uniq.size)
      end
    end
  end
end
