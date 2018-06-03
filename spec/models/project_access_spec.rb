# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectAccess, type: :model do
  describe 'validation' do
    let(:project_access) { FactoryBot.build(:project_access) }

    it 'saves by default' do
      expect(project_access.save).to be(true)
    end

    it 'requires a project' do
      project_access.project = nil
      expect(project_access.save).to be(false)
      expect(project_access.errors[:project]).to include('can\'t be blank')
    end

    it 'requires a user' do
      project_access.user = nil
      expect(project_access.save).to be(false)
      expect(project_access.errors[:user]).to include('can\'t be blank')
    end
  end
end
