require File.dirname(__FILE__) + '/../test_helper'

class PostsControllerTest < ActionController::TestCase

  def test_01_create_post_as_guest
  end
  
  def test_02_create_post_as_member_and_moderator
  end

  # comment has no user_id
  def test_03_comment_on_post_as_unregistered
  end

  # must update user attributes
  # comment must have user_id
  def test_04_comment_on_post_as_guest
  end

  # comment must have user_id
  def test_05_comment_on_post_as_member    
  end
end
