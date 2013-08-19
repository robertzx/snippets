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

  describe "#public?" do
    let(:snippet) { FactoryGirl.build(:snippet, :text => "my snippet", :secret => false) }

    it "returns true if public" do
      snippet.public?
    end

  end

  describe "#private?" do
    let(:snippet) { FactoryGirl.build(:snippet, :text => "my snippet", :secret => true) }

    it "returns true if private" do
      snippet.private?
    end
  end

  describe "#set_token" do
    let(:snippet) { FactoryGirl.create(:snippet, :text => "my snippet") }
    let(:private_snippet) { FactoryGirl.create(:snippet, :text => "my snippet", :secret => true) }

    it "returns nil if snippet isn't private" do
      snippet.token.should == nil
    end

    it "sets the token if snippet is private" do
      private_snippet.token.should == Digest::SHA1.hexdigest(private_snippet.id.to_s)
    end

  end
end
