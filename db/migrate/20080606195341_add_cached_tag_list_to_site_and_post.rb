class AddCachedTagListToSiteAndPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :cached_tag_list, :string, :default => ""
    add_column :sites, :cached_tag_list, :string, :default => ""
  end

  def self.down
    remove_column :sites, :cached_tag_list
    remove_column :posts, :cached_tag_list
  end
end
