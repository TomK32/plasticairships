class AddPermalinkToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :permalink, :string, :unique => true
  end

  def self.down
    remove_column :sites, :permalink
  end
end
