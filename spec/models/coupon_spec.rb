require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { expect(subject).to validate_presence_of :code }
  it { expect(subject).to validate_presence_of :discount }
  it { expect(subject).to validate_uniqueness_of :code }
  it { expect(subject).to validate_numericality_of :discount }
end
