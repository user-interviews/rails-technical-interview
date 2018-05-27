# frozen_string_literal: true

class ProjectAccess < ActiveRecord::Base
  belongs_to :project, required: true
  belongs_to :user, required: true
end
