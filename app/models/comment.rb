class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion
  belongs_to :category
  validates :body, presence: true
  acts_as_votable

  def score
  	self.get_upvotes.size - self.get_downvotes.size
  end
end
