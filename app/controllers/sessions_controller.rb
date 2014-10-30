class SessionsController < ApplicationController
  def new
  	@user = User.new
  	render :new
  end

  def create
  	@user = User.find_by_credentials(*(user_params.values))
    
    if @user 
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
  	else
  	  render :new
  	end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    render :new
  end
end