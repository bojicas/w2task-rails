class AddUserIdToEffort < ActiveRecord::Migration
  def self.up
    add_column :efforts, :user_id, :integer
  end

  def self.down
    remove_column :efforts, :user_id
  end
end
