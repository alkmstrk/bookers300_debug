class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :current_user_check, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'successfully updated.'
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def current_user_check
      user = User.find(params[:id])
      if current_user != user
        redirect_to user_path(current_user)
      end
    end

end
