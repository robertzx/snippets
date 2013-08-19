class SnippetsController < ApplicationController

  def index
    @snippets = Snippet.limit(20)
  end

  def new
    @snippet = Snippet.new
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

end
