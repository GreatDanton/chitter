class DiscussionsController < ApplicationController
  layout 'pages', only: [:frontpage]
  before_action :set_discussion, only: [:show, :edit, :update, :destroy, :upvoteDiscussion, :downvoteDiscussion, :unvoteDiscussion]
  before_action :logged_in_user, except: [:index, :show, :frontpage, :upvoteDiscussion, :downvoteDiscussion, :unvoteDiscussion]
  before_action :correct_user, only: [:edit, :destroy]

  # GET /discussions
  # GET /discussions.json

  def index
    @discussions = Discussion.all.order(created_at: :desc)
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
        redirect_to discussions_path
        flash[:success] = "Discussion was successfully created."
      else
        render 'new'
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
    @discussion.upvote_from current_user
    redirect_to :back
  end

  #downvote from user
  def downvoteDiscussion
    @discussion.downvote_from current_user
    redirect_to :back
  end

  def unvoteDiscussion
    @discussion.unvote_by current_user
    redirect_to :back
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:id, :user_id, comments_attributes: [:body, :discussion_id, :user_id])
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
