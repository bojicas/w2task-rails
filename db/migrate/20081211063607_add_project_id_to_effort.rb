class AddProjectIdToEffort < ActiveRecord::Migration
  def self.up
    add_column :efforts, :project_id, :integer
  end

  def self.down
    remove_column :efforts, :project_id
  end
end
