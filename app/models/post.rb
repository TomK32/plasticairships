class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  def self.find_published_posts(*args)
    find(:all, :conditions => ['published = ? AND published_at < ?', true, Time.now], *args)    
  end
end
