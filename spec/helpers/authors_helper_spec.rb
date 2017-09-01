require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AuthorsHelper. For example:
#
# describe AuthorsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AuthorsHelper, type: :helper do
  before :each { @author = FactoryGirl.create(:author) }

  subject { @author }

  describe 'short description' do
    it 'shortens author description' do
      expect(helper.author_short_description(subject).length).to eq(50)
    end
    it 'ends with ...' do
      expect(helper.author_short_description(subject)).to end_with('...')
    end
  end
end
