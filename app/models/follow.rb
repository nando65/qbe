class Follow < ActiveRecord::Base

  belongs_to :subject, foreign_key: :subject_id, class_name: 'User'
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
  belongs_to :affinity

  #after_create :create_notification

  def self.follow(subject,follower, accepted, affinity)

    follow.subject = subject
    follow.follower = follower
    follow.accepted = accepted #falta evaluar este caso! No se como manejar el tema de los approvals
    follow.affinity = affinity

  end

  def unfollow(follow_id)

    follow_id.destroy

  end
   def create_post

    post = Post.new
    post.user = self.subject
    post.title = self.follower.first_name+" "+self.follower.last_name
    post.subtitle = "Is now following "+self.subject
    post.image = self.follower.profile_picture
    post.share=0
    post.save

  end

  def create_notifcation

    notification = Notification.new
    notification.user = self.subject
    notification.title = self.follower.first_name+" "+self.follower.last_name
    notification.subtitle = "Is now following you"
    notification.image = self.follower.profile_picture
    notification.type = 1
    notification.save

  end

end
