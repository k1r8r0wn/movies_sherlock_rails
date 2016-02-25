require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get 'new'
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with correct credentials' do
      let!(:user) {
        User.create(
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@doe.com',
          password: '12345',
          password_confirmation: '12345'
        )
      }

      it 'redirects to the users profile' do
        post :create, email: 'john@doe.com', password: '12345'
        expect(response).to be_redirect
        expect(response).to redirect_to(user_path(:id))
      end

      it 'finds the user' do
        expect(User).to receive(:find_by).with({email: 'john@doe.com'}).and_return(user)
        post :create, email: 'john@doe.com', password: '12345'
      end

      it 'authenticates the user' do
        allow(User).to receive(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: 'john@doe.com', password: '12345'
      end
    end
  end
end
