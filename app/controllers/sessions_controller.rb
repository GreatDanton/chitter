class SessionsController < ApplicationController
  layout "pages"

  def new
  end

  def create
  	user = User.find_by(nickname: params[:session][:nickname])
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to user

  	else
  		flash.now[:danger] = "Invalid nickname/password combination"
  		render 'new'
  	end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end