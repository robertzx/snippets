class SnippetsController < ApplicationController

  def index
    @snippets = Snippet.all
  end

  def new

  end

end
