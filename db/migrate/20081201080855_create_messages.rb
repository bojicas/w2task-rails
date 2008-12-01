class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :subject
      t.text :body
      t.integer :message_type
      t.boolean :readed

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
