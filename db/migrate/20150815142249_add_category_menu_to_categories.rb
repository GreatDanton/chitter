class AddCategoryMenuToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :category, :string
  end
end
