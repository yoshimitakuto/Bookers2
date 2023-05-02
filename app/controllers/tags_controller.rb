class TagsController < ApplicationController

  def index
    if params[:tag_name]
      @books = Book.tagged_with("#{params[:tag_name]}")
    else
      @books = Book.all
    end
    @keyword = params[:tag_name]
  end

  def search
    if params[:key]
      @books = Book.tagged_with("#{params[:key]}")
    else
      @books = Book.all
    end
    @keyword = params[:key]
    render 'index'
  end

end
