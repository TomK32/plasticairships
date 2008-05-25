atom_feed(:schema_date => 2008, :root_url => sites_url) do |feed|

  feed.title site_title + " featured sites"
  feed.updated Time.now

  for site in @sites
    feed.entry(site, :url => site_url(site)) do |entry|
      entry.title site.title
      entry.author do |author|
        author.name site.user.name
        author.url user_url(site.user)
      end
      entry.content '<div style="float: left;">%s</div>' % image_tag(site.thumbnail_url(request)) + site.description,
        :type => :html
    end
    
  end

end