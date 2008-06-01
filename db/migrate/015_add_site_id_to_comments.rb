class AddSiteIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :site_id, :integer
    change_column :comments, :post_id, :integer
  end

  def self.down
    remove_column :comments, :site_id
  end
end
