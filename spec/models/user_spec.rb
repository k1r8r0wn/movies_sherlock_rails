require 'rails_helper'

describe User do
  let(:valid_attributes) {
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@doe.com',
      password: '12345',
      password_confirmation: '12345'
    }
  }

  context 'relationships' do
    it { should have_many(:movies) }
  end

  context 'validations' do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it 'requires an email' do
      expect(user).to validate_presence_of(:email)
    end

    it 'requires a unique email' do
      expect(user).to validate_uniqueness_of(:email)
    end

    it 'requires a unique email (case insensitive)' do
      user.email = 'JOHN@DOE.COM'
      expect(user).to validate_uniqueness_of(:email)
    end

    it 'requires the email to look like an email' do
      user.email = 'john'
      expect(user).to_not be_valid
    end
  end

  context '#downcase_email' do
    it 'makes the email attribute lower case' do
      user = User.new(valid_attributes.merge(email: 'JOHN@DOE.COM'))
      expect { user.downcase_email }.to change{ user.email }.
        from('JOHN@DOE.COM').
        to('john@doe.com')
    end

    it 'downcases an email before saving' do
      user = User.new(valid_attributes)
      user.email = 'JOHN@DOE.COM'
      expect(user.save).to be_truthy
      expect(user.email).to eq('john@doe.com')
    end
  end

  describe '#generate_password_reset_token!' do
    let(:user) { create(:user) }

    it 'changes the password_reset_token attribute' do
      expect{ user.generate_password_reset_token! }.to change{ user.password_reset_token }
    end

    it 'calls SecureRandom.urlsafe_base64 to generate the password_reset_token' do
      expect(SecureRandom).to receive(:urlsafe_base64)
      user.generate_password_reset_token!
    end
  end
end
