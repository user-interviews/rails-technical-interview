# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRememberToken, type: :model do
  describe 'validation' do
    let(:user_remember_token) { FactoryBot.build(:user_remember_token) }

    it 'saves by default' do
      expect(user_remember_token.save).to be(true)
    end

    it 'requires a user' do
      user_remember_token.user = nil
      expect(user_remember_token.save).to be(false)
      expect(user_remember_token.errors[:user]).to include('can\'t be blank')
    end

    it 'requires a token digest' do
      user_remember_token.token_digest = nil
      expect(user_remember_token.save).to be(false)
      expect(user_remember_token.errors[:token_digest]).to include('can\'t be blank')
    end

    it 'requires a last used at' do
      user_remember_token.last_used_at = nil
      expect(user_remember_token.save).to be(false)
      expect(user_remember_token.errors[:last_used_at]).to include('can\'t be blank')
    end
  end

  describe 'find valid token' do
    let(:user) { FactoryBot.create(:user) }

    it 'finds the correct token' do
      token = UserRememberToken.create_token_for_user!(user)
      expect(UserRememberToken.find_valid_token(user.id, token)).not_to be(nil)
    end

    it 'returns nil if the user id is wrong' do
      token = UserRememberToken.create_token_for_user!(user)
      expect(UserRememberToken.find_valid_token(user.id + 1, token)).to be(nil)
    end

    it 'returns nil if the token is wrong' do
      token = UserRememberToken.create_token_for_user!(user)
      expect(UserRememberToken.find_valid_token(user.id, "not#{token}")).to be(nil)
    end

    it 'returns nil if the token is out of date' do
      token = UserRememberToken.create_token_for_user!(user)
      UserRememberToken.last.update_attributes!(last_used_at: Time.zone.now - 60.days)
      expect(UserRememberToken.find_valid_token(user.id, token)).to be(nil)
    end
  end
end
