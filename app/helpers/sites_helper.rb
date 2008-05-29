module SitesHelper
  def latest_sites(limit=3)
    Site.find_published(limit)
  end
end
