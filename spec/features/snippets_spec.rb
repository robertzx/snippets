require 'spec_helper'

describe "Snippets Features" do
  
  describe "viewing the index page" do
    let(:snippet1) { FactoryGirl.create(:snippet, :text => "my snippet 1") }
    let(:snippet2) { FactoryGirl.create(:snippet, :text => "my snippet 2") }
    let(:snippet3) { FactoryGirl.create(:snippet, :text => "my snippet 3") }
    let!(:snippets) { [snippet1, snippet2, snippet3] }

    before(:each) do
      visit root_path
    end

    it "has a button for creating a new snippet" do
      page.should have_content("Add Snippet")
    end

    it "takes user to new snippet page when they click 'Add Snippet'" do
      click_on "Add Snippet"
      page.current_path.should == new_snippet_path
    end

    it "shows a list of all snippets" do
      snippets.each do |snippet|
        page.should have_content snippet.text
      end
    end

  end
end
