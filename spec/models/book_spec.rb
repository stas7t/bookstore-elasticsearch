require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { FactoryGirl.build(:book) }

  it { expect(subject).to validate_presence_of :title }
  it { expect(subject).to validate_presence_of :price }

  it { expect(subject).to validate_uniqueness_of :title }

  it { expect(subject).to validate_numericality_of(:price) }
  it { expect(subject).to validate_numericality_of(:height) }
  it { expect(subject).to validate_numericality_of(:width) }
  it { expect(subject).to validate_numericality_of(:depth) }

  it { expect(subject).to belong_to(:category) }
  it { expect(subject).to have_many(:authors) }
  it { expect(subject).to have_many(:reviews) }
end
