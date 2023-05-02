class TagsController < ApplicationController

  def index
    if params[:tag_name]
      @books = Book.tagged_with("#{params[:tag_name]}")
    end
    @keyword = params[:tag_name]
  end

end
