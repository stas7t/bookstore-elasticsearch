RSpec.shared_examples 'address_validations' do
  it { expect(subject).to belong_to :user }
  it { expect(subject).to validate_presence_of(:first_name) }
  it { expect(subject).to validate_presence_of(:last_name) }
  it { expect(subject).to validate_presence_of(:address) }
  it { expect(subject).to validate_presence_of(:city) }
  it { expect(subject).to validate_presence_of(:zip) }
  it { expect(subject).to validate_presence_of(:country) }
  it { expect(subject).to validate_presence_of(:phone) }
  it { expect(subject).to validate_length_of(:first_name).is_at_most(50) }
  it { expect(subject).to validate_length_of(:last_name).is_at_most(50) }
  it { expect(subject).to validate_length_of(:address).is_at_most(50) }
  it { expect(subject).to validate_length_of(:city).is_at_most(50) }
  it { expect(subject).to validate_length_of(:country).is_at_most(50) }
  it { expect(subject).to validate_length_of(:phone).is_at_most(15) }

  it { expect(subject).to allow_value('John').for(:first_name) }
  it { expect(subject).to allow_value('Snow').for(:last_name) }
  it { expect(subject).to allow_value('Winteffell').for(:city) }
  it { expect(subject).to allow_value('North street, 7').for(:address) }
  it { expect(subject).not_to allow_value('!@#$%^&*_+').for(:first_name) }
  it { expect(subject).not_to allow_value('!@#$%^&*_+').for(:last_name) }
  it { expect(subject).not_to allow_value('!@#$%^&*_+').for(:city) }
  it { expect(subject).not_to allow_value('SDad!---&str@').for(:address) }
end
