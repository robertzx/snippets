class Snippet < ActiveRecord::Base
  attr_accessible :secret, :text

  validates :text, length: { maximum: 8192 }

  def excerpt
    excerpt_words.join(" ")
  end

  private

  def words
    text.split(" ")
  end

  def excerpt_words
    words.shift(15)
  end
end
