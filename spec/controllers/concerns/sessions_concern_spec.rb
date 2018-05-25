# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsConcern, type: :controller do
  controller(ApplicationController) do
    include SessionsConcern
  end

  let(:user) { FactoryBot.create(:user) }

  describe 'sign in' do
    it 'creates a remember token' do
      expect(UserRememberToken.count).to eql(0)
      controller.sign_in(user)
      expect(UserRememberToken.count).to eql(1)
      expect(UserRememberToken.last.user_id).to eql(user.id)
    end

    it 'sets the current user' do
      controller.sign_in(user)
      expect(controller.signed_in?).to be(true)
      expect(controller.current_user).to eql(user)
      expect(controller.current_user?(user)).to be(true)
    end

    it 'can get the current user from the database' do
      expect(UserRememberToken).to receive(:find_valid_token).once.and_call_original

      controller.sign_in(user)

      controller.current_user = nil # Reset the cache

      expect(controller.current_user).to eql(user)
    end
  end

  describe 'sign out' do
    it 'destroys a remember token' do
      controller.sign_in(user)
      expect(UserRememberToken.count).to eql(1)
      controller.sign_out
      expect(UserRememberToken.count).to eql(0)
    end

    it 'clears out the current user' do
      controller.sign_in(user)
      expect(controller.current_user).not_to be(nil)
      controller.sign_out
      expect(controller.current_user).to be(nil)
    end
  end
end
