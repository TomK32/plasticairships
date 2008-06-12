require File.dirname(__FILE__) + '/../../test_helper'

class CommentsControllerTest < ActionController::TestCase
  tests Post::CommentsController
  
  def setup
    @controller = Post::CommentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # comment has no user_id
  def test_01_comment_on_post_as_unregistered_user
    published_post = Post.published.first
    post :create, {:post_id => published_post.id }
    assert_not_nil assigns['post']
    comment = assigns['comment']
    assert_not_nil comment
    assert comment.errors['user_name']
    assert comment.errors['user_email']
    assert comment.errors['body']

    # now a successful comment
    post :create, {:post_id => published_post.id,
      :comment => {
        :user_name => 'El Rug',
        :user_email => 'elurg@example.com',
        :body => 'Very nice. Whatever.'
    }}
    
    assert_not_nil assigns['post']
    comment = assigns['comment']
    assert comment.errors.empty?
    assert_equal false, comment.published?
  end

  # must update user attributes
  # comment must have user_id
  # comment must show up on post unless it's marked as spam
  def test_02_comment_on_post_as_guest
  end

  # comment must have user_id
  # comment must skip spamcheck if user is moderator
  # comment must show up on post unless it's marked as spam
  def test_03_comment_on_post_as_member
  end
end
