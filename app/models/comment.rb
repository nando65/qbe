class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

#after_create :create_notification

  def comment(user_id, post_id, comment)
    Comment.create user_id: user_id, post_id: post_id, commentary: comment

  end

  def delete_comment(comment_id)
    Comment.find_by(id: comment_id).destroy
  end


  def create_notifcation

    notification = Notification.new
    notification.user = self.post.user
    notification.title = self.user.first_name+" "+self.user.last_name
    notification.subtitle = "Is now following you"
    notification.image = self.user.profile_picture
    notification.type = 3
    notification.save

  end

end
