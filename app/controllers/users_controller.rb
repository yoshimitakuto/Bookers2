class UsersController < ApplicationController
  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    @user = User.find(params[:id])
    end
  end

end
