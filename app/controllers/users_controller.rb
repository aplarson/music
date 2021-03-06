class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    else
  	  render :new
  	end
  end

  def new
    @user = User.new
    render :new
  end

  def show
  	@user = User.find(params[:id])
  	render :show
  end
end