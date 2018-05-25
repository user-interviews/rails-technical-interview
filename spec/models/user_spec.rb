# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { FactoryBot.build(:user) }

    it 'saves by default' do
      expect(user.save).to be(true)
    end

    it 'requires an email' do
      user.email = nil
      expect(user.save).to be(false)
      expect(user.errors[:email]).to include('can\'t be blank')
    end

    it 'requires a valid email' do
      user.email = 'invalidemail'
      expect(user.save).to be(false)
      expect(user.errors[:email]).to include('is invalid')
    end

    it 'requires a unique email' do
      user.save!
      other_user = FactoryBot.build(:user, email: user.email)
      expect(other_user.save).to be(false)
      expect(other_user.errors[:email]).to include('has already been taken')
    end

    it 'requires a password' do
      user.password = nil
      expect(user.save).to be(false)
      expect(user.errors[:password]).to include('can\'t be blank')
    end

    it 'requires a first name' do
      user.first_name = nil
      expect(user.save).to be(false)
      expect(user.errors[:first_name]).to include('can\'t be blank')
    end

    it 'requires a last name' do
      user.last_name = nil
      expect(user.save).to be(false)
      expect(user.errors[:last_name]).to include('can\'t be blank')
    end
  end

  describe 'projects' do
    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project, user: user) }

    it 'does not destroy a project if the user record is destroyed' do
      project

      user.destroy
      expect { project.reload }.not_to raise_error
      expect(project.id).not_to be(nil)
    end
  end

  describe 'user remember tokens' do
    it 'destroys all user tokens on delete' do
      user = FactoryBot.create(:user)
      remember_token = FactoryBot.create(:user_remember_token, user: user)

      user.destroy
      expect { remember_token.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
