# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  subject :pokemon do
    create(:pokemon)
  end

  it 'has a valid factory' do
    expect(build(:pokemon)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:base_experience) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:order) }
    it { is_expected.to validate_presence_of(:types) }
    it { is_expected.to validate_presence_of(:weight) }

    it { is_expected.to validate_uniqueness_of(:name) }

    it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:base_experience).is_greater_than(0) }
  end
end
