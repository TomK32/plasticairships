class Comment < ActiveRecord::Base
  belongs_to :user

  attr_protected :post_id, :site_id, :user_id, :published

  validates_presence_of :body, :user_name, :user_email

  named_scope :published, :conditions => {:published => true}
  named_scope :unpublished, :conditions => {:published => false}
  named_scope :recent, :order => 'id DESC'

  # caching :-)
  def before_validation
    unless user.nil?
      self[:user_name] = user.name
      self[:user_email] = user.email
      self[:user_website] = user.website
    end
  end
  
  def short_info
    "%s on %s: %s" % [self.user_name, self.created_at.to_s(:long), self.body[/.{0,40}\w*?/]]
  end
end

require 'post/comment'
require 'site/comment'
