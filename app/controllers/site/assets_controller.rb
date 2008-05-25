class Site::AssetsController < ApplicationController

  before_filter :current_asset, :only => [:destroy]
  def destroy
    @asset.destroy

    respond_to do |format|
      flash[:notice] = 'image was deleted'
      format.html { redirect_to(edit_site_url(@asset.site)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def current_asset
    @asset = Site::Asset.find(:first, :conditions => ['site_assets.id = ? AND site_id = ?', params[:id], params[:site_id]], :include => :site)
    redirect_to :back if @asset.nil?
  end
end
