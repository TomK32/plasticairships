class Site::CommentsController < ApplicationController
  before_filter :current_site, :only => [:index, :new, :create]
  before_filter :current_comment, :only => [:show, :edit, :update, :destroy]
  def index
    @comments = @site.comments.find :all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def new
    @comment = @site.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def edit
  end

  def create
    @comment = @site.comments.new(params[:comment])
    if current_user
      @comment.user = current_user
      @comment.published = true
    end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(site_path(@site) + "#comment-%d" % @comment.id)}
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        flash[:error] = 'Comment couldn\'t be created.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(site_path(@site) + "#comment-%d" % @comment.id)}
        format.xml  { head :ok }
      else
        flash[:error] = 'Comment couldn\'t be updated.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      flash[:notice] = 'Comment was destroyed'
      format.html { redirect_to(site_url(@comment.site.permalink)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def current_site
    @site = Site.find(params[:site_id])
  end

  def current_comment
    @comment = Site::Comment.find(:first, :conditions => ['comments.id = ? AND site_id = ?', params[:id], params[:site_id]], :include => :site)
  end
end
