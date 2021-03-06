class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
  end

  def show
  	@user = User.find(params[:id])
    @discussions = @user.discussions.order(created_at: :desc).paginate(page: params[:page])
    @comments = @user.comments.order(created_at: :desc).paginate(page: params[:page], :per_page => 50)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account. It may take few
      minutes for email to arrive."
      redirect_to '/discussions'
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def leaderboards
    @users = User.all.order(karma: :desc)
  end

private


	def user_params
		params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
	end

  #Before filters
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in to access this page."
      redirect_to login_url
    end
  end


  #confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
