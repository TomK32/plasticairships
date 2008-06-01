class Post::Comment < Comment
  validates_presence_of :post_id
  belongs_to :post, :counter_cache => 'comments_count'
end
