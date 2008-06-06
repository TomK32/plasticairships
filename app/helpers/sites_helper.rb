module SitesHelper
  def latest_sites(limit=3)
    Site.published.find(:all, :limit => limit, :include => :screenshot)
  end
end
