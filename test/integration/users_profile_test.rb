require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
 include ApplicationHelper

 def setup
 	 @user = users(:michael)
 end

# test "profile display" do
 #	get user_path(@user)
 #	assert_template 'users/show'
 #	assert_select "h2", text: @user.nickname
 #	assert_match @user.comments.count.to_s, response.body
 #	assert_select 'div.pagination'
 #	@user.comments.paginate(page: 1).each do |comment|
 #		assert_match comment.content, response.body
 #	end
 #end

end