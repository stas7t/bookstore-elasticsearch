require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BooksHelper. For example:
#
# describe BooksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BooksHelper, type: :helper do
  before :each { @book = FactoryGirl.create(:book) }

  subject { @book }

  describe 'short description' do
    it 'shortens book description' do
      expect(helper.book_short_description(subject).length).to eq(50)
    end
    it 'ends with ...' do
      expect(helper.book_short_description(subject)).to end_with('...')
    end
  end
end
