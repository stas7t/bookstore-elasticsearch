require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review_params) { FactoryGirl.attributes_for(:review).stringify_keys }
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:book) { FactoryGirl.build(:book) }
  let(:review) { FactoryGirl.build(:review) }

  describe 'GET #show' do
    before do
      book.category_id = category.id
      book.save
      review.user_id = user.id
      review.book_id = book.id
      review.save
      allow(Review).to receive(:find).and_return review
    end

    it 'receives find and return review' do
      expect(Review).to receive(:find).with(review.id.to_s)
      get :show, params: { id: review.id }
    end

    it 'assigns @review' do
      get :show, params: { id: review.id }
      expect(assigns(:review)).not_to be_nil
    end

    it 'renders :show template' do
      get :show, params: { id: review.id }
      expect(response).to render_template :show
    end
  end
end
