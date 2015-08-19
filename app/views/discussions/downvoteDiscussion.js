// replace Discussion score
$('#discussionScore-<%= @discussion.id %>').find('p').fadeIn(500, function(){
  $(this).replaceWith('<p><%= pluralize( @discussion.score , "user") %> recommend this discussion</p>');
});

$('#discussion-<%= @discussion.id %>').find('#downvoteDiscussion').fadeIn(500, function(){
  $(this).replaceWith('<%= link_to unvote_discussion_path(@discussion), id: "unvote_down",class:"button-user-vote-voted", remote: true, data: {disable_with: "Unvoting..."}, method: :put do %><i class="fa fa-thumbs-o-down fa-lg"></i><% end %>');
});

$('#discussion-<%= @discussion.id %>').find('#unvote_up').fadeIn(500, function(){
  $(this).replaceWith('<%= link_to upvote_discussion_path(@discussion), id: "upvoteDiscussion", class:"button-user-vote", remote: true, data: {disable_with: "Voting..."}, method: :put do %><i class="fa fa-thumbs-o-up fa-lg"></i><%end%>');
});
