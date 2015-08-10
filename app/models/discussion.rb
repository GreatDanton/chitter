class Discussion < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :user_id, presence: true
	#validates :content, presence: true
	accepts_nested_attributes_for :comments
	acts_as_votable
	def score
		self.get_upvotes.size - self.get_downvotes.size
	end
end
