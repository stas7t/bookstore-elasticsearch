require 'rails_helper'

RSpec.describe Book, type: :model do

  before :each { @book = FactoryGirl.create(:book) }

  subject { @book }

  it { expect(subject).to validate_presence_of :title }
  it { expect(subject).to validate_presence_of :quantity }
  it { expect(subject).to validate_presence_of :price }
  it { expect(subject).to validate_uniqueness_of :title }

  it { expect(subject).to have_and_belong_to_many(:authors) }
  it { expect(subject).to have_and_belong_to_many(:categories) }
  it { expect(subject).to have_many(:reviews) }
end
