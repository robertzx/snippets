require 'spec_helper'

def too_long_text
  chars = ""

  8193.times do
    chars << "X"
  end

  chars
end

describe Snippet do
  describe "#excerpt" do
    let(:snippet) { FactoryGirl.create(:snippet, :text => "the quick brown fox jumps over the fat lazy dog laying out in the big front yard") }

    it "returns the first 15 words of the snippet's text" do
      snippet.excerpt.should == "the quick brown fox jumps over the fat lazy dog laying out in the big"
    end
  end

  describe "validations" do
    let(:snippet) { FactoryGirl.build(:snippet, :text => too_long_text) }

    it "required snippet text to be no more than 8192 characters" do
      snippet.should_not be_valid
    end
  end
end
