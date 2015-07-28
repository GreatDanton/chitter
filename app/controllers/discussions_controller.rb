class DiscussionsController < ApplicationController
  layout 'pages', only: [:frontpage]
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, except: [:index, :frontpage]

  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all.order(created_at: :desc)
  end

  # GET /discussions/1
  # GET /discussions/1.json

  # GET /discussions/new
  def new
    @discussion = current_user.discussions.build
  end

  # GET /discussions/1/edit
  def edit
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = current_user.discussions.build(discussion_params)


      if @discussion.save
        redirect_to discussions_path
        flash[:success] = "Discussion was successfully created."
      else
        render 'new'
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    if @discussion.update(discussion_params)
      redirect_to discussions_path
      flash[:success] = "Discussion was successfully updated."
    else
      render 'edit'
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @discussion.destroy
    flash[:success] = "Discussion was successfully deleted."
    redirect_to discussions_path
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:content)
    end
end
