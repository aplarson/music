class SessionsController < ApplicationController
  def new
  	@user = User.new
  	render :new
  end

  def create
  	@user = User.find_by_credentials(*(user_params.values))

  end

  def destroy
  end
end