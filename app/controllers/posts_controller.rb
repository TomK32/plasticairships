class PostsController < ApplicationController
  def index
    @posts = Post.find_published_posts(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def show
    @post = Post.find_by_date_and_permalink(params[:year], params[:month], params[:day], params[:permalink])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    create_guest unless logged_in?
    @post = current_user.posts.new(params[:post])
    @post.published = true if params[:post][:published] and current_user.moderator?

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

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Post couldn\'t be updated.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      flash[:notice] = 'Post was destroyed'
      format.html { redirect_to(admin_posts_url) }
      format.xml  { head :ok }
    end
  end
end
