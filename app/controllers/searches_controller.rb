class SearchesController < ApplicationController
  
  def search
    @books = Book.all
    @books_search = @books.where("tag_list LIKE?")
  end
  
end
