# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'new' do
    it 'redirects if you are not signed in' do
      get :new
      expect(response).to redirect_to(sign_in_path)
    end

    it 'renders if you are signed in' do
      controller.sign_in(user)
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create' do
    let(:project) { FactoryBot.build(:project) }

    def post_create(params_project: project, project_param_overrides: {})
      post :create, project: {
        compensation_amount: params_project.compensation_amount,
        internal_name: params_project.internal_name,
        interview_type: params_project.interview_type,
        public_title: params_project.public_title,
        requested_participants: params_project.requested_participants,
      }.merge(project_param_overrides)
    end

    it 'redirects if you are not signed in' do
      post_create
      expect(response).to redirect_to(sign_in_path)
    end

    it 'creates a new project associated with a signed in user' do
      controller.sign_in(user)
      post_create

      new_project = Project.last
      expect(response).to redirect_to(project_path(new_project))
      expect(new_project.owner).to eql(user)
    end

    it 'renders new if there were errors on the project' do
      controller.sign_in(user)
      post_create(project_param_overrides: { internal_name: nil })
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'show' do
    let(:project) { FactoryBot.create(:project) }

    def view_show(params_project = project)
      get :show, id: params_project.id
    end

    def expect_redirect
      expect(response).to redirect_to(root_path)
    end

    def expect_render(view_project = project)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(assigns[:project]).to eql(view_project)
    end

    it 'redirects if you are not signed in' do
      view_show
      expect_redirect
    end

    it 'redirects if you are signed in as a different user' do
      other_user = FactoryBot.create(:user)
      controller.sign_in(other_user)

      view_show
      expect_redirect
    end

    it 'renders the page if you are signed in as the owner' do
      controller.sign_in(project.owner)

      view_show
      expect_render
    end
  end
end
