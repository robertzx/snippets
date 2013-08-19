require 'spec_helper'

describe SnippetsController do
  render_views

  let(:snippet1) { FactoryGirl.create(:snippet, :text => "the quick brown fox jumps over the fat lazy dog laying out in the big front yard") }
  let(:snippet2) { FactoryGirl.create(:snippet, :text => "my snippet 2") }
  let(:snippet3) { FactoryGirl.create(:snippet, :text => "my snippet 3") }
  let!(:snippets) { [snippet1, snippet2, snippet3] }

  describe "#index" do
    it "finds the first 20 snippets" do
      get :index
      assigns(:snippets).should == snippets
    end
  end

  describe "#new" do
    it "instantiates a new snippet object" do
      get :new
      assigns(:snippet).should be_new_record
    end
  end

end
