class Site < ActiveRecord::Base
  attr_protected :user_id, :published
  has_many :comments
  belongs_to :user
  
  validates_presence_of :title
  validates_presence_of :permalink
  validates_presence_of :url
  validates_presence_of :description
  validates_length_of :description, :minimum => 40
  
  def before_validation
    self.permalink = PermalinkFu.escape(self.title) if self.permalink.blank?
  end
  
  def thumbnail
    "%d-%s.jpg" % [self.id, self.permalink]
  end
end
