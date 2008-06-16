class Post < ActiveRecord::Base
  
  attr_protected :user_id, :published

  has_many :comments, :class_name => 'Post::Comment', :dependent => :destroy
  belongs_to :user

  acts_as_taggable
  named_scope :published, lambda {{:conditions => ['published = ? AND posts.published_at <= ?', true, DateTime.now.utc], :order => 'posts.published_at DESC'}}

  validates_presence_of :published_at
  validates_presence_of :body
  validates_length_of :body, :minimum => 20
  validates_presence_of :title
  validates_presence_of :permalink
  validates_presence_of :user_id

  def to_param
    "#{id}-#{permalink}"
  end

  def before_validation
    self.permalink = PermalinkFu.escape(self.title) if self.permalink.blank?
  end

  def excerpt
    return self[:excerpt] unless self[:excerpt].blank?
    return self[:body] if self[:body].length < 150
    return self[:body][/.{0,150}\w*/] + "..." if self[:excerpt].blank?
  end
end
