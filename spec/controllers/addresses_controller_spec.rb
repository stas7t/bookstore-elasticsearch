require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  describe 'GET #index' do
    before { get :index }

    it 'return a success response' do
      expect(response.status).to eq(200)
      expect(response).to render_template :index
    end

    it 'assign @addresses' do
      expect(assigns(:addresses)).not_to be_nil
    end
  end

  describe 'POST #create' do
    let(:address) { FactoryGirl.attributes_for(:address) }
    let(:addresses_aprams) { { billing: address, shipping: address } }
    before { post :create, params: { addresses_form: addresses_aprams } }

    it 'assign @addresses' do
      expect(assigns(:addresses)).not_to be_nil
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end

    it 'render index' do
      expect(response).to render_template :index
    end
  end

  describe 'PATCH #update' do
    let(:address) { FactoryGirl.attributes_for(:address) }
    let(:addresses_aprams) { { billing: address, shipping: address } }
    before { patch :update, params: { addresses_form: addresses_aprams } }

    it 'assign @addresses' do
      expect(assigns(:addresses)).not_to be_nil
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end

    it 'render index' do
      expect(response).to render_template :index
    end
  end
end
