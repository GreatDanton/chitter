class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :admin, only: [:new, :edit, :update, :destroy]
  # GET /categories
  # GET /categories.json
  def index
    @tech = Category.where(category: "tech").order(name: :asc)
    @categories = Category.where(category: "normal").order(name: :asc)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path }
        flash[:success] = "Category was successfully created."
      else
        format.html { render :new }

      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category }
        flash[:succes] = "Category was successfully updated."
      else
        format.html { render :edit }

      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      flash[:success] = "Category was successfully destroyed."
    end
  end

  def FAQ
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :category)
    end

    def admin
      if logged_in? && current_user.admin?
      else
        redirect_to categories_path
        flash[:danger] = "You don't have acess to this page!"
      end
    end
end
