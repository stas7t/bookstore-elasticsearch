require 'rails_helper'

RSpec.describe Author, type: :model do
  before :each { @author = FactoryGirl.create(:author) }

  subject { @author }

  it { expect(subject).to validate_presence_of :first_name }
  it { expect(subject).to validate_length_of :first_name }
  it { expect(subject).to validate_length_of :last_name }

  it { expect(subject).to have_and_belong_to_many(:books) }
end
