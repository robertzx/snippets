require 'spec_helper'

describe "Snippets Features" do

  describe "viewing the index page" do
    let(:snippet1) { FactoryGirl.create(:snippet, :text => "the quick brown fox jumps over the fat lazy dog laying out in the big front yard") }
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

    it "takes the user to the snippet's show page when they click on a snippet" do
      click_on snippet1.excerpt
      page.current_path.should == snippet_path(snippet1)
    end

    it "shows a list of all snippets" do
      snippets.each do |snippet|
        page.should have_content snippet.excerpt
      end
    end

    it "shows a count of all the snippets in the database" do
      page.should have_content "3 snippets in the database"
    end

    context "when more than 20 snippets exist" do
      before(:each) do
        Snippet.destroy_all

        25.times do
          FactoryGirl.create(:snippet, :text => "my snippet")
        end

        visit root_path
      end

      it "shows the 20 most recent snippets" do
        most_recent_snippets = Snippet.all.shift(5)
        all_snippets = all('table tr')
        all_snippets.count.should == 20

        most_recent_snippets.each do |snippet|
          page.should have_content snippet.text
        end
      end
    end

  end
end
