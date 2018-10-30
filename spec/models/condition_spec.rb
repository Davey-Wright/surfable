require 'rails_helper'

RSpec.describe Condition::Condition, type: :model do
  let(:surf_session) { FactoryBot.create(:surf_session) }
  subject {
    described_class.new(surf_session: surf_session)
  }

  describe 'Associations' do
    it { is_expected.to belong_to(:surf_session) }
    it { is_expected.to have_one(:swell).dependent(:destroy) }
    it { is_expected.to have_one(:tide).dependent(:destroy) }
    it { is_expected.to have_one(:wind).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:swell) }
    it { is_expected.to accept_nested_attributes_for(:tide) }
    it { is_expected.to accept_nested_attributes_for(:wind) }
  end

  describe 'Validations' do
    it { is_expected.to be_valid }
  end
end
