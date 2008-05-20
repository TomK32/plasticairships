# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def latest_posts(limit=3)
    Post.find_published_posts(limit)
  end
end
