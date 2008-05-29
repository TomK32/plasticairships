module PostsHelper
  def latest_posts(limit=3)
    Post.find_published(limit)
  end
end
