require File.dirname(__FILE__) + '/../test_helper'

class PostsControllerTest < ActionController::TestCase  
  def setup
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # only thing is we preset the published_at date
  def test_01_new
    get :new
    assert_not_nil assigns['post']
    # be nice to the user, preset what ever is possible
    assert_not_nil assigns['post'].published_at    
  end

  # post must not show when posting as guest
  # post must not show when posting as member
  # post must show up when posting as moderator
  def test_02_create_post
    posts_counter = Post.count
    published_posts_counter = Post.published.count
    get :new
    assert_equal false, @controller.current_user
    
    # uncomplete
    post :create
    assert_not_nil assigns['post']
    bad_post = assigns['post']
    # check for correct error messages
    assert bad_post.errors.on('body')
    assert bad_post.errors.on('permalink')
    assert bad_post.errors.on('title')
    assert bad_post.errors.on('published_at')
    assert @controller.current_user.guest?
    guest_user = @controller.current_user
    assert_equal false, flash.empty?
    
    # and now the correct one
    post :create, :post => {:title => 'Breaking News',
        :body => "I've just been informed that something big happened",
        :published_at => Time.now,
        :tag_list => 'news,big' }
    assert_not_nil assigns['post']
    good_post = assigns['post']
    assert good_post.errors.empty?
    assert_equal false, good_post.new_record?
    good_post.reload
    assert_equal posts_counter+1, Post.count
    assert_equal published_posts_counter, Post.published.count
    assert_equal %w(big news), good_post.tag_list.sort
    assert_equal guest_user, good_post.user
  end

  # comment has no user_id
  def test_03_comment_on_post_as_unregistered
  end

  # must update user attributes
  # comment must have user_id
  # comment must show up on post unless it's marked as spam
  def test_04_comment_on_post_as_guest
  end

  # comment must have user_id
  # comment must skip spamcheck if user is moderator
  # comment must show up on post unless it's marked as spam
  def test_05_comment_on_post_as_member    
  end
end
