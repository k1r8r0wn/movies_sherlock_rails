require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    context 'authorized user' do
      before(:each) do
        sign_in user
      end

      it 'renders the page' do
        get :show, { id: user.id }
        expect(response.status).to eq(200)
      end
    end

    context 'not authorized user' do
      it 'renders the page and redirects' do
        get :show, { id: user.id }
        expect(response.status).not_to eq(200)
      end

      it 'shows flash[:error] message' do
        get :show, { id: user.id }
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end
end
