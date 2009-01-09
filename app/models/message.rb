class Message < ActiveRecord::Base
  validates_presence_of :recipient_id, :sender_id, :subject, :body
end
