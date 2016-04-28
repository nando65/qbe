class Follow < ActiveRecord::Base

  belongs_to :subject, foreign_key: :subject_id, class_name: 'User'
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
  belongs_to :affinity
  scope :wait_acceptance, -> {where ( 'affinity_id is not null')}
  after_create :create_notification

  def self.follow(subject, follower, affinity)
    Follow.where(:subject_id => subject, :follower_id => follower, :affinity_id => affinity).first_or_create(:subject_id => subject, :follower_id => follower, :affinity_id => affinity)
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
    post.follower_id = self.follower.id
    post.share=0
    post.save
  end
  def create_notification
    if self.follower != self.subject
    notification = Notification.new
    notification.user = self.subject
    notification.title = self.follower.first_name+" "+self.follower.last_name
    notification.subtitle = "Is now following you"
    notification.image = self.follower.profile_picture
    notification.notification_type = 7
    notification.follower_id = self.follower.id
    notification.save
    end
  end
end
