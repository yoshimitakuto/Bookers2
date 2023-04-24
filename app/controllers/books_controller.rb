class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
     sort_by {|x|
      x.favorited_users.includes(:favorites).where(created_at: from...to).size
     }.reverse
    @book = Book.new
    # @books = Book.all　※いいねが多い順に並べるためコメントアウト
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render:index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    # @book = Book.find(params[:id])
  end

  def update
    # @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render:edit
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    # @book.user_id = current_user.id
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
     redirect_to(books_path) unless @user == current_user
  end

end
