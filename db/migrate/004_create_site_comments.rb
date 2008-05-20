class CreateSiteComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :type, :string
    Comment.update_all('type = "Comment"')

    add_column :sites, :comments_count, :integer, :default => 0
  end

  def self.down
    remove_column :sites, :comments_count
    remove_column :comments, :site_id
  end
end
