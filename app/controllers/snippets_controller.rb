class SnippetsController < ApplicationController

  def index
    @snippets = Snippet.limit(20)
  end

  def new

  end

  def show

  end

end
