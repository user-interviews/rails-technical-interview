# frozen_string_literal: true

class AddProjectAccessForOwner < ActiveRecord::Migration
  def up
    Project.all do |p|
      if p.user_id
        p.project_accesses.build(owner: true, user: User.find_by_id(p.user_id))
        p.save!
      end
    end
  end

  def down
    ProjectAccess.destroy_all(owner: true)
  end
end
