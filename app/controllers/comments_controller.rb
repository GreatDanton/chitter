class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :create, :update, :destroy]
  before_action :correct_user, only: [:edit, :destroy]
  before_action :admin, only: [:index]

 layout "pages", only: [:edit, :form]
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format| 
      if @comment.save
        format.html { redirect_to discussions_path }
        format.js
      else
        format.html { render 'edit' }
        format.js
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html
        format.js
      else
        format.html
        format.js
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    flash[:success] = "Comment was successfully destroyed."
    redirect_to request.referer || comments_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:discussion_id, :body, :user_id)
    end

    def correct_user
      if current_user.admin?
        @comment = Comment.find(params[:id])
      elsif 
        @comment = current_user.comments.find_by(id: params[:id])
        redirect_to discussions_path if @comment.nil?
      else
        redirect_to request.referer || discussions_path
        flash[:danger] = "You don't have access to this page!"
      end     
    end

    def admin
      if logged_in? && current_user.admin?
      else
        redirect_to request.referer || discussions_path
        flash[:danger] = "You don't have access to this page!"
      end
    end
end
