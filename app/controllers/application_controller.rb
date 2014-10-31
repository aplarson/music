class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    return nil if session[:session_token].nil?
  	@current_user ||= User.find_by_session_token(session[:session_token])
  end

  def user_params
  	params.require(:user).permit([:email, :password])
  end

  helper_method :current_user

  private

  def require_login
    unless current_user
      flash[:errors] = ["You must login"]
      redirect_to new_session_url
    end
  end
end
