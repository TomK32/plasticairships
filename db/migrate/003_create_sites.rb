class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.column :title, :string, :null => false
      t.column :url, :string, :null => false
      t.column :owner, :string, :null => false
      t.column :descripion, :text, :null => false
      t.column :user_id, :integer, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
