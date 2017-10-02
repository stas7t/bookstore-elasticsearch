require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it { expect(subject).to validate_presence_of :number }
  it { expect(subject).to validate_presence_of :name_on_card }
  it { expect(subject).to validate_presence_of :month_year }
  it { expect(subject).to validate_presence_of :cvv }

  it { expect(subject).to have_many :orders }

  it { expect(subject).to validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
  it { expect(subject).to validate_length_of(:name_on_card).is_at_most(50) }

  it { expect(subject).to validate_numericality_of(:cvv) }
  it { expect(subject).to allow_value('05/18').for(:month_year) }
  it { expect(subject).to allow_value('12/24').for(:month_year) }
  it { expect(subject).not_to allow_value('00/18').for(:month_year) }
  it { expect(subject).not_to allow_value('13/18').for(:month_year) }
  it { expect(subject).not_to allow_value('/18').for(:month_year) }
  it { expect(subject).not_to allow_value('13/').for(:month_year) }
  it { expect(subject).not_to allow_value('xx/yy').for(:month_year) }
  it { expect(subject).to allow_value('1111222233334444').for(:number) }
  it { expect(subject).to allow_value('1234567887654321').for(:number) }
  it { expect(subject).not_to allow_value('x' * 16).for(:number) }
  it { expect(subject).not_to allow_value('12345678').for(:number) }
  it { expect(subject).not_to allow_value('xx123xxx').for(:number) }
  it { expect(subject).to allow_value('John Snow').for(:name_on_card) }
  it { expect(subject).not_to allow_value(' ').for(:name_on_card) }
  it { expect(subject).not_to allow_value('!@#$%^&*_+').for(:name_on_card) }
end
