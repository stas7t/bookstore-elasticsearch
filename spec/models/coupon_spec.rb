require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { expect(subject).to validate_presence_of :code }
  it { expect(subject).to validate_presence_of :discoumt }
  it { expect(subject).to validate_uniqueness_of :code }
  it { expect(subject).to validate_numericality_of :discoumt  }
  
  it { expect(subject).to belong_to :order }
end
