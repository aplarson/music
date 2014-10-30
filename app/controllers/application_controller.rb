class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
  	User.find_by_session_token(session[:session_token])
  end

  def user_params
  	params.require(:user).permit([:email, :password])
  end

  helper_method :current_user
end
