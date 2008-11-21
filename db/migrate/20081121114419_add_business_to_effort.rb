class AddBusinessToEffort < ActiveRecord::Migration
  def self.up
    add_column :efforts, :business_id, :integer
  end

  def self.down
    remove_column :efforts, :business_id
  end
end
