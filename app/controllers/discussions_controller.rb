class DiscussionsController < ApplicationController
	
	before_action :find_discussion, only: [:show, :edit, :update, :destroy]


	def index
		@discussions = Discussion.all.order("created_at DESC")
	end

	def show
	
	end

	def new
		@discussion = Discussion.new
	end

	def create
		@discussion = Discussion.new(discussion_params)

		if @discussion.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @discussion.update(discussion_params)
			redirect_to @discussion
		else
			render 'edit'
		end
	end

	def destroy
		@discussion.destroy
		redirect_to root_path
	end

	private
	def find_discussion
		@discussion = Discussion.find(params[:id])
	end

	def discussion_params
		params.require(:discussion).permit(:content)
	end

end
