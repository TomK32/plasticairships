class SitesController < ApplicationController
  before_filter :current_site, :only => [:edit, :update, :destroy, :show, :publish]
  def index
    @sites = Site.find_published_sites(10, params[:page])
    redirect_to :action => :index and return unless @sites

    respond_to do |format|
      format.html # index.html.erb
      format.atom { render :layout => false }
    end
  end
  
  def admin
    @sites = Site.find :all, :conditions => ['published = ?', false], :order => 'id DESC'
    @sites += Site.find_published_sites(25, params[:page])
  end

  def show
    @site = Site.find(params[:id], :include => :comments)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site }
    end
  end

  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site }
    end
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    create_guest unless logged_in?
    @site = current_user.sites.new(params[:site])

    respond_to do |format|
      if @site.save
        flash[:notice] = 'Site was successfully created.'
        format.html { redirect_to(@site) }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
      else
        flash[:error] = 'Site couldn\'t be created.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        flash[:notice] = 'Site was successfully updated.'
        format.html { redirect_to(@site) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Site couldn\'t be updated.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  def publish
    @site.published = true
    @site.save(false)
    redirect_to admin_sites_url
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      flash[:notice] = 'Site was destroyed'
      format.html { redirect_to(admin_sites_url) }
      format.xml  { head :ok }
    end
  end

  protected
  def current_site
    @site = Site.find(params[:id])
  end
end