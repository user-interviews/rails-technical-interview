# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validation' do
    let(:project) { FactoryBot.build(:project) }

    it 'saves by default' do
      expect(project.save).to be(true)
    end

    it 'requires a compensation amount' do
      project.compensation_amount = nil
      expect(project.save).to be(false)
      expect(project.errors[:compensation_amount]).to include('can\'t be blank')
    end

    it 'requires an internal name' do
      project.internal_name = nil
      expect(project.save).to be(false)
      expect(project.errors[:internal_name]).to include('can\'t be blank')
    end

    it 'requires an interview type' do
      project.interview_type = nil
      expect(project.save).to be(false)
      expect(project.errors[:interview_type]).to include('can\'t be blank')
    end

    it 'requires a public title' do
      project.public_title = nil
      expect(project.save).to be(false)
      expect(project.errors[:public_title]).to include('can\'t be blank')
    end

    it 'requires requested participants' do
      project.requested_participants = nil
      expect(project.save).to be(false)
      expect(project.errors[:requested_participants]).to include('can\'t be blank')
    end
  end

  describe 'charged' do
    it 'properly tracks when a project is charged' do
      project = FactoryBot.create(:project, :charged)
      expect(project.charged?).to be(true)
    end

    it 'can be set on the model directly' do
      project = FactoryBot.build(:project)
      project.charged = true
      expect(project.charged_at).not_to be(nil)

      project.charged = false
      expect(project.charged_at).to be(nil)
    end
  end

  describe 'launched' do
    it 'properly tracks when a project is launched' do
      project = FactoryBot.create(:project, :launched)
      expect(project.launched?).to be(true)
    end

    it 'can be set on the model directly' do
      project = FactoryBot.build(:project)
      project.launched = true
      expect(project.launched_at).not_to be(nil)

      project.launched = false
      expect(project.launched_at).to be(nil)
    end
  end

  describe 'owner' do
    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project) }

    it 'grabs the current owner of the project' do
      expect(project.owner).to eql(project.project_accesses.where(owner: true).first.user)
    end

    it 'can be used to update the current owner of the project' do
      expect(project.owner).not_to eql(user)
      project.owner = user
      project.save!
      project.reload

      expect(project.owner).to eql(user)
    end

    it 'can clear out the previous owner of a project' do
      expect(project.owner).not_to be(nil)

      project.owner = nil
      project.save!
      project.reload

      expect(project.owner).to be(nil)
      expect(project.project_accesses.where(owner: true)).to be_empty
    end

    it 'can set a owner if there is no current owner' do
      project.owner = nil
      project.reload

      project.owner = user
      project.save!
      project.reload

      expect(project.owner).to eql(user)
    end
  end

  describe 'project accesses' do
    let(:project) { FactoryBot.build(:project) }

    it 'has an owner when built by the factory' do
      expect(project.project_accesses.size).to eql(1)
      expect(project.project_accesses.first.owner).to be(true)
    end

    it 'destroys existing project accesses upon destruction' do
      project.save!
      project_access = project.project_accesses.first

      project.destroy
      expect { project_access.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
