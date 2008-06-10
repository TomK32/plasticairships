require File.dirname(__FILE__) + '/../test_helper'

class PostTest < ActiveSupport::TestCase

  def test_01_published_and_published_at
    posts_count = Post.count
    published_posts_count = Post.published.count

    # publish in the future, won't show up
    future_post = Post.new(:title => 'Behold! The Future begins',
      :body => 'This is a letter from The Future',
      :published_at => Time.now + 1.day)
    future_post.published = true
    future_post.user_id = 1
    future_post.save!
    assert_equal published_posts_count, Post.published.count
    assert_equal posts_count + 1, Post.count
    
    present_post = Post.new(:title => 'It happen\'s right now!',
      :body => 'There\'s something going on I was told',
      :published_at => Time.now)
    present_post.published = 1
    present_post.user_id = 1
    present_post.save!
    assert_equal published_posts_count + 1, Post.published.count
    assert_equal posts_count + 2, Post.count
  end
end
