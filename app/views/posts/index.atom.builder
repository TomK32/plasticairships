atom_feed(:schema_date => 2008, :root_url => posts_url) do |feed|

  feed.title site_title
  feed.updated Time.now

  for post in @posts
    feed.entry(post, :url => post_url(post)) do |entry|
      entry.title post.title
      entry.author do |author|
        author.name post.user.name
        author.url user_url(post.user)
      end
      entry.content render(:partial => 'feed_content.html.erb', :locals => {:post => post}), :type => :html
    end
    
  end

end