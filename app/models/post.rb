class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  attr_protected :user_id, :published

  def self.find_published_posts(per_page = 10, page = 1)
    return false if page.to_i < 1 and page != nil
    self.paginate :conditions => ['posts.published = ? AND posts.published_at < ?', true, Time.now],
      :order => 'published_at DESC', :per_page => per_page, :page => page
  end
  
  def self.find_by_date_and_permalink(year, month, day, permalink)
    date = Date.civil(year, month, day)
    self.find(:first, :conditions => ["posts.published_at < ? AND posts.published_at > ? AND posts.permalink", date.beginning_of_day, date.end_of_day, permalink])
  end

  def before_validation
    self.permalink = PermalinkFu.escape(self.title) if self.permalink.blank?
  end
  
  def year
    published_at.year
  end
  def month
    published_at.month
  end
  def day
    published_at.day
  end
  def excerpt
    return self[:body][/.{0,50}\w*?/] if self[:excerpt].blank?
    self[:excerpt]
  end
end
