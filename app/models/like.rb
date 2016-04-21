class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :post
  belongs_to :comment

  after_create :create_notification

 def create_notification

if !self.post.nil?
   notification = Notification.new
   notification.user = self.post.user
   notification.title = self.user.first_name + " " + self.user.last_name
   notification.subtitle = "Has liked your post"
   notification.image = self.user.profile_picture
   notification.notification_type = 5
   notification.save
else
  notification = Notification.new
   notification.user = self.comment.user
   notification.title = self.user.first_name + " " + self.user.last_name
   notification.subtitle = "Has liked your comment"
   notification.image = self.user.profile_picture
   notification.notification_type = 6
   notification.save
 end

  end

  def self.like(post,user)
    Like.where(:user_id => user, :post_id => post).first_or_create(:user_id => user, :post_id => post)
  end

  def self.like_comment(comment,user)
    Like.where(:user_id => user, :comment_id => comment).first_or_create(:user_id => user, :comment_id => comment)
  end

end
