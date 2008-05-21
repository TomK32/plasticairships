class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :parent_comment, :class_name => 'Comment'

  attr_protected :post_id, :user_id, :published

  validates_presence_of :post_id, :body, :published

  # caching :-)
  def before_validation
    unless user.nil?
      self.user_name = user.name
      self.user_email = user.email
      self.user_website = user.website
    end
  end
end
