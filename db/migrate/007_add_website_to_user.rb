class AddWebsiteToUser < ActiveRecord::Migration
  def self.up
    add_column User.table_name, :website, :string
  end

  def self.down
    remove_column :website, :column_name
  end
end
