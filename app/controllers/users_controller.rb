class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
    @users_unwhere = User.where.not(id: current_user.id)
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def show
   @user = User.find(params[:id])
    #DM機能
   @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    #DM機能
    @books = @user.books
    @book_new = Book.new
  end

  def daily_posts
    user = User.find(params[:user_id])
    @books = user.books.where(created_at: params[:created_at].to_date.all_day)
    render :daily_posts_form
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      @users = User.all
      render:edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(user_path(current_user.id)) unless @user == current_user
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end

end
