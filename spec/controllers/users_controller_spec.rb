require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before{ sign_in(user) }

  describe 'GET #index' do
    it 'return a success response' do
      get :edit
      expect(response.status).to eq(200)
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update email' do
    context 'valid email' do
      before { put :update_email, params: { user: { email: 'user@email.mail' } } }

      it 'redirect_to settings privacy' do
        expect(response).to redirect_to settings_privacy_path
      end

      it 'show success message' do
        expect(flash[:success]).to eq 'Email successfuly changed'
      end
    end

    context 'invalid email' do
      before { put :update_email, params: { user: { email: 'xxxx' } } }

      it 'render template edit' do
        expect(response).to render_template :edit
      end

      it 'show error message' do
        expect(flash[:danger]).not_to be_nil
      end
    end
  end

  describe 'update password' do
    let(:valid_password_params) do
      { user: {
        current_password: user.password,
        password: 'NewPassword1',
        password_confirmation: 'NewPassword1'
       }
     }
    end
    let(:invalid_password_params) do
      { user: {
        current_password: user.password,
        password: 'invalid',
        password_confirmation: 'invalid'
       }
     }
    end

    context 'valid password' do
      before { put :update_password, params: valid_password_params }

      it 'redirect_to settings privacy' do
        expect(response).to redirect_to settings_privacy_path
      end

      it 'show success message' do
        expect(flash[:success]).to eq 'Password successfuly changed'
      end
    end

    context 'invalid password' do
      before { put :update_password, params: invalid_password_params }

      it 'render template edit' do
        expect(response).to render_template :edit
      end

      it 'show error message' do
        expect(flash[:danger]).not_to be_nil
      end
    end
  end
end
