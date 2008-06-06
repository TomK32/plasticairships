class FrontController < ApplicationController

  caches_action :index

  def index
    @posts = Post.find_published(2)
    @site_comments = Site::Comment.recent.published.find(:all, :limit => 5, :include => :site)
    # FIXME rails' class reloading misses the modulized comments somehow
    if RAILS_ENV == 'production'
      @post_comments = Post::Comment.recent.published.find(:all, :limit => 5)
    else
      @post_comments = []
    end

    @sites = Site.find_featured_published_with_screenshots(20)
  end
end
