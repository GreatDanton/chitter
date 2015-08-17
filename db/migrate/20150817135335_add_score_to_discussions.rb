class AddScoreToDiscussions < ActiveRecord::Migration
  def change
  	add_column :discussions, :score, :integer, :default => 0
  end
end
