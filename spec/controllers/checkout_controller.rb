require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  describe 'GET #show' do
    let!(:order) { FactoryGirl.create(:order, :in_progress, :with_order_item, user_id: user.id) }

    describe 'addresses step' do
      before { get :show, params: { id: :addresses } }

      it 'render addresses view' do
        expect(response).to render_template :addresses
      end

      it 'assign @addresses' do
        expect(assigns(:addresses)).not_to be_nil
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end
    end

    describe 'delivery step' do
      before do
        FactoryGirl.create(:address, order_id: order.id)
        get :show, params: { id: :delivery }
      end

      it 'render delivery view' do
        expect(response).to render_template :delivery
      end

      it 'assign @deliveries' do
        expect(assigns(:deliveries)).not_to be_nil
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end
    end

    describe 'payment step' do
      before { get :show, params: { id: :payment } }

      it 'render payment view' do
        expect(response).to render_template :payment
      end

      it 'assign @credit_card' do
        expect(assigns(:credit_card)).not_to be_nil
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end
    end

    describe 'confirm step' do
      let(:credit_card) { FactoryGirl.create(:credit_card) }
      before do
        order.update(credit_card_id: credit_card.id)
        get :show, params: { id: :confirm }
      end

      it 'render confirm view' do
        expect(response).to render_template :confirm
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end
    end

    describe 'complete step' do
      before do
        get :show, params: { id: :complete }
      end

      it 'render complete view' do
        expect(response).to render_template :complete
      end

      it 'assign @order' do
        expect(assigns(:order)).not_to be_nil
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'PUT #update' do
    let!(:order) { FactoryGirl.create(:order, :in_progress, :with_order_item, user_id: user.id) }

    describe 'addresses' do
      before do
        allow(AddressesForm).to receive(:new) { FactoryGirl.build(:address) }
        put :update, params: { id: :addresses, addresses_form: true }
      end

      it 'assign @addresses' do
        expect(assigns(:addresses)).not_to be_nil
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end
    end

    describe 'delivery' do
      before do
        delivery = FactoryGirl.create(:delivery)
        put :update, params: { id: :delivery, order: { delivery_id: delivery.id } }
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end
    end

    describe 'payment' do
      before do
        credit_card_attributes = FactoryGirl.attributes_for(:credit_card)
        put :update, params: { id: :payment, credit_card: credit_card_attributes }
      end

      it 'assign @credit_card' do
        expect(assigns(:credit_card)).not_to be_nil
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end
    end

    describe 'confirm' do
      before do
        put :update, params: { id: :confirm }
      end

      it 'set session[:order_complete]' do
        expect(session[:order_complete]).to eq true
      end

      it 'return a success response' do
        expect(response.status).to eq(200)
      end

      %i[order_id cart coupon].each do |param|
        it "clear #{param} from session" do
          expect(session[param]).to be_nil
        end
      end
    end
  end
end