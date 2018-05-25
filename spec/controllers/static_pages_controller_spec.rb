require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#root' do
    it 'renders' do
      get :root
      expect(response).to have_http_status(:success)
    end
  end
end
