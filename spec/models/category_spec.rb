require 'rails_helper'

RSpec.describe Category, type: :model do
  before :each { @category = FactoryGirl.create(:category) }

  subject { @category }

  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_uniqueness_of :name }
  it { expect(subject).to validate_length_of :name }

  it { expect(subject).to have_and_belong_to_many(:books) }
end
