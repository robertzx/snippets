require 'spec_helper'

describe Snippet do
  describe "#excerpt" do
    let(:snippet) { FactoryGirl.create(:snippet, :text => "the quick brown fox jumps over the fat lazy dog laying out in the big front yard") }

    it "returns the first 15 words of the snippet's text" do
      snippet.excerpt.should == "the quick brown fox jumps over the fat lazy dog laying out in the big"
    end
  end
end
