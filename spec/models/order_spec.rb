require 'rails_helper'

RSpec.describe Order, type: :model do
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :delivery }
  it { expect(subject).to belong_to :credit_card }
  it { expect(subject).to belong_to :coupon }

  it { expect(subject).to have_many :order_items }

  it { expect(subject).to have_many :addresses }
  it { expect(subject).to have_one :billing }
  it { expect(subject).to have_one :shipping }

  describe 'callbacks' do
    before :each { @order = FactoryGirl.create(:order) }
    subject { @order }

    it 'set order status before create' do
      expect(subject.status).to eq 'in_progress'
    end

    it 'set order number before create' do
      expect(subject.number).to eq "R#{subject.id.to_s.rjust(8, '0')}"
    end
  end
end
