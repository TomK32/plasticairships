class FrontController < ApplicationController

  caches_action :index
  before_filter :load_home_content_page
  
  def load_home_content_page
    @content_page = Goldberg::ContentPage.find_by_name('home')
  end


  def index
    @posts = Post.published.find(:all, :limit => 2)
    @site_comments = Site::Comment.recent.published.find(:all, :limit => 5, :include => :site)
    # FIXME rails' class reloading misses the modulized comments somehow
    if RAILS_ENV == 'production'
      @post_comments = Post::Comment.recent.published.find(:all, :limit => 5)
    else
      @post_comments = []
    end
  end
end
