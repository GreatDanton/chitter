class AddCategoryIdToDiscussions < ActiveRecord::Migration
  def change
  	add_column :discussions, :category_id, :integer
  end
end
