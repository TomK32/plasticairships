module PostsHelper
  def latest_posts(limit=3)
    Post.find_published_posts(limit)
  end
end
