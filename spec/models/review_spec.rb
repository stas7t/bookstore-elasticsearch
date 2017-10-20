require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:review) { create(:review, user_id: user.id, book_id: book.id) }

  it { expect(subject).to validate_presence_of :title }
  it { expect(subject).to validate_presence_of :rating }
  it { expect(subject).to validate_presence_of :text }
  it { expect(subject).to validate_length_of :title }
  it { expect(subject).to validate_length_of :text }

  it { expect(subject).to belong_to(:book) }
  it { expect(subject).to belong_to(:user) }
end
