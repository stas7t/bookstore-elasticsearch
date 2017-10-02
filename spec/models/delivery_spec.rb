require 'rails_helper'

RSpec.describe Delivery, type: :model do
  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_presence_of :time }
  it { expect(subject).to validate_presence_of :price }

  it { expect(subject).to have_many :orders }
  it { expect(subject).to validate_uniqueness_of(:name) }
  it { expect(subject).to validate_numericality_of(:price) }
  it { expect(subject).to validate_length_of(:name).is_at_most(50) }
end
