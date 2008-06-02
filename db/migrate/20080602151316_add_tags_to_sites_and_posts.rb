class AddTagsToSitesAndPosts < ActiveRecord::Migration
  def self.up
    create_table :tags, :force => true do |t|
      t.column :name, :string, :null => false
      t.column :created_at, :datetime
    end

    create_table :site_tags, :force => true do |t|
      t.column :tag_id, :integer, :null => false
      t.column :site_id, :integer, :null => false
    end
    add_index :site_tags, [:tag_id, :site_id], :unique => true

    create_table :post_tags, :force => true do |t|
      t.column :tag_id, :integer, :null => false
      t.column :post_id, :integer, :null => false
    end
    add_index :post_tags, [:tag_id, :post_id], :unique => true
  end

  def self.down
    drop_table :post_tags
    drop_table :site_tags
    drop_table :tags
  end
end
