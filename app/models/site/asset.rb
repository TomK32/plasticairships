class Site::Asset < ActiveRecord::Base
  attr_protected :user_id

  belongs_to :user
  belongs_to :site

  validates_presence_of :user_id
  validates_presence_of :site_id
  
  has_attachment :storage => :file_system, :thumbnails => { :thumb => '200>', :tiny => '50x50!' },
    :max_size => 2.megabytes, :content_type => :image

  validates_as_attachment
  before_thumbnail_saved do |record, thumbnail|
    thumbnail.user_id ||= record.user_id
    thumbnail.site_id ||= record.site_id
  end

end
