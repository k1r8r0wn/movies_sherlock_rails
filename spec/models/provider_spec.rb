require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:valid_attributes) {
    {
      name: 'Provider',
      uid: '123456789',
    }
  }

  context 'relationships' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    let(:provider) { Provider.new(valid_attributes) }

    before do
      Provider.create(valid_attributes)
    end

    it 'requires a name' do
      expect(provider).to validate_presence_of(:name)
    end

    it 'requires a uid' do
      expect(provider).to validate_presence_of(:uid)
    end
  end
end
