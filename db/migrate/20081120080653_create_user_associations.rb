class CreateUserAssociations < ActiveRecord::Migration
  def self.up
    create_table :user_associations do |t|
      t.integer :user_id
      t.integer :business_id
      t.boolean :administrator

      t.timestamps
    end
  end

  def self.down
    drop_table :user_associations
  end
end
