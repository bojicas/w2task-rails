class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string :nick
      t.string :name
      t.text :description
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :businesses
  end
end
