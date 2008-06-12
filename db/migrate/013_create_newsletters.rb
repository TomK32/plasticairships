class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table :newsletters do |t|
      t.column :title, :string, :null => false
      t.column :description, :text

      t.timestamps
    end
    
    create_table :newsletter_users do |t|
      t.column :user_id, :integer, :null => false
      t.column :newsletter_id, :integer, :null => false

      t.timestamps
    end
    add_index :newsletter_users, [:user_id, :newsletter_id], :unique => true
  end

  def self.down
    remove_index :newsletter_users, :column => [:user_id, :newsletter_id]
    remove_column :table_name, :column_name
    drop_table :newsletters
  end
end
