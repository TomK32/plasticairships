module PostsHelper
  def latest_posts(limit=3)
    Post.published.find(:all, :limit => limit)
  end
end
