class Discussion < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	belongs_to :category
	validates :user_id, presence: true
	validates :category_id, presence: true
	accepts_nested_attributes_for :comments
	acts_as_votable

	def increase_score(count)
		update_attribute(:score, score + count)
	end

	def decrease_score(count)
		update_attribute(:score, score - count)
	end

end
