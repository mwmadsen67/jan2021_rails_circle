class ApplicationController < ActionController::Base

  # LL CRL J

  helper_method :current_user, :logged_in?

  def login!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logout!
    # current_user.reset_session_token!
    session[:session_token] = nil
    # @current_user = nil
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_logged_in?
    redirect_to new_session_url unless logged_in?
  end
  
  def logged_in?
    !!current_user # double negative = NOT NOT current_user = true if user false if no user
  end

  def jay
    p "yo"
  end
  
end
