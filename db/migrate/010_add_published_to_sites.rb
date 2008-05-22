class AddPublishedToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :published, :boolean, :default => false
  end

  def self.down
    remove_column :sites, :published
  end
end
