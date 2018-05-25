# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'new' do
    it 'renders a page' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'redirects if someone is signed in' do
      user = FactoryBot.create(:user)
      controller.sign_in(user)

      get :new
      expect(response).to redirect_to(user_path(user))
    end
  end

  describe 'create' do
    let(:user) { FactoryBot.build(:user) }

    def post_create(param_user: user, user_param_overrides: {})
      post :create, user: {
        email: param_user.email,
        first_name: param_user.first_name,
        last_name: param_user.last_name,
        password: param_user.password,
        password_confirmation: param_user.password,
      }.merge(user_param_overrides)
    end

    it 'creates a new user' do
      expect(User.count).to eql(0)
      post_create
      expect(response).to redirect_to(user_path(User.last))
    end

    it 'renders new on an error' do
      post_create(user_param_overrides: { email: nil })
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end

    it 'signs in the new user' do
      post_create
      expect(response).to redirect_to(user_path(User.last))
      expect(controller.signed_in?).to be(true)
    end

    it 'redirects if someone is signed in' do
      user.save!
      controller.sign_in(user)

      post_create
      expect(response).to redirect_to(user_path(user))
    end
  end

  describe 'show' do
    let(:user) { FactoryBot.create(:user) }

    it 'renders a page' do
      get :show, id: user.id
      expect(response).to have_http_status(:success)
    end
  end
end
