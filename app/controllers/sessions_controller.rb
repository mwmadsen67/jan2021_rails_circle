class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      login!(user)
      redirect_to user_url(user) # show page -> user_url(user) -> "users/22"
    else
      flash.now[:errors] = ["whatever error you want"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
  
end
