class CommentsController < ApplicationController
  before_filter :current_post, :only => [:index, :new, :create]
  before_filter :current_comment, :only => [:show, :edit, :update]
  def index
    @comments = @post.comments.find :all

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
    @comment = @post.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def edit
  end

  def create
    @comment = @post.comments.new(params[:comment])
    @comment.user = current_user if current_user

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(post_permalink_path(@comment.post.permalink) + "#" + @comment.id)}
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        flash[:error] = 'Comment couldn\'t be created.'
        format.html { render :action => "../posts/show" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(post_permalink_path(@comment.post.permalink) + "#" + @comment.id)}
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
      format.html { redirect_to(post_url(@comment.post.permalink)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def current_post
    @post = Post.find(params[:post_id])
  end

  def current_comment
    @comment = Comment.find(:first, :conditions => ['id = ? AND post_id = ?', params[:id], params[:post_id]], :include => :post)
  end
end
