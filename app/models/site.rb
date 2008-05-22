class Site < ActiveRecord::Base
  attr_protected :user_id, :published
  has_many :comments, :class_name => 'Site::Comment', :foreign_key => 'post_id'
  belongs_to :user
  
  validates_presence_of :title
  validates_presence_of :permalink
  validates_presence_of :url
  validates_presence_of :description
  validates_length_of :description, :minimum => 40
  
  def self.find_published_sites(per_page = 10, page = 1)
    return false if page.to_i < 1 and page != nil
    self.paginate :conditions => ['sites.published = ?', true],
      :order => 'sites.id DESC', :per_page => per_page, :page => page
  end

  def before_validation
    self.permalink = PermalinkFu.escape(self.title) if self.permalink.blank?
  end
  
  def thumbnail
    "%d-%s.jpg" % [self.id, self.permalink]
  end
end
