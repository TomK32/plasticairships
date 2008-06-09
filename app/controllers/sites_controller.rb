class SitesController < ApplicationController
  
  caches_action :show, :index
  cache_sweeper :site_sweeper, :only => [:update, :create, :destroy, :publish, :featured]

  before_filter :current_site, :only => [:edit, :update, :destroy, :publish, :featured]

  def index
    @sites = Site.published.paginate(:per_page => 10, :page => params[:page])
    redirect_to :action => :index and return unless @sites or params[:page].blank?

    respond_to do |format|
      format.html # index.html.erb
      format.atom { render :layout => false }
    end
  end
  
  def admin
    @sites = Site.find_all_by_published(false, :limit => 10)
    @sites += Site.published(:per_page => 10, :page => params[:page])
  end

  def show
    @site = Site.find_by_id_and_published(params[:id], true, :include => [:comments, :assets])
    redirect_to sites_url and return unless @site

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
  end

  def create
    create_guest(params[:user]) unless logged_in?
    @site = current_user.sites.new(params[:site])
    @site.published = params[:site][:published] if current_user.moderator?
    respond_to do |format|
      if @site.save
        unless params[:asset].blank?
          asset = @site.assets.new(params[:asset])
          asset.user = current_user
          asset.save
        end
        format.html { render :action => :show }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
      else
        flash[:error] = 'Site couldn\'t be created.'
        format.html { render :action => :new }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @site.published = params[:site][:published] if current_user.moderator?

    unless params[:asset].blank? or params[:asset][:uploaded_data].blank?
      @asset = @site.assets.new(params[:asset])
      @asset.user = current_user
      unless @asset.save
        flash[:error] = "Image couldn't be saved"
        render :action => 'edit' and return
      end
    end

    respond_to do |format|
      if @site.update_attributes(params[:site])
        flash[:notice] = 'Site was successfully updated.'
        format.html { render :action => :show }
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

  def featured
    @site.toggle!(:featured)
    redirect_to admin_sites_url
  end

  def destroy
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