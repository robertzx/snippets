class Snippet < ActiveRecord::Base
  attr_accessible :secret, :text

  validates :text, length: { maximum: 8192 }

  scope :public, -> { where('secret IS FALSE') }

  after_create :set_token, :if => "private?"

  def excerpt
    excerpt_words.join(" ")
  end

  def public?
    !private?
  end

  def private?
    secret == true
  end

  def set_token
    return nil unless private?

    token = Digest::SHA1.hexdigest(id.to_s)
    self.token = token
    self.save

    token
  end

  private

  def words
    text.split(" ")
  end

  def excerpt_words
    words.shift(15)
  end
end
