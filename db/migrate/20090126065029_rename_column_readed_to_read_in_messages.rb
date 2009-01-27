class RenameColumnReadedToReadInMessages < ActiveRecord::Migration
  def self.up
    rename_column :messages, :readed, :read
  end

  def self.down
    rename_column :messages, :read, :readed
  end
end
