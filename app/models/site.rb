class Site < ActiveRecord::Base

  attr_protected :user_id, :published, :featured
  belongs_to :user
  belongs_to :bookmark_account

  has_many :comments, :class_name => 'Site::Comment', :dependent => :destroy
  has_many :assets, :class_name => 'Site::Asset', :conditions => 'thumbnail IS NULL', :order => "site_assets.position ASC, site_assets.id ASC", :dependent => :delete_all
  has_one :screenshot, :class_name => 'Site::Asset', :conditions => 'thumbnail IS NULL', :order => "site_assets.position ASC, site_assets.id ASC"

  acts_as_taggable
  named_scope :published, :conditions => {:published => true}, :order => 'id DESC'

  validates_presence_of :title
  validates_presence_of :permalink
  validates_presence_of :url
#  validates_presence_of :description
  validates_presence_of :user_id
#  validates_length_of :description, :minimum => 40
  
  def before_validation
    self.permalink = PermalinkFu.escape(self.url_short.gsub('www.', '')) if self.permalink.blank?
    self.thumbnail_filename = self.screenshot.nil? ? nil : self.screenshot.public_filename(:thumb) 
  end

  def after_create
    self.assets.each{|asset| asset.save! }
  end
  
  def after_save
    self.thumbnail_filename = assets.first.public_filename(:thumb) if self.thumbnail_filename.blank? and ! assets.empty?
  end

  def to_param
    "#{id}-#{permalink}"
  end
  
  def thumbnail_url(request)
    return false if self.thumbnail_filename.blank?
    request.protocol + request.host_with_port + self.thumbnail_filename
  end
  
  def url_short
    self.url.gsub('http://', '')
  end
end
