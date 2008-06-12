class Site::Comment < Comment
  validates_presence_of :site_id
  belongs_to :site, :counter_cache => 'comments_count'

  belongs_to :parent_comment, :class_name => 'Site::Comment'
end
