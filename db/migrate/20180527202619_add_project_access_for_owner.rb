# frozen_string_literal: true

class AddProjectAccessForOwner < ActiveRecord::Migration
  def up
    user_map = User.all.index_by(&:id)

    Project.find_each do |p|
      if p.user_id
        p.project_accesses.build(owner: true, user: user_map[p.user_id])
        p.save!
      end
    end
  end

  def down
    ProjectAccess.destroy_all(owner: true)
  end
end
