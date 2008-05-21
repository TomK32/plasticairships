class AddCommentsCountToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :comments_count, :integer, :default => 0
    execute 'UPDATE posts SET comments_count = (SELECT count(comments.post_id) FROM comments WHERE posts.id = comments.post_id)'
  end

  def self.down
    remove_column :posts, :comments_count
  end
end
