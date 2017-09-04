require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review_params) { FactoryGirl.attributes_for(:review).stringify_keys }
  let(:review) { FactoryGirl.build_stubbed(:review) }
  #let(:review) { FactoryGirl.create(:review) }

  describe 'GET #show' do
    before do
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
