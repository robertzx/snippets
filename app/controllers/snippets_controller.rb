class SnippetsController < ApplicationController

  def index
    @snippets = Snippet.public.limit(20)
  end

  def new
    @snippet = Snippet.new
  end

  def show
    if params[:token].present?
      @snippet = get_private_snippet
    else
      @snippet = get_public_snippet
    end
  end

  def create
    @snippet = Snippet.new(params[:snippet])

    if @snippet.private?
      @snippet.set_token
    end

    redirect_to snippets_path
  end

  private

  def get_private_snippet
    Snippet.find_by_token(params[:token])
  end

  def get_public_snippet
    id = params.fetch(:id)
    snippet = Snippet.find(id)

    if snippet.private?
      flash[:notice] = "You need the exact URL in order to access a private snippet"
      redirect_to snippets_path
    end

    snippet
  end

end
