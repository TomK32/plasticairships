class AddThumbnailFilenameToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :thumbnail_filename, :string
  end

  def self.down
    remove_column :sites, :thumbnail_filename
  end
end
