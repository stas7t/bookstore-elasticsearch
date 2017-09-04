require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:author_params) { FactoryGirl.attributes_for(:author).stringify_keys }
  let(:author) { FactoryGirl.build_stubbed(:author) }
  #let(:author) { FactoryGirl.create(:author) }

  describe 'GET #show' do
    before do
      allow(Author).to receive(:find).and_return author
    end

    it 'receives find and return author' do
      expect(Author).to receive(:find).with(author.id.to_s)
      get :show, params: { id: author.id }
    end

    it 'assigns @author' do
      get :show, params: { id: author.id }
      expect(assigns(:author)).not_to be_nil
    end

    it 'renders :show template' do
      get :show, params: { id: author.id }
      expect(response).to render_template :show
    end
  end
end
