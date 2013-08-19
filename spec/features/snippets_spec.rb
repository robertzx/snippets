require 'spec_helper'

describe "Snippets Features" do

  describe "viewing the index page" do
    let(:snippet1) { FactoryGirl.create(:snippet, :text => "the quick brown fox jumps over the fat lazy dog laying out in the big front yard") }
    let(:snippet2) { FactoryGirl.create(:snippet, :text => "my snippet 2") }
    let(:snippet3) { FactoryGirl.create(:snippet, :text => "my snippet 3", :secret => true) }
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
      page.should have_content snippet1.excerpt
      page.should have_content snippet2.excerpt
      page.should_not have_content snippet3.excerpt
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

    describe "viewing a private snippet by ID" do
      let(:private_snippet) { FactoryGirl.create(:snippet, :text => "my private snippet", :secret => true) }

      before(:each) do
        visit snippet_path(private_snippet)
      end

      it "does not allow viewing of private snippets by ID" do
        page.current_path.should == snippets_path
      end

      it "displays an error message to the user" do
        page.should have_content "You need the exact URL in order to access a private snippet"
      end

    end

    describe "viewing a private snippet by it's token" do
      let(:private_snippet) { FactoryGirl.create(:snippet, :text => "my private snippet", :secret => true) }

      before(:each) do
        visit private_snippet_path(private_snippet.token)
      end

      it "shows the correct snippet" do
        page.should have_content private_snippet.excerpt
        page.should have_content private_snippet.text
      end

      it "shows the url to share the snippet" do
        page.should have_content private_snippet_url(private_snippet.token)
      end

    end
  end
end
