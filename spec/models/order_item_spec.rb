require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { expect(subject).to validate_presence_of :quantity }
  it { expect(subject).to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }

  it { expect(subject).to belong_to(:book) }
end
