class Message < ActiveRecord::Base
  validates_presence_of :recipient_id, :sender_id, :subject, :body
  
  # can this be improved, without doing a select each time I need to find a user?
  # maybe all in one select when searching for messages.
  def find_user(user_id)
    user = User.find(user_id)
    user
  end
  
  def find_users(business_id)
    User.find(
      :all,
      :joins => :user_associations,
      :conditions => { 
        :user_associations => { :business_id => business_id }
      }
    ).map {|u| ["#{u.login}", u.id]}
  end
end
