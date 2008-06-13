class CreateBookmarkAccounts < ActiveRecord::Migration
  def self.up
    create_table :bookmark_accounts do |t|
      t.column :user_id, :integer, :null => false
      t.column :service, :string
      t.column :login, :string
      t.column :tags, :string

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmark_accounts
  end
end
