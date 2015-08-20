class DiscussionsController < ApplicationController
  layout 'pages', only: [:frontpage]
  before_action :set_discussion, only: [:show, :edit, :update, :destroy, :upvoteDiscussion, :downvoteDiscussion, :unvoteDiscussion]
  before_action :logged_in_user, except: [:index, :show, :frontpage, :archive]
  before_action :correct_user, only: [:edit, :destroy]

  # GET /discussions
  # GET /discussions.json

  def frontpage
    @users = User.order(karma: :desc).limit(5)
  end

  def archive
    @discussions = Discussion.where("score >= 100").order(created_at: :desc)
  end

  def index
    @discussions = Discussion.where("score >= 1").order(created_at: :desc)
    @comment = Comment.new
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @discussion = Discussion.find_by(id: params[:id])
    @comment = Comment.new
  end

  # GET /discussions/new
  def new
    @discussion = current_user.discussions.build
    @comment = @discussion.comments.build
  end

  def edit
  end

  # GET /discussions/1/edit

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = current_user.discussions.build(discussion_params)
    # assigns user_id to first comment when creating discussion
    for comment in @discussion.comments
      comment.user_id = current_user.id
    end

      if @discussion.save
        redirect_to category_path(@discussion.category_id)
        flash[:success] = "Discussion was successfully created."
      else
        render 'new'
    end
  end

  def update
      if @discussion.update(discussion_params)
        redirect_to categories_path
        flash[:success] = "Discussion was successfully moved."
      else
        render 'edit'
      end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json


  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @discussion.destroy
    flash[:success] = "Discussion was successfully deleted."
    redirect_to discussions_path
    end

# upvote from user
  def upvoteDiscussion
    respond_to do |format|
      if current_user.voted_down_on? @discussion
        @discussion.upvote_from current_user
        @discussion.increase_score(2)
        format.html { redirect_to :back}
        format.js
      else
        @discussion.upvote_from current_user
        @discussion.increase_score(1)
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  #downvote from user
  def downvoteDiscussion
    respond_to do |format|
    if current_user.voted_up_on? @discussion
      @discussion.downvote_from current_user
      @discussion.decrease_score(2)
      format.html { redirect_to :back }
      format.js
    else
      @discussion.downvote_from current_user
      @discussion.decrease_score(1)
      format.html { redirect_to :back }
      format.js
    end
  end
  end

  def unvoteDiscussion
    respond_to do |format|
    if current_user.voted_up_on? @discussion
      @discussion.unvote_by current_user
      @discussion.decrease_score(1)
      format.html { redirect_to :back }
      format.js
    else
      @discussion.unvote_by current_user
      @discussion.increase_score(1)
      format.html { redirect_to :back }
      format.js
    end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:id, :user_id, :category_id, comments_attributes: [:body, :discussion_id, :user_id])
    end

    def correct_user
      if current_user.admin?
        @discussion = Discussion.find(params[:id])
      elsif
        @discussion = current_user.discussions.find_by(id: params[:id])
        redirect_to discussions_path if @discussion.nil?
      else
        redirect_to request.referer || discussions_path
        flash[:danger] = "You don't have acess to this page"
      end
    end


end
