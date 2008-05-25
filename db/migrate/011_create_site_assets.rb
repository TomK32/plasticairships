class CreateSiteAssets < ActiveRecord::Migration
  def self.up
    create_table :site_assets do |t|
      t.column :size, :integer
      t.column :content_type, :string
      t.column :filename, :string, :null => false
      t.column :height, :integer
      t.column :width, :integer
      t.column :parent_id, :integer
      t.column :thumbnail, :string

      t.column :user_id, :integer, :null => false
      t.column :site_id, :integer
      t.column :position, :integer, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
