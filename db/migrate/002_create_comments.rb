class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :post_id, :integer, :null => false
      t.column :parent_comment_id, :integer
      t.column :title, :string      
      t.column :body, :text, :null => false
      t.column :user_id, :integer, :null => false
      t.column :user_email, :string
      t.column :user_website, :string
      t.column :published, :boolean, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
