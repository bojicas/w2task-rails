class CreateEfforts < ActiveRecord::Migration
  def self.up
    create_table :efforts do |t|
      t.text :body
      t.datetime :start
      t.datetime :stop

      t.timestamps
    end
  end

  def self.down
    drop_table :efforts
  end
end
