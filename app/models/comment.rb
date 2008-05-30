class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, :counter_cache => true
  belongs_to :parent_comment, :class_name => 'Comment'

  attr_protected :post_id, :user_id, :published

  validates_presence_of :post_id, :body, :user_name, :user_email

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
