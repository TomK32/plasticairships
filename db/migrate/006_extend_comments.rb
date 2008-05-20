class ExtendComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_name, :string
    add_column :comments, :subscribed, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :subscribed
    remove_column :comments, :user_name
  end
end
