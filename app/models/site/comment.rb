class Site::Comment < Comment
  belongs_to :site, :counter_cache => true
end
