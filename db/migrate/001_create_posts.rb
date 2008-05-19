class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.column :title, :string, :null => false
      t.column :excerpt, :string, :null => false
      t.column :body, :text, :null => false
      t.column :published_at, :datetime, :null => false
      t.column :published, :boolean, :default => false
      t.column :permalink, :string, :null => false      
      t.column :user_id, :integer, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
