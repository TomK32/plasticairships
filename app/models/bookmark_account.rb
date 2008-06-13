require 'feed_tools'
require 'hpricot'

BOOKMARK_SERVICES = {
  'del.icio.us' => 'http://del.icio.us/rss/%1$s/%2$s'
}

class BookmarkAccount < ActiveRecord::Base
  belongs_to :user
  has_many :sites, :dependent => :destroy


  def url
    BOOKMARK_SERVICES[self.service] % [self.login, self.tags]
  end

  def refresh
    feed = FeedTools::Feed.open(self.url)
    feed.items.each do |item|
      
      site = self.user.sites.find_or_initialize_by_url(item.link)
      site.attributes = {
        :description => item.description || "",
        :url => item.link,
        :published => item.published,
        :title => item.title,
        :tag_list => item.tags
      }

      site.save!
    end
  end
end
