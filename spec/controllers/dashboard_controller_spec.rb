require 'rails_helper'

describe DashboardController, type: :controller do
  let(:user) { create(:user, role: 'admin') }
  let!(:movie) { create(:movie, users: [user]) }

  describe 'GET #index' do
    context 'when authorized & user is admin' do
      before(:each) do
        sign_in user
        @dashboard = DashboardFacade.new
      end

      it 'renders the page' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'counts all users' do
        expect(@dashboard.count_all_users).to eq(1)
      end

      it 'counts all movies' do
        expect(@dashboard.count_all_movies).to eq(1)
      end
    end

    context 'when authorized & user is not admin' do
      before(:each) do
        user = create(:user, role: 'user')
        sign_in user
        get :index
      end

      it 'renders the page and redirects' do
        expect(response.status).not_to eq(200)
      end

      it 'shows flash[:error] message' do
        expect(flash[:error]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'when not authorized' do
      before(:each) do
        get :index
      end

      it 'renders the page and redirects' do
        expect(response.status).not_to eq(200)
      end

      it 'shows flash[:error] message' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

  end
end
