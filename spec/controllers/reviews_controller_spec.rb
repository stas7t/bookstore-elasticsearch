require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review_params) { FactoryGirl.build(:review).attributes }
  let(:book_id) { review_params['book_id'] }
  # let(:book) { FactoryGirl.create(:book) }
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  context 'with valid save' do
    before do
      @book = FactoryGirl.create(:book)
      allow_any_instance_of(Review).to receive(:save).and_return true
      post :create, book_id: @book.id, params: { review: review_params }
    end

    xit 'sends success flash' do

      expect(flash[:success]).to eq 'Thanks for Review. It will be published as soon as Admin will approve it.'
    end
  end

  context 'with invalid save' do
    before do
      allow_any_instance_of(Review).to receive(:save).and_return false
    end

    xit 'sends error flash' do

      expect(flash[:danger]).not_to be_nil
    end
  end
end
