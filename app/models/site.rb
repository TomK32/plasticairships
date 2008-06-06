class Site < ActiveRecord::Base

  attr_protected :user_id, :published, :featured
  has_many :comments, :class_name => 'Site::Comment'
  belongs_to :user
  has_many :assets, :class_name => 'Site::Asset', :conditions => 'thumbnail IS NULL', :order => "site_assets.position ASC, site_assets.id ASC"
  has_one :screenshot, :class_name => 'Site::Asset', :conditions => 'thumbnail IS NULL', :order => "site_assets.position ASC, site_assets.id ASC"

  named_scope :published, :conditions => 'published = true', :order => 'id DESC'

  validates_presence_of :title
  validates_presence_of :permalink
  validates_presence_of :url
  validates_presence_of :description
  validates_length_of :description, :minimum => 40
  
  def before_validation
    self.permalink = PermalinkFu.escape(self.title) if self.permalink.blank?
    self.thumbnail_filename = nil
    self.thumbnail_filename = screenshot.public_filename(:thumb) unless screenshot.nil?
  end

  def after_create
    puts self.assets.inspect
    self.assets.each{|asset| asset.save! }
  end
  
  def after_save
    self.thumbnail_filename = assets.first.public_filename(:thumb) if self.thumbnail_filename.blank? and ! assets.empty?
  end
  
  def self.find_featured_published_with_screenshots(limit = 10)
    self.find_all_by_published_and_featured(true, true, :include => :screenshot, :limit => limit)
  end
  
  def self.find_published(per_page = 10, page = 1)
    return false if page.to_i < 1 and page != nil
    self.paginate :conditions => ['published = ?', true], :order => 'sites.id DESC', :per_page => per_page, :page => page
  end

  def to_param
    "#{id}-#{permalink}"
  end
  
  def thumbnail_url(request)
    request.protocol + request.host_with_port + self.thumbnail_filename
  end
  
  def url_short
    self.url.gsub('http://', '')
  end
end
