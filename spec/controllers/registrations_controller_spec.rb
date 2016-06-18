require 'rails_helper'

describe RegistrationsController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe 'POST #update' do
    context 'avatar' do

      it 'should be uploaded' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        put :update, { user: { avatar: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'files', 'default_avatar.png'), 'image/png'), current_password: '12345678' }}
        expect(user.reload.avatar.file.identifier).not_to be_nil
      end
    end
  end
end
