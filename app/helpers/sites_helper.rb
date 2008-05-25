module SitesHelper
  def latest_sites(limit=3)
    Site.find_published_sites(limit)
  end
end
