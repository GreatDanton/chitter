class Category < ActiveRecord::Base
	has_many :discussions
	has_many :comments, through: :discussions
end
