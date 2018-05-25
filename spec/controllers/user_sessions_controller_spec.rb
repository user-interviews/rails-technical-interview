# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  describe 'new' do
    it 'renders a page' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create' do
    let(:user) { FactoryBot.create(:user) }

    def post_create(param_overrides = {})
      post :create, { email: user.email, password: user.password }.merge(param_overrides)
    end

    it 'signs in a user' do
      expect(UserRememberToken.where(user_id: user.id).count).to eql(0)

      post_create
      expect(response).to redirect_to(user_path(user))
      expect(UserRememberToken.where(user_id: user.id).count).to eql(1)
    end
  end
end
