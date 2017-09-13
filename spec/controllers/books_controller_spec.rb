require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book_params) { FactoryGirl.attributes_for(:book).stringify_keys }
  let(:category) { FactoryGirl.create(:category) }
  let(:book) { FactoryGirl.build(:book) }

  describe 'GET #show' do
    before do
      book.category_id = category.id
      book.save
      allow(Book).to receive(:find).and_return book
    end

    it 'receives find and return book' do
      expect(Book).to receive(:find).with(book.id.to_s)
      get :show, params: { id: book.id }
    end

    it 'assigns @book' do
      get :show, params: { id: book.id }
      expect(assigns(:book)).not_to be_nil
    end

    it 'renders :show template' do
      get :show, params: { id: book.id }
      expect(response).to render_template :show
    end
  end
end
