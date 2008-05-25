class Site::Asset < ActiveRecord::Base
  belongs_to :user
  attr_protected :user_id
    validates_presence_of :user_id
  
  belongs_to :site
  
  acts_as_list :scope => :site
  
  has_attachment :storage => :file_system, :thumbnails => { :thumb => '200>', :tiny => '50x50' },
    :max_size => 2.megabytes, :content_type => :image

  validates_as_attachment
  before_thumbnail_saved do |record, thumbnail|
    thumbnail.user ||= record.user
  end

end
