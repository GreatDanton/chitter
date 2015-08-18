class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(nickname: params[:session][:nickname])
  	if user && user.authenticate(params[:session][:password])
      if user.activated?
  		log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_to discussions_path
      else
      message = "Account not activated."
      message += " Check your email for account activation link."
  		flash[:danger] = message
  		redirect_to '/discussions'
      end
    else
      flash.now[:danger] = "Invalid email/password combination."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to discussions_path
  end

end
