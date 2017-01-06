class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id

    redirect_to @user
  end

  def edit
  end

  def update
  end

  def show
    @user = User.find(params[:id])

    redirect_to '/' if session[:user_id] != @user.id
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height, :admin)
  end
end
