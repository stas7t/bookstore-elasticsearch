require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  it 'assign @review' do
    @book = FactoryGirl.create(:book)
    post :create, params: {book_id: @book.id, review: { rating: 5, title: 'Title', text: 'Text' } }
    expect(assigns(:review)).not_to be_nil
  end

  context 'with valid review' do
    before do
      @book = FactoryGirl.create(:book)
      allow_any_instance_of(Review).to receive(:save).and_return true
      post :create, params: {book_id: @book.id, review: { rating: 5, title: 'Title', text: 'Text' } }
    end

    it 'sends success flash' do
      expect(flash[:success]).to eq 'Thanks for Review. It will be published as soon as Admin will approve it.'
    end
  end

  context 'with invalid save' do
    before do
      @book = FactoryGirl.create(:book)
      allow_any_instance_of(Review).to receive(:save).and_return false
      post :create, params: {book_id: @book.id, review: { rating: 5, title: 'Title', text: 'Text' } }
    end

    it 'sends error flash' do
      expect(flash[:danger]).not_to be_nil
    end
  end
end
