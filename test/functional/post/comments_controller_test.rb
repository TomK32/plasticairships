require File.dirname(__FILE__) + '/../../test_helper'

class CommentsControllerTest < ActionController::TestCase
  tests Post::CommentsController
  
  def setup
    @controller = Post::CommentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # comment has no user_id
  def test_01_comment_on_post_as_unregistered
    published_post = Post.published.first
    post :create, {:post_id => published_post.id }
    assert_not_nil assigns['post']
    assert_not_nil assigns['comment']
    puts assigns['comment'].errors.to_xml
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
