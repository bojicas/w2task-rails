class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :business_id
      t.boolean :accepted

      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
