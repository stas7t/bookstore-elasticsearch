require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }
  before { sign_in(user) }

  describe 'POST #create' do
    let(:create_params) { { order_item: { book_id: book.id, quantity: 1 } } }
    before { post :create, xhr: true, params: create_params }

    it 'assign @order_item' do
      expect(assigns(:order_item)).not_to be_nil
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT #update' do
    before do
      @order_item = FactoryGirl.create(:order_item)
      session[:order_item_ids] = [@order_item.id]
      put :update, xhr: true, params: { id: @order_item.id, order_item: { quantity: 2 } }
    end

    it 'assign @order_items' do
      expect(assigns(:order_items)).not_to be_nil
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      @order_item = FactoryGirl.create(:order_item)
      session[:order_item_ids] = [@order_item.id]
      delete :destroy, xhr: true, params: { id: @order_item.id }
      expect(response.status).to eq(200)
    end
  end
end
