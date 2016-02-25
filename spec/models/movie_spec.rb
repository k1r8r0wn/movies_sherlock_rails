require 'rails_helper'

describe Movie do
  context 'relationships' do
    it { should belong_to(:user) }
  end
end