require File.dirname(__FILE__) + '/../test_helper'

class PostsControllerTest < ActionController::TestCase
  
  # post must not show when posting as guest
  # post must not show when posting as member
  # post must show up when posting as moderator
  def test_01_create_post
  end

  # comment has no user_id
  def test_02_comment_on_post_as_unregistered
  end

  # must update user attributes
  # comment must have user_id
  # comment must show up on post unless it's marked as spam
  def test_03_comment_on_post_as_guest
  end

  # comment must have user_id
  # comment must skip spamcheck if user is moderator
  # comment must show up on post unless it's marked as spam
  def test_04_comment_on_post_as_member    
  end
end
