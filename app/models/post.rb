class Post < ActiveRecord::Base

  has_many :comments, :class_name => 'Post::Comment'
  belongs_to :user
  named_scope :published, :conditions => ['published = ? AND posts.published_at < NOW()', true], :order => 'posts.published_at DESC'

  attr_protected :user_id, :published

  def self.find_published(per_page = 10, page = 1)
    return false if page.to_i < 1 and page != nil
    self.paginate :conditions => ['posts.published = ? AND posts.published_at < ?', true, Time.now],
      :order => 'posts.published_at DESC', :per_page => per_page, :page => page
  end
  
  def self.find_by_date_and_permalink(year, month, day, permalink)
    date = Date.civil(year, month, day)
    self.find(:first, :conditions => ["posts.published_at < ? AND posts.published_at > ? AND posts.permalink", date.beginning_of_day, date.end_of_day, permalink])
  end

  def to_param
    "#{id}-#{permalink}"
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
    return self[:body] if self[:body].length < 150
    return self[:body][/.{0,150}\w*/] + "..." if self[:excerpt].blank?
    self[:excerpt]
  end
end
