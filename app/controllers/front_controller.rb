class FrontController < ApplicationController

  caches_action :index

  def index
    @posts = Post.find_published(2)
    @post_comments = Post::Comment.recent.published.find(:all, :limit => 2, :include => :post)
#    @site_comments = Site::Comment.recent.published.find(:all, :limit => 2, :include => :site)
  @site_comments = []
    @sites = Site.find_featured_published_with_screenshots(20)
    @content_page = Goldberg::ContentPage.find_by_name('home')
  end
end
