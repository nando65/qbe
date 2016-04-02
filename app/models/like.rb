class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  after_create :create_notification

 def create_notification

   notification = Notification.new
   notification.user = self.post.user
   notification.title = self.user.first_name + " " + self.user.last_name
   notification.subtitle = "Has liked your post"
   notification.image = self.user.profile_picture
   notification.type = 5
   notification.save

  end

  def self.like(user,post)

    Like.where(:user_id => user, :post_id => post).first_or_create(:user_id => user, :post_id => post)

  end

end
