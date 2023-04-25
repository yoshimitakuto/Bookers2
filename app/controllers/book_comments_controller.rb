class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_params)
    @comment.book_id = @book.id
    if @comment.save
    # redirect_to book_path(book), 非同期処理により削除
    flash.now[:notice] = 'コメントを投稿しました'
    else
     redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    # redirect_to book_path(params[:book_id]), 非同期処理により削除
    flash.now[:alert] = 'コメントを削除しました'
    @book = Book.find(params[:book_id])
  end

  private

  def book_params
    params.require(:book_comment).permit(:comment)
  end

end
