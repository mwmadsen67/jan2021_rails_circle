class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    # request coming in
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to users_url
      # response going out
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:username, :favorite_drink, :password)
  end
  
end
