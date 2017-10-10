require 'rails_helper'

RSpec.describe Admin, type: :model do
  before :each { @admin = FactoryGirl.create(:admin) }

  subject { @admin }

  it { expect(subject).to validate_presence_of :email }
  it { expect(subject).to validate_confirmation_of :password }
  it { expect(subject).to validate_length_of :password }
end
