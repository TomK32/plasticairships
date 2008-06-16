class PostsController < ApplicationController
  
  before_filter :current_post, :only => [:edit, :update, :destroy, :publish]
  
  def index
    @posts = Post.published.paginate(:per_page => 10, :page => params[:page])
    redirect_to :action => :index and return unless @posts

    respond_to do |format|
      format.html # index.html.erb
      format.atom  { render :layout => false }
    end
  end
  
  def admin
    @posts = Post.find_all_by_published(false, :order => 'id DESC')
    @posts += Post.published.paginate(:per_page => 20, :page => params[:page])
  end
  
  def show
    begin
      @post = Post.published.find(params[:id], :include => [:comments, :user])
    rescue ActiveRecord::RecordNotFound => ex
      redirect_to posts_url and return if  @post.blank?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def new
    @post = Post.new(:published_at => Time.now)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def edit
  end

  def create
    @post = Post.new(params[:post])
    unless logged_in?
      @user = create_guest(params[:user])
      render :action => :new and return if @user.new_record?
    end
    @post.user = current_user
    @post.published = params[:post][:published] if current_user.moderator?

    respond_to do |format|
      if @post.save
        if @post.published?
          flash[:notice] = 'Post was successfully created.'
          format.html { redirect_to(@post) }
          format.xml  { render :xml => @post, :status => :created, :location => @post }
        else
          flash[:notice] = 'Post was successfully created and will be published soon'
          format.html { redirect_to(posts_url) }
          format.xml  { render :success }
        end
      else
        flash[:error] = 'Post couldn\'t be created.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.published = params[:post][:published] if current_user.moderator?

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { render :action => :show }
        format.xml  { head :ok }
      else
        flash[:error] = 'Post couldn\'t be updated.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def publish
    @post.published = true
    @post.save(false)
    redirect_to admin_posts_url
  end

  def destroy
    @post.destroy

    respond_to do |format|
      flash[:notice] = 'Post was destroyed'
      format.html { redirect_to(admin_posts_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def current_post
    @post = Post.find(params[:id])
  end
end
