class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  	@user = User.new
  	render :new
  end

  def create
  	@user = User.find_by_credentials(*(user_params.values))
    
    if @user 
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to bands_url
  	else
  	  render :new
  	end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end