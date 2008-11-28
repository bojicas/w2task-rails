class AddBillableToEffort < ActiveRecord::Migration
  def self.up
    add_column :efforts, :billable, :boolean, :default => false
  end

  def self.down
    remove_column :efforts, :billable
  end
end
